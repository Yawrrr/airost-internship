// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helep_v1/Components/text_box.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int _selectedIndex = 4;

  final currentUser = FirebaseAuth.instance.currentUser!;


  //edit 
  Future <void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Edit $field" ,
          style : const TextStyle(color : Colors.white),
          ),
        content : TextField(
          autofocus:true ,
          style : TextStyle(color:Colors.white),
          decoration:InputDecoration(
            hintText: "Enter new $field",
            hintStyle:TextStyle(color: Colors.grey),
          ),
        )  
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),

      body: ListView(
        children: [
          const SizedBox(height: 50,),

          //profile pic 
          const Icon(
            Icons.person,
            size: 72,
          ),
          const SizedBox(height: 50,),


          //email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color:Colors.grey[700]),
          ),
          const SizedBox(height: 50,),


          //user detials
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "My Detials",
              style: TextStyle(color:Colors.grey[600]),   
              ),
          ),


          //username
          MyTextBox(
            text:'username',
            sectionName: 'username', 
            onPressed: () => editField('username'),
            ),
          

          //bio 
          MyTextBox(
            text: 'empty bio', 
            sectionName: 'bio', 
            onPressed: () => editField('bio'),
            ),
          const SizedBox(height: 50,),

          
          //History
           Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "History",
              style: TextStyle(color:Colors.grey[600]),   
              ),
          ),

        ],
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
