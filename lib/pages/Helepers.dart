// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Helepers extends StatefulWidget {
  const Helepers({super.key});

  @override
  State<Helepers> createState() => _HelepersState();
}

class _HelepersState extends State<Helepers> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: Colors.white,
        elevation: 0,
        title: //Page Title
            Text(
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
            Center(
              child: Column(children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registerHeleper');
                    },
                    icon: Icon(Icons.add)),
                Text('Not a Heleper?'),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
