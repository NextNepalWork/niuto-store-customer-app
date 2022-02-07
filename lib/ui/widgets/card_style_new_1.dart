import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_svg/svg.dart';

import '../detail_screen.dart';

class CardStyleNew1 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Product product;
  final Color cardColor;

  const CardStyleNew1(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyleNew1State createState() => _CardStyleNew1State();
}

class _CardStyleNew1State extends State<CardStyleNew1> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.navigateToNext(
          BlocProvider(
              create: (context) =>
                  DetailScreenBloc(RealCartRepo(), RealProductsRepo()),
              child:
                  ProductDetailScreen(widget.product, widget.navigateToNext)),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
          color: widget.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: (widget.product.productGallary == null)
                    ? Container()
                    : Container(
                        width: double.maxFinite,
                        child: CachedNetworkImage(
                          imageUrl: ApiProvider.imgMediumUrlString +
                              widget.product.productGallary.gallaryName,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.detail.first.title.trim(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (widget.product.productDiscountPrice != 0) ?
                            Expanded(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    AppData.currency.code +
                                        double.parse(widget.product.productDiscountPrice
                                                .toString())
                                            .toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2.copyWith(
                                        fontFamily: "MontserratSemiBold"),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                      AppData.currency.code +
                                          double.parse(widget
                                                  .product.productPrice
                                                  .toString())
                                              .toStringAsFixed(2),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                        fontSize: 12.0,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    ),
                                ],
                              ),
                            ) : Text(
                              AppData.currency.code +
                                  double.parse(widget.product.productPrice
                                      .toString())
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: "MontserratSemiBold"),
                            ),

/*
                            (widget.product.productType ==
                                AppConstants.PRODUCT_TYPE_SIMPLE)
                                ? Row(
                                  children: [
                                    Text(
                                      AppData.currentCurrency +
                                          double.parse(widget
                                              .product.productPrice
                                              .toString())
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "MontserratSemiBold"),
                                    ),
                                    SizedBox(width: 8),
                                    if (widget
                                        .product.productDiscountPrice !=
                                        0)
                                      Text(
                                        AppData.currentCurrency +
                                            double.parse(widget.product
                                                .productDiscountPrice
                                                .toString())
                                                .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                            decoration: TextDecoration
                                                .lineThrough),
                                      ),
                                  ],
                                )
                                : RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: AppData.currentCurrency +
                                            double.tryParse(widget
                                                .product
                                                .productCombination
                                                .first
                                                .price
                                                .toString())
                                                .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      TextSpan(text: " - "),
                                      TextSpan(
                                        text: AppData.currentCurrency +
                                            double.tryParse(widget
                                                .product
                                                .productCombination
                                                .last
                                                .price
                                                .toString())
                                                .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ])),
*/
                            ButtonTheme(
                              height: 20.0,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      18.0)))),
                                  onPressed: () {
                                    widget.navigateToNext(
                                      BlocProvider(
                                          create: (context) => DetailScreenBloc(
                                              RealCartRepo(),
                                              RealProductsRepo()),
                                          child: ProductDetailScreen(
                                              widget.product,
                                              widget.navigateToNext)),
                                    );
                                  },
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(fontSize: 9),
/*
                                  child: Text(
                                    (widget.product.productType
                                                .toString()
                                                .toLowerCase() ==
                                            AppConstants.PRODUCT_TYPE_SIMPLE)
                                        ? "Add to Cart"
                                        : "View Details",
                                    style: TextStyle(fontSize: 9),
*/
                                  )),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                onTap: () {
                  if (AppData.user != null) {
                    if (checkForWishlist(widget.product.productId)) {
                      for (int i = 0; i < AppData.wishlistData.length; i++) {
                        if (AppData.wishlistData[i].productId ==
                            widget.product.productId) {
                          setState(() {
                            BlocProvider.of<WishlistBloc>(context).add(
                                UnLikeProduct(
                                    AppData.wishlistData[i].wishlist));
                          });
                          break;
                        }
                      }
                    } else {
                      BlocProvider.of<WishlistBloc>(context)
                          .add(LikeProduct(widget.product.productId));
/*
                                                                GetWishlistOnStartData
                                                                data =
                                                                GetWishlistOnStartData();
                                                                data.productId = state
                                                                    .products[
                                                                index]
                                                                    .productId;
                                                                data.customerId =
                                                                    AppData.user
                                                                        .id;
                                                                data.wishlist =
                                                                0;
                                                                setState(() {
                                                                  AppData
                                                                      .wishlistData
                                                                      .add(data);
                                                                });
*/
                    }
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Color(0x22000000),
                    child: SvgPicture.asset(
                      (checkForWishlist(widget.product.productId))
                          ? "assets/icons/ic_heart_filled.svg"
                          : "assets/icons/ic_heart.svg",
                      fit: BoxFit.none,
                      width: 14,
                      height: 14,
                      color: (false)
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              if (widget.product.productDiscountPrice != 0)
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      width: 25,
                      height: 25,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Text(
                               "-"+ ((double.parse(widget.product.productPrice
                                              .toString()) -
                                          double.parse(widget
                                              .product.productDiscountPrice
                                              .toString())) /
                                      double.parse(widget.product.productPrice
                                          .toString()) *
                                      100)
                                  .toStringAsFixed(0) + "%",
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                  fontFamily: "MontserratSemiBold")))),
                ),
            ]),
          ),
        ]),
      ),
    );
  }

  bool checkForWishlist(int productId) {
    for (int i = 0; i < AppData.wishlistData.length; i++) {
      if (productId == AppData.wishlistData[i].productId) {
        return true;
      }
    }
    return false;
  }
}
