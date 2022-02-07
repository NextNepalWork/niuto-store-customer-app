import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/blocs/banners/banners_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/constants/app_constants.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/models/banners/banner.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/cart_screen.dart';
import 'package:flutter_kundol/ui/detail_screen.dart';
import 'package:flutter_kundol/ui/search_screen.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';
import 'package:flutter_kundol/ui/widgets/app_bar.dart';
import 'package:flutter_kundol/ui/widgets/banner_slider.dart';
import 'package:flutter_kundol/ui/widgets/category_widget.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/home_tags.dart';
import 'package:flutter_kundol/ui/widgets/hot_items_widget.dart';
import 'package:flutter_kundol/ui/widgets/products_widget.dart';
import 'package:flutter_kundol/ui/widgets/sale_banner_widget.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class HomeFragment1 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  HomeFragment1([this.navigateToNext, this.openDrawer]);

  @override
  _HomeFragment1State createState() => _HomeFragment1State();
}

class _HomeFragment1State extends State<HomeFragment1> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    getProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          HomeAppBar(widget.navigateToNext, widget.openDrawer),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
                    vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BannerSlider(widget.navigateToNext),

                    // HomeTags(),
                    CategoryWidget(widget.navigateToNext),
                    //SaleBannerWidget(isTitleVisible: true, navigateToNext: widget.navigateToNext),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: Text(("Discounted Product").toUpperCase(),
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        SizedBox(
                          height: 200,
                          child: BlocBuilder<ProductsBloc, ProductsState>(
                            builder: (context, state) {
                              return ListView.builder(
                                  itemCount: state.products.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return state.products[index]
                                                .productDiscountPrice !=
                                            0
                                        ? InkWell(
                                            onTap: () {
                                              widget.navigateToNext(
                                                BlocProvider(
                                                    create: (context) =>
                                                        DetailScreenBloc(
                                                            RealCartRepo(),
                                                            RealProductsRepo()),
                                                    child: ProductDetailScreen(
                                                        state.products[index],
                                                        widget.navigateToNext)),
                                              );
                                            },
                                            child: SizedBox(
                                                width: 190,
                                                height: 180,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  elevation: 0,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          SizedBox(
                                                            height: 140,
                                                            width: 200,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10)),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: ApiProvider
                                                                        .imgMediumUrlString +
                                                                    state
                                                                        .products[
                                                                            index]
                                                                        .productGallary
                                                                        .gallaryName,
                                                                fit: BoxFit
                                                                    .cover,
                                                                progressIndicatorBuilder: (context,
                                                                        url,
                                                                        downloadProgress) =>
                                                                    CircularProgressIndicator(
                                                                        value: downloadProgress
                                                                            .progress),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6.0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        widget
                                                                            .navigateToNext(
                                                                          BlocProvider(
                                                                              create: (context) => DetailScreenBloc(RealCartRepo(), RealProductsRepo()),
                                                                              child: ProductDetailScreen(state.products[index], widget.navigateToNext)),
                                                                        );
                                                                      },
                                                                      child: IconTheme(
                                                                          data: IconThemeData(color: Colors.white),
                                                                          child: Icon(
                                                                            Icons.shopping_cart_outlined,
                                                                            size:
                                                                                24,
                                                                          )),
                                                                    ),
                                                                  )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text("  " +
                                                          state
                                                              .products[index]
                                                              .detail
                                                              .first
                                                              .title),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "  " +
                                                                AppData.currency
                                                                    .code +
                                                                " " +
                                                                double.parse(state
                                                                        .products[
                                                                            index]
                                                                        .productDiscountPrice
                                                                        .toString())
                                                                    .toStringAsFixed(
                                                                        2),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                .copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor),
                                                          ),
                                                          SizedBox(width: 8),
                                                          Text(
                                                            AppData.currency
                                                                    .code +
                                                                " " +
                                                                double.parse(state
                                                                        .products[
                                                                            index]
                                                                        .productPrice
                                                                        .toString())
                                                                    .toStringAsFixed(
                                                                        2),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                .copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          )
                                        : SizedBox();
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                    HotItemsWidget(
                        isTitleVisible: true,
                        navigateToNext: widget.navigateToNext),
                    ProductsWidget(widget.navigateToNext, _disableLoadMore),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void getProduct(context) {
    BlocProvider.of<ProductsBloc>(context).add(GetProducts());
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      isLoadingMore = true;
      getProduct(context);
    }
  }

  _disableLoadMore() {
    isLoadingMore = false;
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
