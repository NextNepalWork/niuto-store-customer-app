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
import 'package:flutter_kundol/blocs/featured_products/featured_products_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/blocs/super_deal_products/super_deal_products_bloc.dart';
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
import 'package:flutter_kundol/ui/widgets/category_widget_6.dart';
import 'package:flutter_kundol/ui/widgets/featured_single_page_widget.dart';
import 'package:flutter_kundol/ui/widgets/home_app_bar.dart';
import 'package:flutter_kundol/ui/widgets/home_tags.dart';
import 'package:flutter_kundol/ui/widgets/hot_items_widget.dart';
import 'package:flutter_kundol/ui/widgets/products_singlepage_widget.dart';
import 'package:flutter_kundol/ui/widgets/products_widget.dart';
import 'package:flutter_kundol/ui/widgets/sale_banner_widget.dart';
import 'package:flutter_kundol/ui/widgets/super_deals_single_page_widget.dart';
import 'package:flutter_kundol/ui/widgets/top_selling_single_page_widget.dart';

// ignore: must_be_immutable
class HomeFragment9 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  HomeFragment9([this.navigateToNext, this.openDrawer]);

  @override
  _HomeFragment9State createState() => _HomeFragment9State();
}

class _HomeFragment9State extends State<HomeFragment9>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  bool isLoadingMore = false;
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    getProduct(context);
    BlocProvider.of<TopSellingProductsBloc>(context)
        .add(GetTopSellingProducts());
    BlocProvider.of<SuperDealProductsBloc>(context).add(GetSuperDealProducts());
    BlocProvider.of<FeaturedProductsBloc>(context).add(GetFeaturedProducts());
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    CategoryWidget6(widget.navigateToNext),
                    BannerSlider(widget.navigateToNext),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                              controller: _tabController,
                              labelStyle: TextStyle(),
                              unselectedLabelColor:
                              Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                              labelColor: Theme.of(context).primaryColor,
                              tabs: [
                                Tab(text: "New Arrivals"),
                                Tab(text: "Trending"),
                                Tab(text: "Sale Items"),
                              ]),
                        ),
                        Center(
                          child: [
                            TopSellingSinglePageWidget(widget.navigateToNext),
                            SuperDealSinglePageWidget(widget.navigateToNext),
                            FeaturedSinglePageWidget(widget.navigateToNext),
                          ][_tabController.index],
                        ),
                      ],
                    ),
                    SaleBannerWidget(isTitleVisible: true, navigateToNext: widget.navigateToNext),
                    HotItemsWidget(isTitleVisible: true, navigateToNext: widget.navigateToNext),
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
