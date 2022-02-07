// ignore_for_file: must_be_immutable, unused_field, deprecated_member_use

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/cart/cart_counter.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/related_products/related_products_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/products/product.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/repos/reviews_repo.dart';
import 'package:flutter_kundol/ui/review_screen.dart';
import 'package:flutter_kundol/blocs/reviews/reviews_bloc.dart';
import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_kundol/ui/widgets/related_products_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share/share.dart';

import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  Product product;

  ProductDetailScreen(this.product, this.navigateToNext);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _sliderIndex = 0;
  int quantity = 1;
  BottomSheetContent bottomSheetContent;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailScreenBloc>(context)
        .add(GetProductById(widget.product.productId));
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.product.attribute[0].attributes.attributeId);
    return Scaffold(
      body: BlocConsumer<DetailScreenBloc, DetailPageState>(
        listener: (context, state) {
          if (state is GetQuantityLoaded) {
            // if (state.quantityData.remainingStock == null ||
            //     int.tryParse(state.quantityData.remainingStock) == 0) {
            //   Navigator.pop(context);
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(SnackBar(content: Text("Stock is empty")));
            // } else if (int.tryParse(state.quantityData.remainingStock) <
            //     quantity) {
            //   Navigator.pop(context);
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //       content: Text("Max stock available is: " +
            //           state.quantityData.remainingStock)));
            // } else
            //  if (int.tryParse(state.quantityData.remainingStock) >=
            //       quantity) {

            BlocProvider.of<DetailScreenBloc>(context).add(AddToCart(
                widget.product.productId,
                quantity,
                state.quantityData.productCombinationId));
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text("Product Added To Bag")));

            // }
          } else if (state is ItemCartAdded) {
            Navigator.pop(context);
            AppData.sessionId = state.sessionId;

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is ProductDetailsLoaded) {
            setState(() {
              widget.product = state.product;
            });
          } else if (state is DetailPageError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Empty")));
          }
        },
        builder: (context, state) {
          if (state is ProductDetailsLoaded)
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    MyAppBar(
                      leadingWidget: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                "assets/icons/ic_back.svg",
                                fit: BoxFit.none,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_ICONS_DARK
                                    : AppStyles.COLOR_ICONS_LIGHT,
                              )),
                        ),
                      ),
                      centerWidget: Center(
                          child: Text(
                        "Product Details",
                        style: TextStyle(
                            fontSize: 16.0, fontFamily: "MontserratSemiBold"),
                      )),
                      trailingWidget: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => widget.navigateToNext(BlocProvider(
                                  create: (context) => CartBloc(RealCartRepo()),
                                  child: CartScreen())),
                              child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Badge(
                                    badgeColor: Theme.of(context).primaryColor,
                                    badgeContent: Text(
                                      context
                                          .watch<CartCounter>()
                                          .count
                                          .length
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    AppStyles.CARD_RADIUS),
                                child: Container(
                                  width: double.maxFinite,
                                  child: CarouselSlider.builder(
                                    options: CarouselOptions(
                                      height: 180.0,
                                      autoPlay: true,
                                      viewportFraction: 0.8,
                                      enableInfiniteScroll: true,
                                      initialPage: 0,
                                      autoPlayInterval: Duration(seconds: 5),
                                      enlargeCenterPage: false,
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 500),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      pauseAutoPlayOnTouch: false,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _sliderIndex = index;
                                        });
                                      },
                                    ),
                                    itemBuilder: (BuildContext context,
                                        int index, int realIndex) {
                                      return Container(
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: ApiProvider
                                                      .imgMediumUrlString +
                                                  widget
                                                      .product
                                                      .productGallaryDetail[
                                                          index]
                                                      .gallaryName,
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
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
                                      );
                                    },
                                    itemCount: widget
                                        .product.productGallaryDetail.length,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Divider(
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      if (widget.product.productDiscountPrice !=
                                          0)
                                        buildLabel(
                                          "SALE",
                                          Colors.red,
                                        ),
                                      SizedBox(width: 10),
                                      if (widget.product.isFeatured == 1)
                                        buildLabel(
                                          "FEATURED",
                                          Color(0xFF36AFFF),
                                        ),
                                      /*SizedBox(width: 10),
                                      buildLabel(
                                        "NEW",
                                        Color(0xFF18EF35),
                                      ),*/
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (AppData.user != null) {
                                            if (checkForWishlist(
                                                widget.product.productId)) {
                                              for (int i = 0;
                                                  i <
                                                      AppData
                                                          .wishlistData.length;
                                                  i++) {
                                                if (AppData.wishlistData[i]
                                                        .productId ==
                                                    widget.product.productId) {
                                                  setState(() {
                                                    BlocProvider.of<
                                                                WishlistBloc>(
                                                            context)
                                                        .add(UnLikeProduct(
                                                            AppData
                                                                .wishlistData[i]
                                                                .wishlist));
                                                  });
                                                  break;
                                                }
                                              }
                                            } else {
                                              BlocProvider.of<WishlistBloc>(
                                                      context)
                                                  .add(LikeProduct(widget
                                                      .product.productId));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please login first")));
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            child: SvgPicture.asset(
                                                (checkForWishlist(widget
                                                        .product.productId))
                                                    ? "assets/icons/ic_heart_filled.svg"
                                                    : "assets/icons/ic_heart.svg",
                                                fit: BoxFit.none,
                                                width: 14,
                                                height: 14,
                                                color: (checkForWishlist(widget
                                                        .product.productId))
                                                    ? Colors.red
                                                    : Colors.grey),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.0),
                                      GestureDetector(
                                        onTap: () {
                                          Share.share(
                                              "Hi there, please check this app. i think you will love it. ");
                                        },
                                        child: Icon(
                                          Icons.share,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              SizedBox(height: 12.0),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.product.detail.first.title,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: "MontserratSemiBold"),
                                    ),
                                  ),
                                  if (widget.product.productType ==
                                      AppConstants.PRODUCT_TYPE_SIMPLE)
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: const Color(0xfff2f2f2),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (quantity > 1)
                                                      quantity--;
                                                  });
                                                }),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 22.0),
                                              child: Text(quantity.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.black
                                                            : Colors.black,
                                                      ))),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    quantity++;
                                                  });
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 6.0),

                              (widget.product.productDiscountPrice != 0)
                                  ? Row(
                                      children: [
                                        Text(
                                          AppData.currency.code +
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
                                        SizedBox(width: 8),
                                        Text(
                                          AppData.currency.code +
                                              double.parse(widget
                                                      .product.productPrice
                                                      .toString())
                                                  .toStringAsFixed(2),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "Price: ",
                                          style: TextStyle(
                                              fontFamily: "MontserratSemiBold"),
                                        ),
                                        Text(
                                          AppData.currency.code +
                                              double.parse(widget
                                                      .product.productPrice
                                                      .toString())
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? AppStyles.COLOR_GREY_DARK
                                                  : AppStyles.COLOR_GREY_LIGHT),
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 8,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: "Unit:  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontFamily: "MontserratSemiBold",
                                      ),
                                ),
                                TextSpan(
                                    text: widget.product.productUnit.detail
                                        .toString(),
                                    style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_GREY_DARK
                                            : AppStyles.COLOR_GREY_LIGHT)),
                              ])),

                              SizedBox(height: 8.0),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: "Category:  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontFamily: "MontserratSemiBold",
                                      ),
                                ),
                                TextSpan(
                                    text: widget.product.category.first
                                        .categoryDetail.detail.first.name,
                                    style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_GREY_DARK
                                            : AppStyles.COLOR_GREY_LIGHT)),
                              ])),

                              SizedBox(height: 8.0),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: "Tags:  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontFamily: "MontserratSemiBold",
                                      ),
                                ),
                                TextSpan(
                                    text: widget.product.productBrand == null
                                        ? ""
                                        : widget.product.productBrand.brandName,
                                    style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_GREY_DARK
                                            : AppStyles.COLOR_GREY_LIGHT)),
                              ])),
                              SizedBox(height: 8.0),

                              Text(
                                "Description:",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontFamily: "MontserratSemiBold",
                                    ),
                              ),
                              SizedBox(height: 8.0),
                              Text(widget.product.detail.first.desc,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontWeight: FontWeight.bold,
                                  )),
                              if (widget.product.productType ==
                                  AppConstants.PRODUCT_TYPE_VARIABLE)
                                ListTile(
                                  onTap: () {
                                    buildBottomSheet(context);
                                  },
                                  dense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 0),
                                  title: Text(
                                    "Select Color, Size & Quality",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          fontFamily: "MontserratSemiBold",
                                        ),
                                  ),
                                  trailing: Icon(Icons.chevron_right),
                                ),

                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                          create: (BuildContext context) {
                                            return ReviewsBloc(
                                                RealReviewsRepo());
                                          },
                                          child: ReviewScreen(
                                              widget.product.productId)),
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: "All Reviews ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                      fontFamily:
                                                          "MontserratSemiBold",
                                                    ),
                                              ),
                                              TextSpan(
                                                  text: "(" +
                                                      widget.product.reviews
                                                          .length
                                                          .toString() +
                                                      ")",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? AppStyles
                                                              .COLOR_GREY_DARK
                                                          : AppStyles
                                                              .COLOR_GREY_LIGHT)),
                                            ])),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.0),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        height: 45.0,
                                        width: double.maxFinite,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<CartCounter>()
                                                  .increment(
                                                      product: widget.product);
                                              if (widget.product.productType ==
                                                  AppConstants
                                                      .PRODUCT_TYPE_VARIABLE)
                                                buildBottomSheet(context);
                                              else {
                                                BlocProvider.of<
                                                            DetailScreenBloc>(
                                                        context)
                                                    .add(GetQuantity(
                                                        widget
                                                            .product.productId,
                                                        "simple",
                                                        null));
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Add to Cart",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Text("Related Product"),
                              BlocProvider(
                                create: (context) =>
                                    RelatedProductsBloc(RealProductsRepo()),
                                child: RelatedProductsWidget(
                                    widget.product.category.first.categoryDetail
                                        .detail.first.categoryId,
                                    widget.navigateToNext),
                              ),
                              //ProductsWidget(null, null),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomSheetContent(widget.product, onVariationSelected);
      },
    );
  }

  void onVariationSelected(int combinationId, int quantity) {
    Navigator.pop(context);
    this.quantity = quantity;
    BlocProvider.of<DetailScreenBloc>(context)
        .add(GetQuantity(widget.product.productId, "variable", combinationId));
  }

  Widget buildDivider(BuildContext context) {
    return Divider(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppStyles.COLOR_LITE_GREY_DARK
          : AppStyles.COLOR_LITE_GREY_LIGHT,
      thickness: 4,
    );
  }

  Widget buildSection(
      List<Widget> children, bool isDividerVisible, bool isPaddingEnabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: isPaddingEnabled
              ? EdgeInsets.symmetric(
                  vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                  horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL)
              : EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
        if (isDividerVisible)
          Divider(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppStyles.COLOR_LITE_GREY_DARK
                : AppStyles.COLOR_LITE_GREY_LIGHT,
            thickness: 4,
          ),
      ],
    );
  }

  Widget buildLabel(String text, Color color) {
    return Container(
      width: 70,
      height: 20,
      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
        ),
      ),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
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

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisSize: MainAxisSize.min,
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}

