import 'package:flutter/material.dart';
import 'package:weighttracker/app_config.dart';
import 'package:weighttracker/bloc.dart';

class AddWeight extends StatefulWidget {
  final String mobileNo;
  final UserBloc userBloc;

  AddWeight({this.mobileNo, this.userBloc});

  @override
  _AddWeightState createState() => _AddWeightState();
}

class _AddWeightState extends State<AddWeight> {
  final controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    widget.userBloc.fetchUserWeights(widget.mobileNo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.userBloc.weight,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Text('Something went wrong  ${snapshot.error}');
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Text(
                  AppConfig.addWeight,
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
                    width: 150,
                    height: 150,
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
                    child: Center(
                      child: TextFormField(
                        controller: controller,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 60.0, height: 2.0, color: Colors.black),
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: AppConfig.kgText),
                      ),
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
                            onTap: () {
                              widget.userBloc.addUserWeight(
                                  widget.mobileNo, controller.text.toString());
                              controller.text = '';
                            },
                            child: Text(
                              AppConfig.addWeightInKg,
                              style: TextStyle(color: Colors.white),
                            )))),
              )
            ],
          ),
        );
      },
    );
  }
}
