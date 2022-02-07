import 'dart:convert';
import 'dart:math';

class RandomString {
  static String randomString;

  static String randomStringGene({int len = 25}) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    randomString = base64UrlEncode(values);
    return randomString;
  }

  static String get getRandomSessionId => randomString;
}