class BottomSheetContent extends StatefulWidget {
  Product product;
  Function(int combinationId, int quantity) onVariationSelected;

  BottomSheetContent(this.product, this.onVariationSelected);

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  ProductCombination selectedCombination;
  String selectionText = "";
  List<ProductAttributeVariations> selectedVariations = [];
  int quantity = 1;

  @override
  void initState() {
    super.initState();

    //selection of first / first variation.
    selectedVariations = [];
    for (int i = 0; i < widget.product.attribute.length; i++) {
      selectedVariations.add(widget.product.attribute[i].variations.first);
    }

    findCombination();
  }

  void findCombination() {
    //finding the combination for selected variations.

    int found = 0;
    for (int i = 0; i < widget.product.productCombination.length; i++) {
      ProductCombination combinations = widget.product.productCombination[i];

      found = 0;
      for (int j = 0; j < selectedVariations.length; j++) {
        ProductAttributeVariations inner = selectedVariations[j];
        for (int k = 0; k < combinations.combination.length; k++) {
          Combination element = combinations.combination[k];

          if (element.variationId.toString() ==
              inner.productVariation.id.toString()) {
            found++;
          }
        }
        if (found == this.selectedVariations.length) {
          this.selectedCombination = combinations;
        }
      }
    }

    selectionText = "";
    for (int i = 0; i < selectedCombination.combination.length; i++) {
      selectionText = (i == 0)
          ? selectedCombination.combination[i].variation.detail.first.name
          : selectionText +
              ", " +
              selectedCombination.combination[i].variation.detail.first.name;
    }
  }

