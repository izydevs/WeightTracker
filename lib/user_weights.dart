import 'package:flutter/material.dart';
import 'package:weighttracker/app_config.dart';
import 'package:weighttracker/bloc.dart';
import 'package:weighttracker/weight_tracker.dart';

class UserWeights extends StatefulWidget {
  final String mobileNo;
  final UserBloc userBloc;

  UserWeights({this.mobileNo, this.userBloc});

  @override
  _UserWeightsState createState() => _UserWeightsState();
}

class _UserWeightsState extends State<UserWeights> {
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
        List<WeightTracker> list = snapshot.data;
        if (list == null || list.isEmpty) {
          return Center(child: Text('No yet added any weight'));
        }
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, index) {
            WeightTracker trackerData = list[index];
            return Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child:
                              Text('${trackerData.weight}${AppConfig.kgText}')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '${AppConfig.convertTime(trackerData.timeStamp)}'),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Icon(Icons.edit),
                            onTap: () {
                              editingController.text = trackerData.weight;
                              updateWeight(trackerData, context);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Icon(Icons.delete),
                            onTap: () {
                              widget.userBloc.deleteUserWeights(
                                  widget.mobileNo, trackerData.id);
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  final TextEditingController editingController = TextEditingController();
  void updateWeight(WeightTracker trackerData, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: AlertDialog(
              title: Text('Update weight'),
              content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 64.0, right: 16.0),
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
                            child: TextFormField(
                              controller: editingController,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 60.0,
                                  height: 2.0,
                                  color: Colors.black),
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15,
                                      bottom: 11,
                                      top: 11,
                                      right: 15),
                                  hintText: AppConfig.kgText),
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
                                      widget.userBloc.updateUserWeights(
                                          trackerData.id,
                                          editingController.text.toString());
                                      editingController.text = '';
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      AppConfig.updateWeightInKg,
                                      style: TextStyle(color: Colors.white),
                                    )))),
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
