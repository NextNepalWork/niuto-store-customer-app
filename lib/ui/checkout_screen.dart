// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/address_data.dart';
import 'package:flutter_kundol/models/cart_data.dart';
import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/ui/thank_you_screen.dart';
import 'package:flutter_svg/svg.dart';

class CheckoutScreen extends StatefulWidget {
  final String title;
  final List<CartData> cartItems;
  final AddressData addressData;
  final String paymentMethod;
  final CouponData couponData;

  CheckoutScreen(this.cartItems, this.couponData, this.addressData,
      this.paymentMethod, this.title);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<CheckoutScreen> {
  TextEditingController _expMonthTextController = TextEditingController();
  TextEditingController _expYearTextController = TextEditingController();
  TextEditingController _cvcTextController = TextEditingController();
  TextEditingController _cardNumberTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double shipping = 0;
    double discount = 0;
    double tax = 0;
    double orderTotal = 0;

    for (int i = 0; i < widget.cartItems.length; i++) {
      subtotal += (double.parse(widget.cartItems[i].price.toString()) *
          widget.cartItems[i].qty);
      shipping = 0;
      tax = 0;
      orderTotal = subtotal;
    }

    if (widget.couponData != null) if (widget.couponData.type ==
        AppConstants.COUPON_TYPE_FIXED) {
      discount = double.parse(widget.couponData.amount.toString());
    } else if (widget.couponData.type == AppConstants.COUPON_TYPE_PERCENTAGE) {
      discount =
          (double.parse(widget.couponData.amount.toString()) / 100) * subtotal;
    }
    orderTotal = orderTotal - discount;

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Checkout: ${widget.title}",
            style: Theme.of(context).textTheme.headline6),
        elevation: 4.0,
      ),
      body: BlocListener<CheckoutBloc, CheckoutState>(
        listener: (BuildContext context, state) {
          if (state is CheckoutLoaded) {
            //Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThankYouScreen()),
            );
          } else if (state is CheckoutError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        //padding: EdgeInsets.only(left: 5, right: 5),
                        itemCount: widget.cartItems.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) => Card(
                          elevation: 0,
                          color: Theme.of(context).brightness != Brightness.dark
                              ? const Color(0xfff2f2f2)
                              : Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 10),
                                    child: SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppStyles.CARD_RADIUS),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              ApiProvider.imgMediumUrlString +
                                                  widget
                                                      .cartItems[index]
                                                      .productGallary
                                                      .gallaryName,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          width: 218,
                                          child: Text(
                                            widget.cartItems[index]
                                                .productDetail.first.title,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        // Text(
                                        //   "1, Black, Large",
                                        //   style: TextStyle(fontSize: 13),
                                        // ),
                                        Text(
                                          AppData.currency.code +
                                              " " +
                                              double.tryParse(widget
                                                      .cartItems[index].price
                                                      .toString())
                                                  .toStringAsFixed(2),
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Qty: " +
                                              widget.cartItems[index].qty
                                                  .toString(),
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 15);
                        },
                      ),
                      // Divider(
                      //   thickness: 4,
                      //   color: Color(0xFFE6E8E9),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor:
                            Theme.of(context).brightness != Brightness.dark
                                ? const Color(0xfff2f2f2)
                                : Colors.black,
                        onLongPress: () {},
                        enabled: true,
                        isThreeLine: true,
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0.0,
                        leading: CircleAvatar(
                          radius: 50,
                          child: SvgPicture.asset(
                            "assets/icons/ic_location.svg",
                            fit: BoxFit.none,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                            widget.addressData.customer.customerFirstName +
                                " " +
                                widget.addressData.customer.customerLastName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.addressData.streetAddress),
                            Text(widget.addressData.phone),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor:
                            Theme.of(context).brightness != Brightness.dark
                                ? const Color(0xfff2f2f2)
                                : Colors.black,
                        onLongPress: () {},
                        enabled: true,
                        isThreeLine: true,
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0.0,
                        leading: CircleAvatar(
                          radius: 50,
                          child: SvgPicture.asset(
                            "assets/icons/ic_location.svg",
                            fit: BoxFit.none,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                            widget.addressData.customer.customerFirstName +
                                " " +
                                widget.addressData.customer.customerLastName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.addressData.streetAddress),
                            Text(widget.addressData.phone),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness != Brightness.dark
                                    ? const Color(0xfff2f2f2)
                                    : Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal:"),
                                Text(AppData.currency.code +
                                    subtotal.toStringAsFixed(2)),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Discount:"),
                                Text(AppData.currency.code +
                                    discount.toStringAsFixed(2)),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Estimated Shipping:"),
                                Text(AppData.currency.code + "0.00"),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tax:"),
                                Text(AppData.currency.code + "0.00"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Order Total:"),
                                Text(
                                  AppData.currency.code +
                                      orderTotal.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: Color(0xFFF1435A),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 1,
                        color: Color(0xFFE6E8E9),
                      ),
                      if (widget.paymentMethod == "stripe")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " Card Details:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
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
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: TextFormField(
                                      controller: _expMonthTextController,
                                      decoration: InputDecoration(
                                        hintText: "Expiry Month",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
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
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: TextFormField(
                                      controller: _expYearTextController,
                                      decoration: InputDecoration(
                                        hintText: "Expiry Year",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                controller: _cvcTextController,
                                decoration: InputDecoration(
                                  hintText: "Card Cvc",
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                controller: _cardNumberTextController,
                                decoration: InputDecoration(
                                  hintText: "Card Number",
                                  hintStyle: TextStyle(fontSize: 14),
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
                            Divider(
                              color: Colors.grey[400],
                            ),
                          ],
                        )
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
              height: 50.0,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ))),
                  onPressed: () {
                    if (widget.paymentMethod == "stripe") {
                      if (_expYearTextController.text.isEmpty ||
                          _expMonthTextController.text.isEmpty ||
                          _cvcTextController.text.isEmpty ||
                          _cardNumberTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Input valid payment credentials")));
                      } else {
                        BlocProvider.of<CheckoutBloc>(context).add(PlaceOrder(
                            widget.addressData.customer.customerFirstName,
                            widget.addressData.customer.customerLastName,
                            widget.addressData.streetAddress,
                            widget.addressData.city,
                            widget.addressData.postcode,
                            widget.addressData.countryId.countryId,
                            widget.addressData.stateId.id,
                            widget.addressData.phone,
                            widget.addressData.customer.customerFirstName,
                            widget.addressData.customer.customerLastName,
                            widget.addressData.streetAddress,
                            widget.addressData.city,
                            widget.addressData.postcode,
                            widget.addressData.countryId.countryId,
                            widget.addressData.stateId.id,
                            widget.addressData.phone,
                            AppData.currency.currencyId,
                            AppData.language.id,
                            widget.paymentMethod,
                            widget.addressData.lattitude +
                                "," +
                                widget.addressData.longitude,
                            _cardNumberTextController.text,
                            _cvcTextController.text,
                            _expMonthTextController.text,
                            _expYearTextController.text));
                      }
                    } else
                      BlocProvider.of<CheckoutBloc>(context).add(PlaceOrder(
                          widget.addressData.customer.customerFirstName,
                          widget.addressData.customer.customerLastName,
                          widget.addressData.streetAddress,
                          widget.addressData.city,
                          widget.addressData.postcode,
                          widget.addressData.countryId.countryId,
                          widget.addressData.stateId.id,
                          widget.addressData.phone,
                          widget.addressData.customer.customerFirstName,
                          widget.addressData.customer.customerLastName,
                          widget.addressData.streetAddress,
                          widget.addressData.city,
                          widget.addressData.postcode,
                          widget.addressData.countryId.countryId,
                          widget.addressData.stateId.id,
                          widget.addressData.phone,
                          AppData.currency.currencyId,
                          AppData.language.id,
                          widget.paymentMethod,
                          widget.addressData.lattitude.toString() +
                              "," +
                              widget.addressData.longitude.toString(),
                          "",
                          "",
                          "",
                          ""));
                  },
                  child: Text(
                    "Place Order",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
