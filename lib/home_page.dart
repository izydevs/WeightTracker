import 'package:flutter/material.dart';
import 'package:weighttracker/app_config.dart';
import 'package:weighttracker/bloc.dart';
import 'package:weighttracker/user_weights.dart';

import 'add_weight.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final userBloc = UserBloc();
  List<Widget> _pages;
  TabController _controller;
  String mobileNo ;

  @override
  void initState() {
    // TODO: implement initState
    mobileNo = AppConfig.prefs.get('mobileNo');
    _controller = TabController(vsync: this, length: 2);
    _pages = [
      AddWeight(userBloc: userBloc, mobileNo: mobileNo),
      UserWeights(userBloc: userBloc, mobileNo: mobileNo),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(AppConfig.appName, style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Icon(Icons.power_settings_new,color: Colors.black,),
                onTap: () {
                  AppConfig.prefs.clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(title:AppConfig.appName),
                      ));
                },
              ),
            ),
          ],
          bottom: TabBar(
            controller: _controller,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Add Weight',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                'Weight List',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              )
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: _pages,
              ),
            ),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
