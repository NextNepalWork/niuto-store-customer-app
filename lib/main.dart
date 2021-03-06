import 'package:flutter_kundol/index/index.dart';

import 'models/currency_date.dart';

void main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  RandomString.randomStringGene();

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("YOUR_ONESIGNAL_APP_ID");

  //The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  runApp(RestartWidget(
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          LanguageData languageData = LanguageData();
          languageData.languageName = "English";
          languageData.id = 1;
          languageData.code = "en";

          return LanguageBloc(languageData)..add(LanguageLoadStarted());
        }),
        BlocProvider(
          create: (context) {
            CurrencyData currencyData = CurrencyData();

            currencyData.title = "USD";
            currencyData.currencyId = 1;
            currencyData.code = "\$";

            return CurrencyBloc(currencyData)..add(CurrencyLoadStarted());
          },
        ),
        BlocProvider(create: (context) => ThemeBloc()..add(ThemeLoadStarted())),
        BlocProvider(create: (context) => BannersBloc(RealBannersRepo())),
        BlocProvider(create: (context) => CategoriesBloc(RealCategoriesRepo())),
        BlocProvider(create: (context) => ProductsBloc(RealProductsRepo())),
        BlocProvider(create: (context) => AuthBloc(RealAuthRepo())),
        BlocProvider(
          create: (context) => ProductsSearchBloc(RealProductsRepo()),
        ),
        BlocProvider(
          create: (context) => WishlistProductsBloc(RealWishlistRepo()),
        ),
        BlocProvider(create: (context) => CartBloc(RealCartRepo())),
        BlocProvider(
          create: (context) => WishlistBloc(RealWishlistRepo(),
              BlocProvider.of<WishlistProductsBloc>(context)),
        ),
        BlocProvider(
          create: (context) => FiltersBloc(RealFiltersRepo()),
        ),
        BlocProvider(create: (context) => ProfileBloc(RealProfileRepo())),
      ],
      child:
          ChangeNotifierProvider(create: (_) => CartCounter(), child: MyApp()),
    ),
  ));
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, currencyState) {
        AppData.currency = currencyState.currency;
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
            AppData.language = languageState.languageData;
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                return MaterialApp(
                  locale: Locale(languageState.languageData.code),
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    AppLocalizations.delegate,
                  ],
                  theme: themeState.themeData,
                  supportedLocales: AppData.languages,
                  home: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      systemNavigationBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.dark,
                      systemNavigationBarIconBrightness: Brightness.dark,
                    ),
                    child: BlocProvider(
                      create: (context) =>
                          ServerSettingsBloc(RealServerSettingsRepo()),
                      child: SplashScreen(),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
