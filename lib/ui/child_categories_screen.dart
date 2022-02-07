import 'package:flutter/material.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/constants/app_data.dart';

import 'package:flutter_kundol/models/category.dart';

import 'package:flutter_kundol/ui/widgets/category_widget_style_1.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_2.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_3.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_4.dart';
import 'package:flutter_kundol/ui/widgets/category_widget_style_5.dart';

class ChildCategoriesScreen extends StatefulWidget {
  final List<Category> categories;
  final List<Category> allCategories;
  final Function(Widget widget) navigateToNext;
  const ChildCategoriesScreen(
      this.categories, this.allCategories, this.navigateToNext,
      {Key key})
      : super(key: key);

  @override
  _ChildCategoriesScreenState createState() => _ChildCategoriesScreenState();
}

class _ChildCategoriesScreenState extends State<ChildCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Categories", style: Theme.of(context).textTheme.headline6),
        elevation: 4,
      ),
      body: getDefaultCategory(),
    );
  }

  Widget getDefaultCategory() {
    switch (int.parse(AppData.settingsResponse
        .getKeyValue(SettingsResponse.CATEGORY_STYLE))) {
      case 1:
        return CategoryWidgetStyle1(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 2:
        return CategoryWidgetStyle2(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 3:
        return CategoryWidgetStyle3(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 4:
        return CategoryWidgetStyle4(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 5:
        return CategoryWidgetStyle5(
            widget.allCategories, widget.categories, widget.navigateToNext);
      case 6:
        return CategoryWidgetStyle1(
            widget.allCategories, widget.categories, widget.navigateToNext);
      default:
        return CategoryWidgetStyle1(
            widget.allCategories, widget.categories, widget.navigateToNext);
    }
  }
}
