import 'package:flutter_kundol/index/index.dart';

class ShippingScreen extends StatefulWidget {
  final List<CartData> cartItems;
  final CouponData couponData;

  ShippingScreen(this.cartItems, this.couponData);

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<ShippingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Shipping", style: Theme.of(context).textTheme.headline6),
        elevation: 4,
      ),
      body: Column(
        children: [
          BlocBuilder<AddressBloc, AddressState>(
            bloc: BlocProvider.of<AddressBloc>(context),
            builder: (context, state) {
              if (state is AddressLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is AddressLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.addressData.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: Theme.of(context).brightness != Brightness.dark
                          ? const Color(0xfff2f2f2)
                          : Colors.black,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen(
                                  widget.cartItems,
                                  widget.couponData,
                                  state.addressData[index])),
                        );
                      },
                      enabled: true,
                      isThreeLine: true,
                      leading: CircleAvatar(
                        child: Icon(Icons.location_pin,
                            size: 30, color: Colors.white),
                        radius: 50,
                      ),
                      title: Text(state
                              .addressData[index].customer.customerFirstName +
                          " " +
                          state.addressData[index].customer.customerLastName),
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
              } else if (state is AddressError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
                return Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(create: (BuildContext context) {
                            return AddAddressBloc(RealAddressRepo());
                          }),
                          BlocProvider(
                              create: (context) =>
                                  CountriesBloc(RealCountriesRepo())),
                        ],
                        child: AddAddressScreen(
                            widget.cartItems, widget.couponData))),
          );
        },
      ),
    );
  }
}
