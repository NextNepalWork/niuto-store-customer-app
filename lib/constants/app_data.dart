import 'package:flutter/material.dart';
import 'package:flutter_kundol/api/responses/settings_response.dart';
import 'package:flutter_kundol/models/currency_date.dart';
import 'package:flutter_kundol/models/get_wishlist_on_start_data.dart';
import 'package:flutter_kundol/models/language_data.dart';
import 'package:flutter_kundol/models/user.dart';
import 'package:flutter_kundol/random/random.dart';

class AppData {
  static const List<Locale> languages = [
    Locale('en'),
    Locale('ar'),
    Locale("ur"),
  ];
  static const MaterialColor kPrimaryColor = MaterialColor(
    0xff1cc01c,
    const <int, Color>{
      50: const Color(0xff1cc01c),
      100: const Color(0xff1cc01c),
      200: const Color(0xff1cc01c),
      300: const Color(0xff1cc01c),
      400: const Color(0xff1cc01c),
      500: const Color(0xff1cc01c),
      600: const Color(0xff1cc01c),
      700: const Color(0xff1cc01c),
      800: const Color(0xff1cc01c),
      900: const Color(0xff1cc01c),
    },
  );

  static const List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.brown,
  ];

  static const int defaultColor = 0;
  static const bool isDefaultDark = false;

  static CurrencyData currency;
  static LanguageData language;
  static SettingsResponse settingsResponse;
  static User user;
  static String accessToken;
  static String sessionId = RandomString.getRandomSessionId;
  static List<GetWishlistOnStartData> wishlistData = [];
}
