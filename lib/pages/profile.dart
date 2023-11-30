// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Column(
            children: const [
              //Page Title
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
