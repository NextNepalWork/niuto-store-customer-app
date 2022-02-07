import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Widget leadingWidget;
  final Widget centerWidget;
  final Widget trailingWidget;

  MyAppBar({this.leadingWidget, this.centerWidget, this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        height: kToolbarHeight,
        child: Row(
          children: [
            (leadingWidget != null)
                ? leadingWidget
                : SizedBox(
                    width: 16.0,
                  ),
            Expanded(child: (centerWidget != null) ? centerWidget : SizedBox()),
            (trailingWidget != null)
                ? trailingWidget
                : SizedBox(
                    width: 16.0,
                  )
          ],
        ),
      ),
    );
  }
}
