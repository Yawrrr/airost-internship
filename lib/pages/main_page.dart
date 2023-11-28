import 'package:flutter/material.dart';
import 'package:helep_v1/pages/Helepers.dart';
import 'package:helep_v1/pages/HomePage.dart';
import 'package:helep_v1/pages/Messages.dart';
import 'package:helep_v1/pages/Task.dart';
import 'package:helep_v1/pages/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _main_pageState();
}

class _main_pageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottonNavigationBar(context),
      body: <Widget>[
        HomePage(),
        Task(),
        Messages(),
        Helepers(),
        Profile(),
      ][_selectedIndex],
    );
  }

  NavigationBar BottonNavigationBar(BuildContext) {
    return NavigationBar(
      height: 56,
      selectedIndex: _selectedIndex,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.task), label: 'Task'),
        NavigationDestination(icon: Icon(Icons.message), label: 'Messages'),
        NavigationDestination(icon: Icon(Icons.people), label: 'Helepers'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
