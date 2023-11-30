// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helep_v1/models/services_model.dart';
import 'package:helep_v1/pages/Helepers.dart';
import 'package:helep_v1/pages/Messages.dart';
import 'package:helep_v1/pages/Task.dart';
import 'package:helep_v1/pages/profile.dart';
import 'package:helep_v1/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //user sign out
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  int _selectedIndex = 0;

  List<ServiceModel> services = [];

  void getInitialInfo() {
    services = ServiceModel.getService();
  }

  @override
  Widget build(BuildContext context) {
    getInitialInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
        ),
        actions: [
          //sign out button

          IconButton(onPressed: signOut, icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 16, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/createTask');
                },
                child: Text('Create a task'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5BAAEF)),
              ),
            ),
            Container(
              height: 360.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 12),
                  child: Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  child: ListView.separated(
                    itemCount: services.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 6,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: 116,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                  offset: Offset(0, 0),
                                )
                              ]),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child:
                                        Image.asset(services[index].iconpath),
                                  ),
                                ),
                                Text(services[index].name),
                              ]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar bottomNavigator(BuildContext context) {
    return BottomNavigationBar(
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
              icon: SvgPicture.asset(_selectedIndex == 0
                  ? 'assets/vectors/Home_filled.svg'
                  : 'assets/vectors/Home.svg'),
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
              icon: SvgPicture.asset('assets/vectors/Profile.svg'),
              label: 'Profile')
        ]);
  }
}