  bool checkForSelectedCombination(List<Combination> combination,
      List<ProductAttributeVariations> selectedVariations) {
    for (int i = 0; i < selectedVariations.length; i++) {
      if (combination[i].variationId.toString() !=
          selectedVariations[i].productVariation.id.toString()) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: EdgeInsets.symmetric(
          horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
          vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                child: CachedNetworkImage(
                  imageUrl: ApiProvider.imgMediumUrlString +
                      selectedCombination.gallary.gallaryName,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppData.currency.code +
                        double.tryParse((selectedCombination.price * quantity)
                                .toString())
                            .toStringAsFixed(2),
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Selection:  ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                        text: selectionText,
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT)),
                  ])),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.product.attribute.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  widget.product.attribute[index].attributes.detail.first.name,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ChoiceChips(
                  chipName: widget.product.attribute[index].variations,
                  choiceChipsCallback: (variation) {
                    setState(() {
                      selectedVariations[index] = variation;
                      findCombination();
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "Quantity",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
                color: const Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      }),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.0),
                    child: Text(quantity.toString(),
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.black,
                            ))),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
            height: 45.0,
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  widget.onVariationSelected(
                      selectedCombination.productCombinationId, quantity);
                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}

typedef void ChoiceChipsCallback(ProductAttributeVariations variation);

