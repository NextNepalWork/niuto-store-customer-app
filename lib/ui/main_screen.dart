import 'package:flutter_kundol/index/index.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final _inactiveColor = Colors.grey;
  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WishlistBloc>(context).add(GetWishlistOnStart());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState.maybePop();
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        } else {
          return isFirstRouteInCurrentTab;
        }
      },
      child: BlocListener<WishlistBloc, WishlistState>(
        listener: (BuildContext context, state) {
          if (state is WishlistLoaded) {
            setState(() {
              AppData.wishlistData = state.wishlistResponse.data;
            });
          }
        },
        child: Scaffold(
          drawer: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
            width: 220,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
              child: Drawer(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserAccountsDrawerHeader(
                        decoration:
                            BoxDecoration(color: Colors.green.withOpacity(0.5)),
                        currentAccountPictureSize: Size(100, 80),
                        accountName: Text(
                          "Niuto Store",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        accountEmail: Text(
                          "",
                          style: TextStyle(color: Colors.white),
                        ),
                        currentAccountPicture:
                            Image.asset("assets/icons/logo.png"),
                      ),
                      BlocBuilder<CategoriesBloc, CategoriesState>(
                        builder: (context, state) {
                          if (state is CategoriesLoaded) {
                            List<Category> parentCategories =
                                getParentCategories(
                                    state.categoriesResponse.data);
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: parentCategories.length,
                              itemBuilder: (context, i) {
                                List<Category> childData = getChildCategories(
                                    state.categoriesResponse.data,
                                    parentCategories[i].id);
                                return (childData.isNotEmpty)
                                    ? ExpansionTile(
                                        title: new Text(
                                          parentCategories[i].name,
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        children: <Widget>[
                                          new Column(
                                            children: _buildExpandableContent(
                                                childData),
                                          ),
                                        ],
                                      )
                                    : ListTile(
                                        onTap: () => _navigateToNext(
                                            BlocProvider(
                                                create: (BuildContext context) {
                                                  return ProductsByCatBloc(
                                                      RealProductsRepo(),
                                                      BlocProvider.of<
                                                              CategoriesBloc>(
                                                          context),
                                                      parentCategories[i].id,
                                                      "id",
                                                      "ASC",
                                                      "");
                                                },
                                                child: ShopScreen(
                                                    parentCategories[i],
                                                    _navigateToNext))),
                                        leading: Image.network(
                                          ApiProvider.imgMediumUrlString +
                                              parentCategories[i].icon,
                                          height: 30,
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                        ),
                                        title: new Text(
                                          parentCategories[i].name,
                                          style: TextStyle(fontSize: 14.0),
                                        ));
                              },
                            );
                          } else if (state is CategoriesError)
                            return Text(state.error);
                          else
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          key: scaffoldKey,
          body: Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
              _buildOffstageNavigator(2),
              _buildOffstageNavigator(3),
            ],
          ),
          bottomNavigationBar: _buildBottomBar(),
          floatingActionButton: AppConfig.IS_DEMO_ENABlED
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DemoSettingsScreen()));
                  },
                  child: Icon(Icons.settings),
                )
              : null,
        ),
      ),
    );
  }

  _buildExpandableContent(List<Category> data) {
    List<Widget> columnContent = [];

    for (Category category in data)
      columnContent.add(
        new ListTile(
          onTap: () => _navigateToNext(BlocProvider(
              create: (BuildContext context) {
                return ProductsByCatBloc(
                    RealProductsRepo(),
                    BlocProvider.of<CategoriesBloc>(context),
                    category.id,
                    "id",
                    "ASC",
                    "");
              },
              child: ShopScreen(category, _navigateToNext))),
          title: new Text(
            category.name,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      );

    return columnContent;
  }

  void _selectCurrentItem(int position) {
    if (position == 2)
      BlocProvider.of<WishlistProductsBloc>(context)
          .add(RefreshWishlistProducts());
    setState(() {
      _selectedIndex = position;
    });
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _homeScreenRouteBuilder(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }

  _navigateToNext(Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  _openHomeDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  Map<String, WidgetBuilder> _homeScreenRouteBuilder(
      BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          getDefaultHome(),
          getDefaultCategory(),
          FavFragment(_navigateToNext, _openHomeDrawer),
          MeFragment(_navigateToNext),
        ].elementAt(index);
      },
    };
  }

  Widget getDefaultHome() {
    switch (int.parse(
        AppData.settingsResponse.getKeyValue(SettingsResponse.HOME_STYLE))) {
      case 1:
        return HomeFragment1(_navigateToNext, _openHomeDrawer);
      case 2:
        return HomeFragment2(_navigateToNext, _openHomeDrawer);
      case 3:
        return BlocProvider(
            create: (BuildContext context) =>
                TopSellingProductsBloc(RealProductsRepo()),
            child: HomeFragment3(_navigateToNext, _openHomeDrawer));
      case 4:
        return BlocProvider(
            create: (BuildContext context) =>
                TopSellingProductsBloc(RealProductsRepo()),
            child: HomeFragment4(_navigateToNext, _openHomeDrawer));
      case 5:
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TopSellingProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => SuperDealProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => FeaturedProductsBloc(RealProductsRepo())),
        ], child: HomeFragment5(_navigateToNext, _openHomeDrawer));
      case 6:
        return HomeFragment6(_navigateToNext, _openHomeDrawer);
      case 7:
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TopSellingProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => SuperDealProductsBloc(RealProductsRepo()))
        ], child: HomeFragment7(_navigateToNext, _openHomeDrawer));
      case 8:
        return HomeFragment8(_navigateToNext, _openHomeDrawer);
      case 9:
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TopSellingProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => SuperDealProductsBloc(RealProductsRepo())),
          BlocProvider(
              create: (context) => FeaturedProductsBloc(RealProductsRepo())),
        ], child: HomeFragment9(_navigateToNext, _openHomeDrawer));
      default:
        return HomeFragment1(_navigateToNext, _openHomeDrawer);
    }
  }

  Widget getDefaultCategory() {
    switch (int.parse(AppData.settingsResponse
        .getKeyValue(SettingsResponse.CATEGORY_STYLE))) {
      case 1:
        return CategoryFragment(_navigateToNext, _openHomeDrawer);
      case 2:
        return CategoryFragment2(_navigateToNext, _openHomeDrawer);
      case 3:
        return CategoryFragment3(_navigateToNext, _openHomeDrawer);
      case 4:
        return CategoryFragment4(_navigateToNext, _openHomeDrawer);
      case 5:
        return CategoryFragment5(_navigateToNext, _openHomeDrawer);
      case 6:
        return CategoryFragment6(_navigateToNext, _openHomeDrawer);
      default:
        return CategoryFragment(_navigateToNext, _openHomeDrawer);
    }
  }

  List<Category> getParentCategories(List<Category> data) {
    List<Category> tempCategories = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].parent == null) {
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }

  List<Category> getChildCategories(List<Category> data, int id) {
    List<Category> tempCategories = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].parent == id) {
        tempCategories.add(data[i]);
      }
    }
    return tempCategories;
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 60,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.transparent
          : Colors.white,
      selectedIndex: _selectedIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _selectedIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          activeColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.green
              : AppData.kPrimaryColor,
          icon: SvgPicture.asset(
            "assets/icons/ic_home.svg",
            color: _selectedIndex == 0 ? Colors.white : Colors.grey,
          ),
          title: const Text(
            'Home',
          ),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          activeColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.green
              : AppData.kPrimaryColor,
          icon: SvgPicture.asset(
            "assets/icons/ic_category_filled.svg",
            color: _selectedIndex == 1 ? Colors.white : Colors.grey,
          ),
          title: const Text(
            "Categories",
          ),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          activeColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.green
              : AppData.kPrimaryColor,
          icon: SvgPicture.asset(
            "assets/icons/ic_heart_filled.svg",
            color: _selectedIndex == 2 ? Colors.white : Colors.grey,
          ),
          title: const Text(
            "Wishlist",
          ),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          activeColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.green
              : AppData.kPrimaryColor,
          icon: SvgPicture.asset(
            "assets/icons/ic_person.svg",
            color: _selectedIndex == 3 ? Colors.white : Colors.grey,
          ),
          title: const Text('Me'),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
