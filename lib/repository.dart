import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:weighttracker/weight_tracker.dart';

class UserRepository {
  final CollectionReference _refUser = Firestore.instance.collection('users');
  final CollectionReference _refWeight = Firestore.instance.collection('trackers');

  Future<bool> createNewUser(String mobileNo) async{
    try {
      Map<String, dynamic> postData = {'mobileNo':mobileNo};
      await _refUser.document(mobileNo).setData(postData);
      log('response');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  void fetchUserDetails(String mobileNo) {
    Query query;
    query = _refUser
        .where('mobileNo', isEqualTo: mobileNo);
  }

  void addUserWeight(String mobileNo, String weight) async {
    String id = Uuid().v1().replaceAll('-', '').substring(0,20);
    String timeStamp = '${DateTime.now().millisecondsSinceEpoch}';
    WeightTracker weightTracker = WeightTracker(
        id: id, mobileNo: mobileNo, weight: weight, timeStamp: timeStamp);
    try {
      Map<String, dynamic> postData = weightTracker.toMap();
      await _refWeight.document(id.toString()).setData(postData);
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot> fetchUserWeights(String mobileNo) {
    log('message $mobileNo');
    Query query;
    query = _refWeight.where('mobileNo',isEqualTo:mobileNo);
    assert(query != null);
    return query.snapshots();
  }

  void deleteUserWeights(String mobileNo, String id) {
    _refWeight.document(id).delete();
  }

  void updateUserWeights(String id, String weight) {
    _refWeight.document(id).updateData({'weight':weight});
  }
}
