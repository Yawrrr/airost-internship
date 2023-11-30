import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helep_v1/models/services_model.dart';
import 'package:helep_v1/models/task.dart';

class TaskService extends ChangeNotifier {
  // get the instance of firebaseAuth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get serivce list

  List<ServiceModel> services = ServiceModel.getService();

  void getInitialInfo() {
    services = ServiceModel.getService();
  }

  //create a task
  Future<void> createTask(String from, String to, String date, String time,
      String pax, String remark) async {
    List<ServiceModel> services = ServiceModel.getService();
    //get user info
    final String uid = _firebaseAuth.currentUser!.uid;
    final Timestamp createTime = Timestamp.now();
    final DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    final currentUsername = document.get('username');
    getInitialInfo();
    final String taskname = services[0].name;
    final String iconpath = services[0].iconpath;

    //create a new task
    Task newTask = Task(
      username: currentUsername,
      from: from,
      to: to,
      date: date,
      time: time,
      pax: pax,
      remark: remark,
      createTime: createTime,
      task: taskname,
      iconpath: iconpath,
    );

    //add new task to database
    await _firestore.collection('task').add(newTask.toMap());
  }

  //get task
  Stream<QuerySnapshot> getTask() {
    return _firestore
        .collection('task')
        .orderBy('createTime', descending: false)
        .snapshots();
  }
}

