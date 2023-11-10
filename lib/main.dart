// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:helep_v1/firebase_options.dart';
import 'package:helep_v1/pages/Helepers.dart';
import 'package:helep_v1/pages/Home.dart';
import 'package:helep_v1/pages/Messages.dart';
import 'package:helep_v1/pages/Task.dart';
import 'package:helep_v1/pages/login_pages.dart';
import 'package:helep_v1/pages/profile.dart';
import 'package:helep_v1/pages/register_page.dart';
import 'package:helep_v1/services/auth/auth_gate.dart';
import 'package:helep_v1/services/auth/auth_services.dart';
import 'package:helep_v1/services/auth/login_or_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (context) => AuthService(),
    child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthGate(),
        '/messages': (context) => Messages(),
        '/task': (context) => Task(),
        '/heleper': (context) => Helepers(),
        '/profile': (context) => Profile(),
        '/createTask': (context) => CreateTask(),
      },
    );
  }
}
