import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';

import '../detail_screen.dart';

class CardStyle5 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Product product;
  final Color cardColor;

  const CardStyle5(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle5State createState() => _CardStyle5State();
}

class _CardStyle5State extends State<CardStyle5> {
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
        child: new Card(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.transparent
              : widget.cardColor,
          margin: EdgeInsets.zero,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppStyles.CARD_RADIUS),
                            topRight: Radius.circular(AppStyles.CARD_RADIUS)),
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
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StarRating(
                                      starCount: 5,
                                      rating:
                                          widget.product.productRating != null
                                              ? double.parse(widget
                                                  .product.productRating
                                                  .toString())
                                              : 0,
                                      onRatingChanged: (rating) {}),
                                  Text(
                                    widget.product.detail.first.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  // Text(
                                  //     "Rs.cc" +
                                  //         widget.product.productPrice
                                  //             .toString(),
                                  //     maxLines: 1,
                                  //     overflow: TextOverflow.ellipsis,
                                  //     style: TextStyle(
                                  //         color: Theme.of(context).primaryColor,
                                  //         fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  (widget.product.productDiscountPrice != 0)
                                      ? Row(
                                          children: [
                                            Text(
                                              AppData.currency.code +
                                                  " " +
                                                  double.parse(widget.product
                                                          .productDiscountPrice
                                                          .toString())
                                                      .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              AppData.currency.code +
                                                  " " +
                                                  double.parse(widget
                                                          .product.productPrice
                                                          .toString())
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontSize: 13.0,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            widget.navigateToNext(
                              BlocProvider(
                                  create: (context) => DetailScreenBloc(
                                      RealCartRepo(), RealProductsRepo()),
                                  child: ProductDetailScreen(
                                      widget.product, widget.navigateToNext)),
                            );
                          },
                          child: IconTheme(
                              data: IconThemeData(color: Colors.white),
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                size: 24,
                              )),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
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
