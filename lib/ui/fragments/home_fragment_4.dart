import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/blocs/banners/banners_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/detail_screen/detail_screen_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/blocs/top_selling_products/top_selling_products_bloc.dart';
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
import 'package:flutter_kundol/ui/widgets/newarrivals_banner_widget.dart';
import 'package:flutter_kundol/ui/widgets/top_selling_products_widget.dart';
import 'package:flutter_kundol/ui/widgets/products_widget.dart';
import 'package:flutter_kundol/ui/widgets/sale_banner_widget.dart';

// ignore: must_be_immutable
class HomeFragment4 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  HomeFragment4([this.navigateToNext, this.openDrawer]);

  @override
  _HomeFragment4State createState() => _HomeFragment4State();
}

class _HomeFragment4State extends State<HomeFragment4> {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<CategoriesBloc>(context).add(GetCategories());
    getProduct(context);
    BlocProvider.of<TopSellingProductsBloc>(context)
        .add(GetTopSellingProducts());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: kToolbarHeight),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 28.0),
                      color: Color(0xFFADD0F4),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppStyles.CARD_RADIUS),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 28.0, vertical: 6.0),
                          color: Colors.white,
                          child: Center(
                            child: HotItemsWidget(
                                isTitleVisible: true,
                                navigateToNext: widget.navigateToNext),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL,
                          vertical: AppStyles.SCREEN_MARGIN_VERTICAL),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.navigateToNext(BlocProvider(
                                create: (context) => ProductsSearchBloc(RealProductsRepo()),
                                child: SearchScreen(widget.navigateToNext),
                              ));
                            },
                            child: Container(
                              height: 56.0,
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: AppStyles.COLOR_SEARCH_BAR,
                                borderRadius:
                                BorderRadius.all(Radius.circular(AppStyles.CARD_RADIUS)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search_outlined,
                                    size: 18.0,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "What are you looking for?",
                                        style: Theme.of(context).textTheme.caption,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          SaleBannerWidget(
                              isTitleVisible: false,
                              navigateToNext: widget.navigateToNext),
                          NewArrivalsBannerWidget(
                              isTitleVisible: false,
                              navigateToNext: widget.navigateToNext),
                          CategoryWidget(widget.navigateToNext),
                          TopSellingProductsWidget(widget.navigateToNext),
                          ProductsWidget(
                              widget.navigateToNext, _disableLoadMore),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            HomeAppBar(widget.navigateToNext, widget.openDrawer)
          ],
        ),
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
