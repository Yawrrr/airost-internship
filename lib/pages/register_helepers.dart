// ignore_for_file: use_build_context_synchronously, camel_case_types, avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Register as a Heleper now!'),
            IconButton(
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
              icon: SvgPicture.asset('assets/icons/register.svg'),
            )
          ],
        ),
      ),
    );
  }
}
