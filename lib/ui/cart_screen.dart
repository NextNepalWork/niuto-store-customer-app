// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/coupon_data.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/ui/login_screen.dart';
import 'package:flutter_kundol/ui/shipping_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _couponTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(GetCart());
  }

  @override
  Widget build(BuildContext context) {
    CouponData couponData;

    double subtotal = 0;
    double shipping = 0;
    double discount = 0;
    double tax = 0;
    double orderTotal = 0;

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Cart", style: Theme.of(context).textTheme.headline6),
        elevation: 4,
      ),
      body: BlocConsumer(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is CartCouponError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            BlocProvider.of<CartBloc>(context).add(GetCart());
          } else if (state is CartDeleted) {
            BlocProvider.of<CartBloc>(context).add(GetCart());
          } else if (state is CouponApplied) {
            couponData = state.couponData;
            BlocProvider.of<CartBloc>(context).add(GetCart());
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Coupon Added Successfully")));
          }
        },
        bloc: BlocProvider.of<CartBloc>(context),
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.cartData.isNotEmpty) {
              subtotal = 0;
              shipping = 0;
              tax = 0;
              orderTotal = 0;
              for (int i = 0; i < state.cartData.length; i++) {
                subtotal += (double.parse(state.cartData[i].price.toString()) *
                    state.cartData[i].qty);
                //shipping = 0;
                //tax = 0;
                orderTotal = subtotal;
              }
              if (couponData != null) if (couponData.type ==
                  AppConstants.COUPON_TYPE_FIXED) {
                discount = double.parse(couponData.amount.toString());
              } else if (couponData.type ==
                  AppConstants.COUPON_TYPE_PERCENTAGE) {
                discount = (double.parse(couponData.amount.toString()) / 100) *
                    subtotal;
              }
              orderTotal = orderTotal - discount;
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black.withOpacity(.2)
                                    : Color(0xfff2f2f2),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.cartData.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppStyles.CARD_RADIUS),
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 70,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppStyles.CARD_RADIUS),
                                                child: CachedNetworkImage(
                                                  imageUrl: ApiProvider
                                                          .imgMediumUrlString +
                                                      state
                                                          .cartData[index]
                                                          .productGallary
                                                          .gallaryName,
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      Center(
                                                          child: CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress)),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      state
                                                          .cartData[index]
                                                          .productDetail[0]
                                                          .title
                                                          .trim(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "MontserratSemiBold"),
                                                    ),
                                                  ),
                                                  Text(
                                                    AppData.currency.code +
                                                        " " +
                                                        double.tryParse(state
                                                                .cartData[index]
                                                                .price
                                                                .toString())
                                                            .toStringAsFixed(2),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  RichText(
                                                      text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Category:  ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .copyWith(
                                                              fontSize: 11),
                                                    ),
                                                    TextSpan(
                                                        text: state
                                                            .cartData[index]
                                                            .categoryDetail
                                                            .first
                                                            .categoryDetail
                                                            .detail
                                                            .first
                                                            .name,
                                                        style: TextStyle(
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? AppStyles
                                                                    .COLOR_GREY_DARK
                                                                : AppStyles
                                                                    .COLOR_GREY_LIGHT,
                                                            fontSize: 11)),
                                                  ])),
                                                  RichText(
                                                      text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Quantity:  ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .copyWith(
                                                              fontSize: 11),
                                                    ),
                                                    TextSpan(
                                                        text: state
                                                            .cartData[index].qty
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? AppStyles
                                                                    .COLOR_GREY_DARK
                                                                : AppStyles
                                                                    .COLOR_GREY_LIGHT,
                                                            fontSize: 11)),
                                                  ])),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: Icon(
                                              Icons.delete_forever_outlined),
                                          onPressed: () {
                                            BlocProvider.of<CartBloc>(context)
                                                .add(DeleteCartItem(
                                                    state.cartData[index]
                                                        .productId,
                                                    state.cartData[index]
                                                        .productCombinationId
                                                        .toString()));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 15);
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Divider(
                                //   thickness: 1,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 15.0),
                                  child: Text(
                                    "Order Summary:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      AppStyles.CARD_RADIUS),
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Estimated Shipping:"),
                                            Text(
                                                AppData.currency.code + "0.00"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Tax:"),
                                            Text(
                                                AppData.currency.code + "0.00"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Discount:"),
                                            Text(AppData.currency.code +
                                                discount.toStringAsFixed(2)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Order Total:"),
                                            Text(
                                              AppData.currency.code +
                                                  orderTotal.toStringAsFixed(2),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      AppStyles.CARD_RADIUS),
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Promo Code / Vouchers",
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.0),
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width:
                                                          1.0), // set border width
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          5.0)), // set rounded corner radius
                                                ),
                                                child: TextField(
                                                  controller:
                                                      _couponTextController,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 15),
                                                    border: InputBorder.none,
                                                    hintText: "Enter Code Here",
                                                    hintStyle: TextStyle(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? AppStyles
                                                                .COLOR_GREY_DARK
                                                            : AppStyles
                                                                .COLOR_GREY_LIGHT,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                child: Row(
                                                  children: [
                                                    if (discount != 0)
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _couponTextController
                                                                  .clear();
                                                              discount = 0.0;
                                                            });
                                                          },
                                                          child:
                                                              Text("Remove")),
                                                    SizedBox(width: 8.0),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          if (_couponTextController
                                                              .text
                                                              .toString()
                                                              .trim()
                                                              .isNotEmpty) {
                                                            BlocProvider.of<
                                                                        CartBloc>(
                                                                    context)
                                                                .add(ApplyCoupon(
                                                                    _couponTextController
                                                                        .text
                                                                        .toString()
                                                                        .trim()));
                                                          }
                                                        },
                                                        child: Text(
                                                          "Apply",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          )
                        ],
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (AppData.user != null)
                                    ? BlocProvider(
                                        create: (BuildContext context) {
                                          return AddressBloc(RealAddressRepo())
                                            ..add(GetAddress());
                                        },
                                        child: ShippingScreen(
                                            state.cartData, couponData))
                                    : SignIn(),
                              ));
                        },
                        child: Text(
                          "Proceed to Checkout",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              );
            } else {
              return Center(child: Text("Empty"));
            }
          } else if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
