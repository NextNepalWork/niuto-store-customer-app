import 'package:flutter_kundol/index/index.dart';

class MyAddressScreen extends StatefulWidget {
  MyAddressScreen();

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<MyAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title:
            Text("Address book", style: Theme.of(context).textTheme.headline6),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<AddressBloc, AddressState>(
              bloc: BlocProvider.of<AddressBloc>(context),
              builder: (context, state) {
                if (state is AddressLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AddressLoaded) {
                  if (state.addressData.isNotEmpty)
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.addressData.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ListTile(
                          horizontalTitleGap: 0.0,
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor:
                              Theme.of(context).brightness != Brightness.dark
                                  ? const Color(0xfff2f2f2)
                                  : Colors.black,
                          onTap: () {
                            if (state.addressData[index].defaultAddress != 1)
                              BlocProvider.of<AddressBloc>(context).add(
                                  SetDefaultAddress(
                                      state.addressData[index].id,
                                      state.addressData[index].customer
                                          .customerFirstName,
                                      state.addressData[index].customer
                                          .customerLastName,
                                      state.addressData[index].gender,
                                      state.addressData[index].company,
                                      state.addressData[index].streetAddress,
                                      state.addressData[index].suburb,
                                      state.addressData[index].postcode,
                                      state.addressData[index].dob,
                                      state.addressData[index].city,
                                      state.addressData[index].countryId
                                          .countryId,
                                      state
                                          .addressData[index].stateId.countryId,
                                      state.addressData[index].lattitude,
                                      state.addressData[index].longitude,
                                      state.addressData[index].phone));
                          },
                          enabled: true,
                          isThreeLine: true,
                          leading: CircleAvatar(
                            child: Icon(Icons.location_on,
                                size: 30, color: Colors.white),
                            radius: 50,
                          ),
                          trailing: (state.addressData[index].defaultAddress ==
                                  1)
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                        create: (context) =>
                                                            AddAddressBookBloc(
                                                                RealAddressRepo())),
                                                    BlocProvider(
                                                        create: (context) =>
                                                            CountriesBloc(
                                                                RealCountriesRepo())),
                                                  ],
                                                  child: AddAddressBookScreen(
                                                      state.addressData[index]),
                                                );
                                              },
                                            ));
                                          },
                                          child: Icon(Icons.edit)),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            BlocProvider.of<AddressBloc>(
                                                    context)
                                                .add(DeleteAddress(state
                                                    .addressData[index].id));
                                          },
                                          child: Icon(Icons.delete)),
                                    ],
                                  ),
                                )
                              : null,
                          title: Text(state.addressData[index].customer
                                  .customerFirstName +
                              " " +
                              state.addressData[index].customer
                                  .customerLastName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(state.addressData[index].city),
                              Text(state.addressData[index].streetAddress),
                            ],
                          ),
                        ),
                      ),
                    );
                  else
                    return Center(child: Text("Empty"));
                } else if (state is AddressError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container();
                }
              },
              listener: (context, state) {
                if (state is AddressError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: "Add New Address",
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) =>
                          AddAddressBookBloc(RealAddressRepo())),
                  BlocProvider(
                      create: (context) => CountriesBloc(RealCountriesRepo())),
                ],
                child: AddAddressBookScreen(null),
              );
            },
          ));
        },
      ),
    );
  }
}
