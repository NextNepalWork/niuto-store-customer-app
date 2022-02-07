import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/add_address/add_address_bloc.dart';
import 'package:flutter_kundol/constants/app_config.dart';

import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/models/cart_data.dart';
import 'package:flutter_kundol/models/country.dart';
import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/ui/payment_screen.dart';
import 'package:flutter_kundol/blocs/countries/countries_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class AddAddressScreen extends StatefulWidget {
  final List<CartData> cartItems;
  final CouponData couponData;

  AddAddressScreen(this.cartItems, this.couponData);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddressScreen> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _postCodeController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  double latitude = 0.0, longitude = 0.0;
  CountryData selectedCountry;
  States selectedState;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountriesBloc>(context).add(GetCountries());
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
      body: BlocListener<AddAddressBloc, AddAddressState>(
        listener: (context, state) {
          if (state is AddAddressLoaded) {
            //BlocProvider.of<AddressBloc>(context).add(GetAddress());
            AddressData addressData = AddressData();
            addressData.customer = AddressCustomer();
            addressData.customer.customerFirstName = _firstNameController.text;
            addressData.customer.customerLastName = _lastNameController.text;
            addressData.streetAddress = _addressController.text;
            addressData.city = _cityController.text;
            addressData.phone = _phoneController.text;
            addressData.postcode = _postCodeController.text;
            addressData.lattitude = latitude.toString();
            addressData.longitude = longitude.toString();
            CountryId countryId = CountryId();
            countryId.countryName = selectedCountry.countryName;
            countryId.countryId = selectedCountry.countryId;
            addressData.countryId = countryId;
            StateId stateId = StateId();
            stateId.name = selectedState.name;
            stateId.id = selectedState.id;
            addressData.stateId = stateId;

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                      widget.cartItems, widget.couponData, addressData)),
            );
          } else if (state is AddAddressError) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                borderRadius: BorderRadius.circular(8),
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
                                borderRadius: BorderRadius.circular(8),
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
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.only(left: 15, right: 15),
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
                                SizedBox(
                                  height: 10,
                                ),
                                if (selectedCountry != null)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_LITE_GREY_DARK
                                          : AppStyles.COLOR_LITE_GREY_LIGHT,
                                      borderRadius: BorderRadius.circular(8),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey: AppConfig.PLACE_PICKER_API_KEY,
                                onPlacePicked: (result) {
                                  print(result.geometry.location.lat
                                          .toString() +
                                      "---" +
                                      result.geometry.location.lng.toString());
                                  setState(() {
                                    latitude = result.geometry.location.lat;
                                    longitude = result.geometry.location.lng;

                                    _addressController.text =
                                        result.formattedAddress;
                                  });
                                  Navigator.of(context).pop();
                                },
                                initialPosition: LatLng(0.0, 0.0),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            (latitude == null)
                                ? "Location"
                                : latitude.toString() +
                                    ", " +
                                    longitude.toString(),
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 12),
                          ),
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
                          borderRadius: BorderRadius.circular(8),
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
                          borderRadius: BorderRadius.circular(8),
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
                          borderRadius: BorderRadius.circular(8),
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
                          borderRadius: BorderRadius.circular(8),
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
                    if (latitude != null)
                      BlocProvider.of<AddAddressBloc>(context).add(
                        AddAddress(
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
                            latitude.toString(),
                            longitude.toString(),
                            _phoneController.text),
                      );
                    else
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please select Location")));
                  },
                  child: Text("Save & Continue")),
            ),
          ],
        ),
      ),
    );
  }
}
