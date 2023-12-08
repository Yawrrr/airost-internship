import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helep_v1/Components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? OnProfileTap;
  final void Function()? OnSignOut;
  const MyDrawer({super.key,required this.OnProfileTap,required this.OnSignOut,});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
                 //header 
       const DrawerHeader(
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: 64,
        ),
       ),
      MyListTile(
        icon: Icons.home, 
        text: 'H O M E',
        onTap: ()=> Navigator.pop(context),
      ),

      Padding(
        padding: const EdgeInsets.only(bottom : 25.0),
        child: MyListTile(
          icon: Icons.person, 
          text: 'P R O F I L E',
          onTap: OnProfileTap,
        ),
      ),
        ],),

      MyListTile(
        icon: Icons.logout, 
        text: 'L O G O U T',
        onTap: OnSignOut,
      ),
      ]
      ),
    );
  }
}