import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:weighttracker/app_config.dart';
import 'package:weighttracker/home_page.dart';
import 'package:weighttracker/repository.dart';
import 'package:weighttracker/weight_tracker.dart';

class UserBloc{

  final UserRepository _repository = UserRepository();
  final _user = BehaviorSubject<String>();
  Stream get user => _user.stream;
  final _weight = BehaviorSubject<List<WeightTracker>>();
  Stream<List<WeightTracker>> get weight => _weight.stream;

  void createNewUser(String mobileNo, BuildContext context){
    _repository.createNewUser(mobileNo).then((event) {
      bool res = event;
      print(res);
      if(res){
        AppConfig.prefs.setString('mobileNo', mobileNo);
        _user.add('success');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
      }
    });
  }

  void fetchUserDetails(String mobileNo){
    _repository.fetchUserDetails(mobileNo);
    _user.add('event');
  }

  void addUserWeight(String mobileNo,String weightTracker){
    _repository.addUserWeight(mobileNo,weightTracker);
  }

  void fetchUserWeights(String mobileNo){
    _repository.fetchUserWeights(mobileNo).listen((event) {
      List<WeightTracker> _temp = [];
      event.documents.forEach((element) {
        WeightTracker weightTracker;
        try{
          weightTracker = WeightTracker.fromSnapshot(element);
        }catch(e){
          print(e);
        }
        _temp.add(weightTracker);
      });
      _weight.add(_temp);
    });
  }

  void updateUserWeights(String id,String updatedWeight){
    print('updated weight is $updatedWeight');
    _repository.updateUserWeights(id,updatedWeight);
  }

  void deleteUserWeights(String mobileNo, String id){
    _repository.deleteUserWeights(mobileNo,id);
  }
}