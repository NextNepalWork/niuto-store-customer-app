import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/add_addressbook/add_addressbook_bloc.dart';

import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_kundol/models/country.dart';

class AddAddressBookScreen extends StatefulWidget {
  final AddressData addressData;

  AddAddressBookScreen(this.addressData);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressBookScreen> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _postCodeController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  CountryData selectedCountry;
  States selectedState;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountriesBloc>(context).add(GetCountries());
    if (widget.addressData != null) {
      _firstNameController.text = widget.addressData.customer.customerFirstName;
      _lastNameController.text = widget.addressData.customer.customerLastName;
      _addressController.text = widget.addressData.streetAddress;
      _cityController.text = widget.addressData.city;
      _postCodeController.text = widget.addressData.postcode;
      _phoneController.text = widget.addressData.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title:
            Text("Add Address", style: Theme.of(context).textTheme.headline6),
        elevation: 4.0,
      ),
      body: BlocListener<AddAddressBookBloc, AddAddressBookState>(
        listener: (context, state) {
          if (state is AddAddressBookLoaded) {
            AddressData addressData = AddressData();
            addressData.customer = AddressCustomer();
            addressData.customer.customerFirstName = _firstNameController.text;
            addressData.customer.customerLastName = _lastNameController.text;
            addressData.streetAddress = _addressController.text;
            addressData.city = _cityController.text;
            addressData.phone = _phoneController.text;
            addressData.postcode = _postCodeController.text;

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.addAddressResponse.message)));
            Navigator.pop(context);
          } else if (state is AddAddressBookError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                      horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                  hintText: "First Name",
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 12),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Your First name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  hintText: "Last Name",
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 12),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Your Last Name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<CountriesBloc, CountriesState>(
                        builder: (context, state) {
                          if (state is CountriesLoaded) {
                            List<CountryData> countryDataList =
                                state.countriesResponse.data;
                            CountryData otherCountryData = CountryData();
                            otherCountryData.countryName = "Other";
                            otherCountryData.countryId = 0;
                            otherCountryData.states = [];
                            countryDataList.add(otherCountryData);

                            return Column(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_LITE_GREY_DARK
                                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                  ),
                                  child: DropdownSearch<CountryData>(
                                    mode: Mode.DIALOG,
                                    showSearchBox: true,
                                    // ignore: deprecated_member_use
                                    label: "Country",
                                    items: state.countriesResponse.data,
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Last Name",
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12),
                                      border: InputBorder.none,
                                    ),
                                    itemAsString: (CountryData u) =>
                                        u.countryName,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCountry = value;
                                        States otherState = States();
                                        otherState.id = 0;
                                        otherState.name = "Other";
                                        selectedCountry.states.add(otherState);
                                      });
                                    },
                                  ),
                                ),
                                if (selectedCountry != null)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_LITE_GREY_DARK
                                          : AppStyles.COLOR_LITE_GREY_LIGHT,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: DropdownSearch<States>(
                                      mode: Mode.DIALOG,
                                      showSearchBox: true,
                                      // ignore: deprecated_member_use
                                      label: "State",
                                      items: selectedCountry.states,
                                      itemAsString: (States u) => u.name,
                                      dropdownSearchDecoration: InputDecoration(
                                        hintText: "Last Name",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 12),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedState = value;
                                        });
                                      },
                                    ),
                                  ),
                                if (selectedCountry != null)
                                  Divider(
                                    color: Colors.grey[400],
                                  ),
                              ],
                            );
                          } else if (state is CountriesLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Center(child: Text("Something went wrong"));
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_LITE_GREY_DARK
                              : AppStyles.COLOR_LITE_GREY_LIGHT,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 12),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Your Address';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_LITE_GREY_DARK
                              : AppStyles.COLOR_LITE_GREY_LIGHT,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            hintText: "City",
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 12),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select Your City';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_LITE_GREY_DARK
                              : AppStyles.COLOR_LITE_GREY_LIGHT,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: "Phone*",
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 12),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Your Phone';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_LITE_GREY_DARK
                              : AppStyles.COLOR_LITE_GREY_LIGHT,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: _postCodeController,
                          decoration: InputDecoration(
                            hintText: "Post Code",
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 12),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Your Zip Code';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                  horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ))),
                  onPressed: () {
                    if (widget.addressData == null)
                      BlocProvider.of<AddAddressBookBloc>(context).add(
                        AddAddressBook(
                            _firstNameController.text,
                            _lastNameController.text,
                            "Male",
                            "company",
                            _addressController.text,
                            "suburb",
                            _postCodeController.text,
                            "1994-12-12",
                            _cityController.text,
                            161,
                            168,
                            "123",
                            "123",
                            _phoneController.text),
                      );
                    else
                      BlocProvider.of<AddAddressBookBloc>(context).add(
                        UpdateAddressBook(
                            widget.addressData.id,
                            _firstNameController.text,
                            _lastNameController.text,
                            "Male",
                            "company",
                            _addressController.text,
                            "suburb",
                            _postCodeController.text,
                            "1994-12-12",
                            _cityController.text,
                            selectedCountry.countryId,
                            selectedState.id,
                            "123",
                            "123",
                            _phoneController.text),
                      );
                  },
                  child: Text("Save & Continue")),
            ),
          ],
        ),
      ),
    );
  }
}
