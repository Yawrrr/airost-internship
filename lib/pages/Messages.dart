// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              switch (index) {
                case 0:
                  Navigator.pushReplacementNamed(context, '/');
                  break;
                case 1:
                  Navigator.pushReplacementNamed(context, '/task');
                  break;
                case 2:
                  Navigator.pushReplacementNamed(context, '/messages');
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, '/heleper');
                  break;
                case 4:
                  Navigator.pushReplacementNamed(context, '/profile');
                  break;
              }
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/vectors/Home.svg'),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/vectors/Task.svg'),
                label: 'Tasks'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(_selectedIndex == 2
                    ? 'assets/vectors/Messages_filled.svg'
                    : 'assets/vectors/Messages.svg'),
                label: 'Messages'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/vectors/Helepers.svg'),
                label: 'Helepers'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/vectors/Profile.svg'),
                label: 'Profile')
          ]),
    );
  }
}
