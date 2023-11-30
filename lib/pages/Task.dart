// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helep_v1/services/task/task_service.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int _selectedIndex = 1;
  final TaskService _task = TaskService();
  bool isHeleper = false;

  @override
  void initState() {
    super.initState();
    _checkIsHeleper;
  }

  Future<void> _checkIsHeleper() async {
    // Retrieve the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();

        if (documentSnapshot.exists) {
          // Assuming 'helper' is the field indicating whether the user is a service provider
          isHeleper = documentSnapshot['heleper'] ?? false;
        }
      } catch (error) {
        print('Error fetching user data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Expanded(child: _buildTaskList()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      Navigator.pushNamed(context, '/createTask');
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return FutureBuilder<void>(
        future: _checkIsHeleper(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          return StreamBuilder(
            stream: _task.getTask(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading');
              }

              return ListView(
                children: snapshot.data!.docs
                    .map((document) => _buildTaskItem(document, isHeleper))
                    .toList(),
              );
            },
          );
        });
  }

  //build task item
  Widget _buildTaskItem(DocumentSnapshot document, bool isHeleper) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (isHeleper) {
      return getHeleperTask(document, user);
    } else {
      return getNonHeleperTask(document);
    }
  }
}

Widget getHeleperTask(DocumentSnapshot document, User? user) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  return Card(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  width: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(data['iconpath']),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                data['task'],
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            data['username'],
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 10,
                child: Center(
                  child: Text(
                    data['from'],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 4, child: Icon(Icons.arrow_forward)),
              Expanded(
                flex: 10,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(
                      data['to'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text('Date: '),
              Text(data['date']),
            ],
          ),
          Row(
            children: [
              Text('Time: '),
              Text(data['time']),
            ],
          ),
          Row(
            children: [
              Text('Pax: '),
              Text(data['pax']),
            ],
          ),
          Row(
            children: [
              Text('Remark: '),
              Text(data['remark']),
            ],
          ),
          TextButton(
              onPressed: () {
                _acceptTask(document.id, user?.uid, data);
              },
              child: Text('Accept')),
        ],
      ),
    ),
  );
}

Widget getNonHeleperTask(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  return Card(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  width: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(data['iconpath']),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                data['task'],
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            data['username'],
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 10,
                child: Center(
                  child: Text(
                    data['from'],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 4, child: Icon(Icons.arrow_forward)),
              Expanded(
                flex: 10,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(
                      data['to'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text('Date: '),
              Text(data['date']),
            ],
          ),
          Row(
            children: [
              Text('Time: '),
              Text(data['time']),
            ],
          ),
          Row(
            children: [
              Text('Pax: '),
              Text(data['pax']),
            ],
          ),
          Row(
            children: [
              Text('Remark: '),
              Text(data['remark']),
            ],
          ),
        ],
      ),
    ),
  );
}

void _acceptTask(
    String taskId, String? heleperId, Map<String, dynamic> taskData) async {
  if (heleperId != null) {
    final CollectionReference tasks =
        FirebaseFirestore.instance.collection('task');
    final DocumentReference taskRef = tasks.doc(taskId);

    // Update the task document to mark it as accepted and heleper provider info
    await taskRef.update({
      'accepted': true,
      'heleperId': heleperId,
    });

    // Move the accepted task to the helepers' accepted task list
    final CollectionReference acceptedTasks = FirebaseFirestore.instance
        .collection('user')
        .doc(heleperId)
        .collection('acceptedTasks');

    await acceptedTasks.add({
      'taskId': taskId,
      'heleperId': heleperId,
      'taskData': taskData,
    });

    //delete the task from the list
    await taskRef.delete();
  }
}
