// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helep_v1/pages/Helepers.dart';
import 'package:helep_v1/pages/Home.dart';
import 'package:helep_v1/pages/Messages.dart';
import 'package:helep_v1/pages/Task.dart';
import 'package:helep_v1/pages/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/messages': (context) => Messages(),
        '/task': (context) => Task(),
        '/heleper': (context) => Helepers(),
        '/profile': (context) => Profile(),
        '/createTask' :(context) => CreateTask(),
      },
    );
  }
}
