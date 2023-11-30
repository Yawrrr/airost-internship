// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helep_v1/models/services_model.dart';
import 'package:helep_v1/services/auth/auth_services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onHelepersTap;

  const HomePage({Key? key, required this.onHelepersTap}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<bool> isHeleper;

  @override
  void initState() {
    super.initState();
    isHeleper = _checkIsHeleper();
  }

  Future<bool> _checkIsHeleper() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();

        if (documentSnapshot.exists) {
          return documentSnapshot['heleper'];
        }
      } catch (error) {
        print('Error fetching user data: $error');
      }
    }
    return false;
  }

  // user sign out
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  List<ServiceModel> services = [];

  void getInitialInfo() {
    services = ServiceModel.getService();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    getInitialInfo();
    return Scaffold(
      body: FutureBuilder<bool>(
        future: isHeleper,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            bool isHeleper = snapshot.data ?? false;
            return _buildHome(context, user, isHeleper);
          }
        },
      ),
    );
  }

  Widget _buildHome(BuildContext context, User user, bool isHeleper) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 26, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Home Page',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Expanded(child: Container()),
                // sign out button
                IconButton(onPressed: signOut, icon: Icon(Icons.logout))
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/createTask');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5BAAEF),
                ),
                child: Text('Create a task'),
              ),
            ),
            if (!isHeleper)
              GestureDetector(
                onTap: () {
                  widget.onHelepersTap();
                },
                child: Text('Register as a heleper?'),
              ),
            Expanded(
              child: Container(
                height: 360.0,
              ),
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
                SizedBox(
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
                              ),
                            ],
                          ),
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
                                  child: Image.asset(services[index].iconpath),
                                ),
                              ),
                              Text(services[index].name),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
