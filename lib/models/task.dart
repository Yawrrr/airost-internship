import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String username;
  final String from;
  final String to;
  final String date;
  final String time;
  final String pax;
  final String remark;
  final Timestamp createTime;
  final String task;
  final String iconpath;

  Task(
      {required this.username,
      required this.from,
      required this.to,
      required this.date,
      required this.time,
      required this.pax,
      required this.remark,
      required this.createTime,
      required this.task,
      required this.iconpath});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'from': from,
      'to': to,
      'date': date,
      'time': time,
      'pax': pax,
      'remark': remark,
      'createTime': createTime,
      'task':task,
      'iconpath':iconpath,
    };
  }
}
