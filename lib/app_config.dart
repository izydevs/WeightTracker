
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static const String appName = 'Weight Tracker';
  static const String enterMobileNo = 'Enter mobile no.';
  static SharedPreferences prefs;

  static const String weightTrackText = 'Login to Track your Weight';

  static const String loginText = 'Login';

  static const String addWeight = 'Add your weight';
  static const String addWeightInKg = 'Add weight';
  static const String updateWeightInKg = 'Update weight';
  static const String kgText = 'KG';

  static String convertTime(String timeStamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000);
    return date.toString();
  }
}