class ChoiceChips extends StatefulWidget {
  final List<ProductAttributeVariations> chipName;
  final ChoiceChipsCallback choiceChipsCallback;

  ChoiceChips({Key key, this.chipName, this.choiceChipsCallback})
      : super(key: key);

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  String _selected = "";

  @override
  void initState() {
    super.initState();
    _selected = widget.chipName.first.productVariation.detail.first.name;
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.chipName.forEach((item) {
      choices.add(Container(
        child: ChoiceChip(
          backgroundColor: Colors.transparent,
          label: Text(item.productVariation.detail.first.name),
          labelStyle: TextStyle(
              color: _selected == item.productVariation.detail.first.name
                  ? Colors.white
                  : Theme.of(context).brightness == Brightness.dark
                      ? AppStyles.COLOR_GREY_DARK
                      : AppStyles.COLOR_GREY_LIGHT),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: _selected == item.productVariation.detail.first.name
                    ? Colors.transparent
                    : Theme.of(context).brightness == Brightness.dark
                        ? AppStyles.COLOR_GREY_DARK
                        : AppStyles.COLOR_GREY_LIGHT,
                width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          selectedColor: Theme.of(context).primaryColor,
          selected: _selected == item.productVariation.detail.first.name,
          onSelected: (selected) {
            setState(() {
              _selected = item.productVariation.detail.first.name;
              widget.choiceChipsCallback(item);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5.0,
      runSpacing: 3.0,
      children: _buildChoiceList(),
    );
  }
}
