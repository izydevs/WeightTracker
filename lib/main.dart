import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weighttracker/app_config.dart';
import 'package:weighttracker/home_page.dart';
import 'package:weighttracker/login.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initSetup();
  runApp(MyApp());
}

Future<void> initSetup() async {
  AppConfig.prefs = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  String mobileNo;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    mobileNo = AppConfig.prefs.get('mobileNo');
    return MaterialApp(
      home: (mobileNo==null) ?LoginPage(title: 'Weight Tracker'):MyHomePage(),
    );
  }
}
