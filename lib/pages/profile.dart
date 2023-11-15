// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body : Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget> [
              SliverAppBar(
                expandedHeight: 450,
                backgroundColor:Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/jay.jpg'),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            Colors.black.withOpacity(.3)
                          ]
                        )
                      ),
                      
                    ),
                  ),
                ),
              )
            ],
          )
        ],),   
    
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
                icon: SvgPicture.asset('assets/vectors/Messages.svg'),
                label: 'Messages'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/vectors/Helepers.svg'),
                label: 'Helepers'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(_selectedIndex == 1
                    ? 'assets/vectors/Profile_filled.svg'
                    : 'assets/vectors/Profile.svg'),
                label: 'Profile')
          ]),
    );
  }
}
