// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/constants/app_data.dart';

class DemoSettingsScreen extends StatefulWidget {
  const DemoSettingsScreen({Key key}) : super(key: key);

  @override
  _DemoSettingsScreenState createState() => _DemoSettingsScreenState();
}

class _DemoSettingsScreenState extends State<DemoSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Settings", style: Theme.of(context).textTheme.headline6),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child:
                      Text("Home Page Style", style: TextStyle(fontSize: 18))),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        AppData.settingsResponse.setKeyValue(
                            SettingsResponse.HOME_STYLE,
                            (index + 1).toString());
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: (AppData.settingsResponse.getKeyValue(
                                        SettingsResponse.HOME_STYLE) ==
                                    (index + 1).toString())
                                ? Theme.of(context).accentColor
                                : Colors.transparent,
                            width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Center(
                              child: Text(
                            "Style " + (index + 1).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ))),
                    ),
                  );
                },
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child: Text("Category Page Style",
                      style: TextStyle(fontSize: 18))),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        AppData.settingsResponse.setKeyValue(
                            SettingsResponse.CATEGORY_STYLE,
                            (index + 1).toString());
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: (AppData.settingsResponse.getKeyValue(
                                        SettingsResponse.CATEGORY_STYLE) ==
                                    (index + 1).toString())
                                ? Theme.of(context).accentColor
                                : Colors.transparent,
                            width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Center(
                              child: Text(
                            "Style " + (index + 1).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ))),
                    ),
                  );
                },
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child: Text("Banner Style", style: TextStyle(fontSize: 18))),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        AppData.settingsResponse.setKeyValue(
                            SettingsResponse.BANNER_STYLE,
                            (index + 1).toString());
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: (AppData.settingsResponse.getKeyValue(
                                        SettingsResponse.BANNER_STYLE) ==
                                    (index + 1).toString())
                                ? Theme.of(context).accentColor
                                : Colors.transparent,
                            width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Center(
                              child: Text(
                            "Style " + (index + 1).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ))),
                    ),
                  );
                },
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child: Text("Product Card Style",
                      style: TextStyle(fontSize: 18))),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1),
                itemCount: 27,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        AppData.settingsResponse.setKeyValue(
                            SettingsResponse.CARD_STYLE,
                            (index + 1).toString());
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: (AppData.settingsResponse.getKeyValue(
                                        SettingsResponse.CARD_STYLE) ==
                                    (index + 1).toString())
                                ? Theme.of(context).accentColor
                                : Colors.transparent,
                            width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Center(
                              child: Text(
                            "Style " + (index + 1).toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ))),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
