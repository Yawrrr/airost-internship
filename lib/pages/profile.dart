// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helep_v1/Components/text_box.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;

  final currentUser = FirebaseAuth.instance.currentUser!;
  String currentUsername = '';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUser.uid)
          .get();
      setState(() {
        currentUsername = document.get('username') ?? '';
      });
    } catch (error) {
      print('Error loading user profile: $error');
    }
  }

  //edit
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text(
            "Edit $field",
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const SizedBox(
          height: 50,
        ),

        //profile pic
        const Icon(
          Icons.person,
          size: 72,
        ),
        const SizedBox(
          height: 50,
        ),

        //email
        Text(
          currentUser.email!,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 50,
        ),

        //user detials
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            "My Detials",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),

        //username
        MyTextBox(
          text: currentUsername,
          sectionName: 'username',
          onPressed: () => editField('username'),
        ),

        //bio
        MyTextBox(
          text: 'empty bio',
          sectionName: 'bio',
          onPressed: () => editField('bio'),
        ),
        const SizedBox(
          height: 50,
        ),

        //History
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            "History",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    ));
  }
}
