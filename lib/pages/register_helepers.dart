// ignore_for_file: use_build_context_synchronously, camel_case_types, avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class registerHeleper extends StatefulWidget {
  const registerHeleper({super.key});

  @override
  State<registerHeleper> createState() => _registerHeleperState();
}

class _registerHeleperState extends State<registerHeleper> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('user')
                    .doc(user.uid)
                    .update({
                  'heleper': true,
                });
              } catch (error) {
                print('Error during registration: $error');
              }
              Navigator.pop(context);
            },
            icon: const Icon(Icons.app_registration_rounded)),
      ),
    );
  }
}
