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
      backgroundColor: Colors.black,
       body : Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget> [
              SliverAppBar(
                expandedHeight: 450,
                backgroundColor:Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
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
                      child: Padding(
                        padding:EdgeInsets.all(20),
                        child: Center(
                          child: Column(                         
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[      
                                                
                                Text("Jay Chou",style: 
                                TextStyle(
                                  color: Colors.white , fontWeight: FontWeight.bold , fontSize: 40)
                                  
                                ,),
                                SizedBox(height: 20,),
                                Row(
                                  children: <Widget>[],
                                )
                            ],
                          ),
                        ), 
                        ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children : <Widget>[
                      Text("+ 60 12345678",style:TextStyle(color: Colors.white ,fontSize: 18 , fontWeight:FontWeight.bold , fontFamily: 'OpenSans')),
                      SizedBox(height:10,),
                      Text("Tap to change phone number",style:TextStyle(color: Colors.grey)),
                      SizedBox(height:20,),
                      Text("@abcdef",style:TextStyle(color: Colors.white ,fontSize: 18 , fontWeight:FontWeight.bold ,fontFamily: 'OpenSans')),
                      SizedBox(height:10,),
                      Text("Username",style:TextStyle(color: Colors.grey)),
                      SizedBox(height:20,),
                      Text("Bio",style:TextStyle(color: Colors.white ,fontSize: 18 , fontWeight:FontWeight.bold ,fontFamily: 'OpenSans')),
                      SizedBox(height:10,),
                      Text("Add a few words about yourself",style:TextStyle(color: Colors.grey)),
                      SizedBox(height:20,),
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(height:120,),
                      
                    ]
                  )
          )])),
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
