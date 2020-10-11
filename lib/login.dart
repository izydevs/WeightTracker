import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weighttracker/app_config.dart';
import 'package:weighttracker/bloc.dart';
import 'package:weighttracker/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userBloc = UserBloc();
  final controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    userBloc.fetchUserDetails('mobileNo');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
      ),
      body: StreamBuilder(
        stream: userBloc.user,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Text('Something went wrong  ${snapshot.error}');
          }
          return Container(
            color: Colors.white10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 64.0),
                  child: Text(
                    AppConfig.weightTrackText,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 16.0, top: 64.0, right: 16.0),
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 25.0, // soften the shadow
                              spreadRadius: 5.0, //extend the shadow
                              offset: Offset(
                                5.0, // Move to right 10  horizontally
                                5.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white),
                      child: TextFormField(
                        controller: controller,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: AppConfig.enterMobileNo),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 25.0, // soften the shadow
                              spreadRadius: 5.0, //extend the shadow
                              offset: Offset(
                                15.0, // Move to right 10  horizontally
                                15.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.green),
                      child: Center(
                          child: InkWell(
                              onTap: (){
                                userBloc.createNewUser(controller.text.toString(),context);
                              },
                              child: Text(
                                AppConfig.loginText,
                                style: TextStyle(color: Colors.white),
                              )))),
                )
              ],
            ),
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
