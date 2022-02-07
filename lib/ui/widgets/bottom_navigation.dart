import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomNavigation extends StatelessWidget {
  final Function(int position) selectCurrentItem;
  final int selectedIndex;

  const MyBottomNavigation(this.selectCurrentItem, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: Offset(5.0, 5.0),
              spreadRadius: 2.0)
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          selectCurrentItem(value);
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: SvgPicture.asset("assets/icons/ic_home.svg"),
            activeIcon: SvgPicture.asset("assets/icons/ic_home_filled.svg"),
          ),
          BottomNavigationBarItem(
            label: "Categories",
            icon: SvgPicture.asset("assets/icons/ic_category.svg"),
            activeIcon: SvgPicture.asset("assets/icons/ic_category_filled.svg"),
          ),
          BottomNavigationBarItem(
            label: "Wishlist",
            icon: SvgPicture.asset("assets/icons/ic_heart.svg"),
            activeIcon: SvgPicture.asset("assets/icons/ic_heart_filled.svg"),
          ),
          BottomNavigationBarItem(
            label: "Me",
            icon: SvgPicture.asset("assets/icons/ic_person.svg"),
            activeIcon: SvgPicture.asset("assets/icons/ic_person_filled.svg"),
          ),
        ],
      ),
    );
  }
}
