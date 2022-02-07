import 'package:flutter/material.dart';
import 'package:flutter_kundol/constants/app_data.dart';

import 'bnb_items.dart';

class CustomAnimatedBottomBar extends StatelessWidget {
  const CustomAnimatedBottomBar({
    Key key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    @required this.items,
    @required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;
    return Container(
      decoration: BoxDecoration(color: bgColor, boxShadow: [
        if (showElevation) const BoxShadow(color: Colors.black12, blurRadius: 2)
      ]),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          width: double.infinity,
          height: containerHeight,
          child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: items.map((item) {
                var index = items.indexOf(item);
                return GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: BNBItems(
                    item: item,
                    isSelected: index == selectedIndex,
                    backgroundColor: bgColor,
                    animationDuration: animationDuration,
                    itemCornerRadius: itemCornerRadius,
                    iconSize: iconSize,
                    curve: curve,
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    @required this.icon,
    @required this.title,
    this.activeColor = AppData.kPrimaryColor,
    this.textAlign,
    this.inactiveColor,
  });

  final Widget icon;
  final Widget title;

  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
}
