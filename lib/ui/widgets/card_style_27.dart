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

class CardStyle27 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Product product;
  final Color cardColor;

  const CardStyle27(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle27State createState() => _CardStyle27State();
}

class _CardStyle27State extends State<CardStyle27> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.navigateToNext(
          BlocProvider(
              create: (context) => DetailScreenBloc(RealCartRepo(), RealProductsRepo()),
              child: ProductDetailScreen(widget.product, widget.navigateToNext)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppStyles.CARD_RADIUS),
        child: new Card(
          color: widget.cardColor,
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
                        borderRadius:
                            BorderRadius.circular(AppStyles.CARD_RADIUS),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.product.detail.first.title,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 6.0,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        height: 25.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.chevron_left, size: 16.0,),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 22.0),
                                child: Text(
                                  "1",
                                  style: Theme.of(context).textTheme.caption,
                                )),
                            Icon(Icons.chevron_right, size: 16.0,),
                          ],
                        ),
                      ),
                      SizedBox(height: 6.0,),
                      (widget.product.productDiscountPrice != 0) ?
                      Wrap(
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "\$" +
                                      double.parse(widget.product.productPrice
                                              .toString())
                                          .toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                SizedBox(width: 8),
                                if (widget.product.productDiscountPrice != 0)
                                  Text(
                                    "\$" +
                                        double.parse(widget
                                                .product.productDiscountPrice
                                                .toString())
                                            .toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough),
                                  ),
                              ],
                            )
                          : RichText(
                              text: TextSpan(children: [
                              TextSpan(
                                text: "\$" +
                                    double.tryParse(widget.product
                                            .productCombination.first.price
                                            .toString())
                                        .toStringAsFixed(2),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              TextSpan(text: " - "),
                              TextSpan(
                                text: "\$" +
                                    double.tryParse(widget.product
                                            .productCombination.last.price
                                            .toString())
                                        .toStringAsFixed(2),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ])),
*/
                      Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
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
                            }, child: Text("View Details")),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.product.isFeatured == 1)
                    Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text("Featured",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12))),
                  ],
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
