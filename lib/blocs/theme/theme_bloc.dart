import 'package:flutter_kundol/index/index.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(ThemeData(
          brightness:
              AppData.isDefaultDark ? Brightness.dark : Brightness.light,
          primarySwatch:
              AppData.kPrimaryColor, //AppData.colors[AppData.defaultColor],
          primaryColor: AppData.kPrimaryColor,
          fontFamily: 'MontserratRegular',
        )));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeLoadStarted) {
      yield* _mapThemeLoadStartedToState();
    } else if (event is ThemeColorChanged) {
      yield* _mapThemeColorToState(event.selectedIndex);
    } else if (event is ThemeModeChanged) {
      yield* _mapThemeModeToState(event.isDark);
    }
  }

  Stream<ThemeState> _mapThemeLoadStartedToState() async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    final int selectedColorIndex = sharedPrefService.selectedColorIndex;
    final bool isDark = sharedPrefService.selectedThemeDark;

    ThemeData themeData;

    if (selectedColorIndex == null || isDark == null) {
      themeData = ThemeData(
        brightness: AppData.isDefaultDark ? Brightness.dark : Brightness.light,
        primarySwatch: AppData.isDefaultDark
            ? AppData.colors[AppData.defaultColor]
            : AppData.kPrimaryColor,
        primaryColor: AppData.isDefaultDark
            ? AppData.colors[AppData.defaultColor]
            : AppData.kPrimaryColor,
        fontFamily: 'MontserratRegular',
      );
      await sharedPrefService.setSelectedColorIndex(AppData.defaultColor);
      await sharedPrefService.setSelectedThemeDark(AppData.isDefaultDark);
    } else {
      themeData = ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primarySwatch:
            isDark ? AppData.colors[selectedColorIndex] : AppData.kPrimaryColor,
        primaryColor:
            isDark ? AppData.colors[selectedColorIndex] : AppData.kPrimaryColor,
        fontFamily: 'MontserratRegular',
      );
    }

    yield ThemeState(themeData);
  }

  Stream<ThemeState> _mapThemeColorToState(int selectedIndex) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    await sharedPrefService.setSelectedColorIndex(selectedIndex);
    final bool isDark = sharedPrefService.selectedThemeDark;

    yield ThemeState(ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: AppData.colors[selectedIndex],
      primaryColor:
          isDark ? AppData.colors[selectedIndex] : AppData.kPrimaryColor,
      fontFamily: 'MontserratRegular',
    ));
  }

  Stream<ThemeState> _mapThemeModeToState(bool isDark) async* {
    final sharedPrefService = await SharedPreferencesService.instance;
    await sharedPrefService.setSelectedThemeDark(isDark);
    final int colorIndex = sharedPrefService.selectedColorIndex;

    yield ThemeState(ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: isDark ? Colors.green : AppData.kPrimaryColor,
      primaryColor: isDark ? AppData.colors[colorIndex] : AppData.kPrimaryColor,
      fontFamily: 'MontserratRegular',
    ));
  }
}
