import 'package:flutter_kundol/index/index.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) => SwitchListTile(
                  inactiveTrackColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Theme.of(context).brightness != Brightness.dark
                      ? const Color(0xfff2f2f2)
                      : Colors.black,
                  title: Text("Dark Mode"),
                  value: state.themeData.brightness == Brightness.dark
                      ? true
                      : false,
                  onChanged: (value) {
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeModeChanged(value));
                  },
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(10),
              //   child: ExpansionTile(
              //     backgroundColor:
              //         Theme.of(context).brightness != Brightness.dark
              //             ? const Color(0xfff2f2f2)
              //             : Colors.black,
              //     collapsedBackgroundColor:
              //         Theme.of(context).brightness != Brightness.dark
              //             ? const Color(0xfff2f2f2)
              //             : Colors.black,
              //     title: Text("Color"),
              //     children: List.generate(
              //       AppData.colors.length,
              //       (index) => ListTile(
              //         onTap: () => BlocProvider.of<ThemeBloc>(context)
              //             .add(ThemeColorChanged(index)),
              //         title: Text("Color " + index.toString()),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Theme.of(context).brightness != Brightness.dark
                    ? const Color(0xfff2f2f2)
                    : Colors.black,
                title: Text("About us"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (BuildContext context) {
                              return GetPageBloc(RealPageRepo());
                            },
                            child: ContentScreen(1)),
                      ));
                },
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ExpansionTile(
                  backgroundColor:
                      Theme.of(context).brightness != Brightness.dark
                          ? const Color(0xfff2f2f2)
                          : Colors.black,
                  collapsedBackgroundColor:
                      Theme.of(context).brightness != Brightness.dark
                          ? const Color(0xfff2f2f2)
                          : Colors.black,
                  title: Text("Policy"),
                  children: [
                    ListTile(
                      title: Text("Refund Policy"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (BuildContext context) {
                                    return GetPageBloc(RealPageRepo());
                                  },
                                  child: ContentScreen(2)),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text("Privacy Policy"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (BuildContext context) {
                                    return GetPageBloc(RealPageRepo());
                                  },
                                  child: ContentScreen(3)),
                            ));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Theme.of(context).brightness != Brightness.dark
                    ? const Color(0xfff2f2f2)
                    : Colors.black,
                title: Text("Terms and Conditions"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (BuildContext context) {
                              return GetPageBloc(RealPageRepo());
                            },
                            child: ContentScreen(4)),
                      ));
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Theme.of(context).brightness != Brightness.dark
                    ? const Color(0xfff2f2f2)
                    : Colors.black,
                title: Text("Share App"),
                onTap: () async {
                  await Share.share(
                      "Hi there, please check this app. i think you will love it. ");
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Theme.of(context).brightness != Brightness.dark
                    ? const Color(0xfff2f2f2)
                    : Colors.black,
                title: Text("Rate My App"),
                onTap: () async {
                  final InAppReview inAppReview = InAppReview.instance;

                  if (await inAppReview.isAvailable()) {
                    inAppReview.openStoreListing(appStoreId: "storeid");
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) => ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Theme.of(context).brightness != Brightness.dark
                      ? const Color(0xfff2f2f2)
                      : Colors.black,
                  title: Text("Logout"),
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(PerformLogout());
                  },
                ),
                listener: (context, state) {
                  if (state is UnAuthenticated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("logout successful")));
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
