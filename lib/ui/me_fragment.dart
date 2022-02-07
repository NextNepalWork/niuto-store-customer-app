import 'dart:ui';

import 'package:flutter_kundol/index/index.dart';

import 'cart_screen.dart';

class MeFragment extends StatelessWidget {
  final Function(Widget widget) navigateToNext;

  MeFragment(this.navigateToNext);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
          SliverAppBar(
            leading: GestureDetector(
              onTap: () => navigateToNext(Settings()),
              child: SvgPicture.asset("assets/icons/ic_setting.svg",
                  fit: BoxFit.none),
            ),
            actions: [
              GestureDetector(
                onTap: () => navigateToNext(BlocProvider(
                    create: (context) => CartBloc(RealCartRepo()),
                    child: CartScreen())),
                child: Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 5.0),
                    child: Badge(
                      badgeColor: Colors.white,
                      badgeContent: Text(
                        context.watch<CartCounter>().count.length.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                      child: Icon(Icons.shopping_cart_outlined,
                          color: Colors.white),
                    )),
              ),
            ],
            expandedHeight: 140.0,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (BuildContext context, state) {
                        return InkWell(
                          onTap: () {
                            if (state is Authenticated) {
                              navigateToNext(EditProfileScreen());
                            } else
                              navigateToNext(SignIn());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                            child: Row(
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration:
                                      new BoxDecoration(shape: BoxShape.circle),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png",
                                      fit: BoxFit.fill,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Welcome " +
                                          ((AppData.user != null)
                                              ? AppData.user.firstName
                                              : ""),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      (AppData.user != null)
                                          ? AppData.user.email
                                          : "Please Login",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                IconTheme(
                                    data: IconThemeData(color: Colors.white),
                                    child: Icon(Icons.navigate_next)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: AppData.user == null
                ? SizedBox()
                : ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: Card(
                          color: Colors.black.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          elevation: 0,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 5.0, right: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 5.0),
                                      child: Text("My Orders",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (AppData.user != null)
                                          navigateToNext(BlocProvider(
                                              create: (BuildContext context) {
                                                return OrdersBloc(
                                                    RealOrdersRepo())
                                                  ..add(GetOrders());
                                              },
                                              child: OrdersScreen()));
                                        else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Login first")));
                                        }
                                      },
                                      child: Text(
                                        "See All",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                                fontSize: 11.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GridView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10.0,
                                        childAspectRatio: 1.3),
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (AppData.user != null)
                                        navigateToNext(BlocProvider(
                                            create: (BuildContext context) {
                                              return OrdersBloc(
                                                  RealOrdersRepo())
                                                ..add(GetOrders());
                                            },
                                            child: OrdersScreen()));
                                      else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Login first")));
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/ic_in_progress.svg",
                                            fit: BoxFit.none,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? AppStyles.COLOR_ICONS_DARK
                                                    : Colors.white),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "In Progress",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (AppData.user != null)
                                        navigateToNext(BlocProvider(
                                            create: (BuildContext context) {
                                              return OrdersBloc(
                                                  RealOrdersRepo())
                                                ..add(GetOrders());
                                            },
                                            child: OrdersScreen()));
                                      else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Login first")));
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/ic_delivered.svg",
                                            fit: BoxFit.none,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? AppStyles.COLOR_ICONS_DARK
                                                    : Colors.white),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Delivered",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (AppData.user != null)
                                        navigateToNext(BlocProvider(
                                            create: (BuildContext context) {
                                              return OrdersBloc(
                                                  RealOrdersRepo())
                                                ..add(GetOrders());
                                            },
                                            child: OrdersScreen()));
                                      else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text("Login first")));
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/ic_reviews.svg",
                                            fit: BoxFit.none,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? AppStyles.COLOR_ICONS_DARK
                                                    : Colors.white),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Reviews",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (AppData.user != null)
                                      navigateToNext(BlocProvider(
                                          create: (BuildContext context) {
                                            return AddressBloc(
                                                RealAddressRepo())
                                              ..add(GetAddress());
                                          },
                                          child: MyAddressScreen()));
                                    else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Login first")));
                                    }
                                  },
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    tileColor: Theme.of(context).brightness !=
                                            Brightness.dark
                                        ? const Color(0xfff2f2f2)
                                        : Colors.black,
                                    leading: SvgPicture.asset(
                                        "assets/icons/ic_address.svg",
                                        fit: BoxFit.none,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_ICONS_DARK
                                            : AppStyles.COLOR_ICONS_LIGHT),
                                    title: Text("Address"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (AppData.user != null)
                                      navigateToNext(EditProfileScreen());
                                    else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Login first")));
                                    }
                                  },
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    tileColor: Theme.of(context).brightness !=
                                            Brightness.dark
                                        ? const Color(0xfff2f2f2)
                                        : Colors.black,
                                    leading: SvgPicture.asset(
                                        "assets/icons/ic_profile.svg",
                                        fit: BoxFit.none,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_ICONS_DARK
                                            : AppStyles.COLOR_ICONS_LIGHT),
                                    title: Text("Profile"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () => navigateToNext(BlocProvider(
                                      create: (BuildContext context) =>
                                          RewardBloc(RealRewardPoints()),
                                      child: RewardScreen())),
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    tileColor: Theme.of(context).brightness !=
                                            Brightness.dark
                                        ? const Color(0xfff2f2f2)
                                        : Colors.black,
                                    leading: SvgPicture.asset(
                                        "assets/icons/ic_help.svg",
                                        fit: BoxFit.none,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_ICONS_DARK
                                            : AppStyles.COLOR_ICONS_LIGHT),
                                    title: Text("Rewards"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () => navigateToNext(BlocProvider(
                                      create: (BuildContext context) =>
                                          ContactUsBloc(RealContactUsRepo()),
                                      child: ContactUsScreen())),
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    tileColor: Theme.of(context).brightness !=
                                            Brightness.dark
                                        ? const Color(0xfff2f2f2)
                                        : Colors.black,
                                    leading: SvgPicture.asset(
                                        "assets/icons/ic_feedback.svg",
                                        fit: BoxFit.none,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_ICONS_DARK
                                            : AppStyles.COLOR_ICONS_LIGHT),
                                    title: Text("Feedback"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () => Share.share(
                                      'check out this app Flutter Rawal'),
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    tileColor: Theme.of(context).brightness !=
                                            Brightness.dark
                                        ? const Color(0xfff2f2f2)
                                        : Colors.black,
                                    leading: Icon(Icons.share,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_ICONS_DARK
                                            : AppStyles.COLOR_ICONS_LIGHT),
                                    title: Text("Share"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () => LaunchReview.launch(),
                                  child: ListTile(
                                    horizontalTitleGap: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    tileColor: Theme.of(context).brightness !=
                                            Brightness.dark
                                        ? const Color(0xfff2f2f2)
                                        : Colors.black,
                                    leading: Icon(Icons.star_border_outlined,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppStyles.COLOR_ICONS_DARK
                                            : AppStyles.COLOR_ICONS_LIGHT),
                                    title: Text("Rate us"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
