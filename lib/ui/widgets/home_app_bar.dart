import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_counter.dart';
import 'package:flutter_kundol/blocs/products_search/products_search_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/cart_repo.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/widgets/custom_search.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart';
import '../cart_screen.dart';
import '../login_screen.dart';
import '../search_screen.dart';
import 'app_bar.dart';

class HomeAppBar extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;
  const HomeAppBar(
    this.navigateToNext,
    this.openDrawer, {
    Key key,
  }) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(GetCart());
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      leadingWidget: Padding(
        padding: EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () => widget.openDrawer(),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Icon(
              Icons.vertical_distribute_outlined,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
      ),
      // leadingWidget: Padding(
      //   padding: const EdgeInsets.only(left: 10.0),
      //   child: Image.asset(
      //     "assets/icons/logo.png",
      //     height: 45,
      //   ),
      // ),
      centerWidget: InkWell(
        onTap: () {
          showSearch(
              context: context,
              delegate:
                  CustomSearchDelegate(navigateToNext: widget.navigateToNext));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).brightness != Brightness.dark
                  ? const Color(0xfff2f2f2)
                  : Colors.black,
              borderRadius: BorderRadius.circular(8)),
          height: 40,
          child: Row(
            children: [
              SizedBox(
                width: 4,
              ),
              Icon(Icons.search,
                  color: Theme.of(context).brightness != Brightness.dark
                      ? Colors.black.withOpacity(0.6)
                      : Color(0xff737373)),
              SizedBox(
                width: 4,
              ),
              Text(
                " Search for products",
                style: TextStyle(
                    color: Theme.of(context).brightness != Brightness.dark
                        ? Colors.black.withOpacity(0.6)
                        : Color(0xff737373)),
              )
            ],
          ),
        ),
      ),
      trailingWidget: Padding(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: [
/*
            GestureDetector(
              onTap: () => navigateToNext(BlocProvider(
                create: (context) => ProductsSearchBloc(RealProductsRepo()),
                child: SearchScreen(navigateToNext),
              )),
              child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/icons/ic_search.svg",
                      fit: BoxFit.none,
                      color: Theme.of(context).brightness == Brightness.dark ? AppStyles.COLOR_ICONS_DARK : AppStyles.COLOR_ICONS_LIGHT,
                  )),
            ),
*/
            GestureDetector(
              onTap: () => widget.navigateToNext(
                  // (AppData.user != null)
                  //     ?
                  BlocProvider(
                      create: (context) => CartBloc(RealCartRepo()),
                      child: CartScreen())
                  // : SignIn(),
                  ),
              child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Badge(
                    badgeColor: Theme.of(context).primaryColor,
                    badgeContent: Text(
                      context.watch<CartCounter>().count.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  )),
            ),
            // GestureDetector(
            //     onTap: () {
            // showSearch(
            //     context: context,
            //     delegate: CustomSearchDelegate(
            //         navigateToNext: widget.navigateToNext));
            //       // widget.navigateToNext(BlocProvider(
            //       //   create: (context) => ProductsSearchBloc(RealProductsRepo()),
            //       //   child: SearchScreen(widget.navigateToNext),
            //       // ));
            //     },
            //     child: Icon(CupertinoIcons.search)),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
      /*trailingWidget: IconButton(
        icon: Icon(Icons.shopping_basket_outlined),
        onPressed: () {
          widget.navigateToNext(BlocProvider(
              create: (context) => CartBloc(RealCartRepo()),
              child: CartScreen()));
        },
      ),*/
    );
  }
}
