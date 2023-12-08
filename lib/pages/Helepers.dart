// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helep_v1/services/task/task_service.dart';

class Helepers extends StatefulWidget {
  const Helepers({super.key});

  @override
  State<Helepers> createState() => _HelepersState();
}

class _HelepersState extends State<Helepers> {
  final TaskService _task = TaskService();
  bool isHeleper = false;

  Future<void> _checkIsHeleper() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();

        if (documentSnapshot.exists) {
          isHeleper = documentSnapshot['heleper'];
        }
      } catch (error) {
        print('Error fetching user data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkIsHeleper();
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    return FutureBuilder<void>(
      future: _checkIsHeleper(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // You can return a loading indicator or placeholder here
          return CircularProgressIndicator();
        }

        // Use the value of isHeleper in your UI
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 64,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Helepers',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Column(
              children: [
                Expanded(child: _buildHeleperList(uid)),
                if (!isHeleper)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registerHeleper');
                        },
                        child: Text('Not a Heleper?'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeleperList(String uid) {
    return StreamBuilder(
      stream: _task.getHeleper(uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        List<DocumentSnapshot> users = snapshot.data!.docs;
        List<DocumentSnapshot> heleperUsers =
            users.where((user) => user['heleper'] == true).toList();

        return ListView(
          children: heleperUsers
              .map((document) => _buildHeleperItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildHeleperItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final User? user = FirebaseAuth.instance.currentUser;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.person_2),
            SizedBox(
              width: 16,
            ),
            Expanded(child: Text(data['username'])),
            TextButton(onPressed: () {}, child: Text('Message'))
          ],
        ),
      ),
    );
  }
}
