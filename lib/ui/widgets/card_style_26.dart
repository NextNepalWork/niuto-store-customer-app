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

class CardStyle26 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Product product;
  final Color cardColor;

  const CardStyle26(this.navigateToNext, this.product, this.cardColor);

  @override
  _CardStyle26State createState() => _CardStyle26State();
}

class _CardStyle26State extends State<CardStyle26> {
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
                    child: Stack(
                      children: [
                        Container(
                          height: double.maxFinite,
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
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.all(6.0),
                              width: double.maxFinite,
                              child: ElevatedButton(onPressed: () {
                                widget.navigateToNext(
                                  BlocProvider(
                                      create: (context) => DetailScreenBloc(
                                          RealCartRepo(),
                                          RealProductsRepo()),
                                      child: ProductDetailScreen(
                                          widget.product,
                                          widget.navigateToNext)),
                                );
                              }, child: Text("View Details"))),
                        ),
                      ],
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.product.category.first.categoryDetail.detail.first.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    widget.product.detail.first.title,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(height: 12.0,),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          AppData.currency.code +
                              double.parse((widget.product.productDiscountPrice !=
                                  0)
                                  ? widget.product.productDiscountPrice
                                  .toString()
                                  : widget.product.productPrice.toString())
                                  .toStringAsFixed(2),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        /*child: Text("Featured",
                            style:
                            TextStyle(color: Colors.white, fontSize: 12))*/),
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
