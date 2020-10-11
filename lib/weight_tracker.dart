import 'package:cloud_firestore/cloud_firestore.dart';

class WeightTracker extends BaseDataModel {
  String id;
  String mobileNo;
  String weight;
  String timeStamp;

  WeightTracker({this.id, this.mobileNo, this.weight, this.timeStamp});

  factory WeightTracker.fromSnapshot(DocumentSnapshot element) => WeightTracker(
      id: element.documentID,
      mobileNo: element['mobileNo'],
      weight: element['weight'],
      timeStamp: element['timeStamp']);

  factory WeightTracker.fromMap(Map<String, dynamic> map) => WeightTracker(
      id: map['id'],
      mobileNo: map['mobileNo'],
      weight: map['weight'],
      timeStamp: map['timeStamp']);

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'mobileNo': mobileNo,
        'weight': weight,
        'timeStamp': timeStamp
      };
}

abstract class BaseDataModel {
  BaseDataModel();

  BaseDataModel.fromSnapshot(DocumentSnapshot snapshot);

  BaseDataModel.fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap();
}
