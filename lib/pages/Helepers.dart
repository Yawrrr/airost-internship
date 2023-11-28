// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Helepers extends StatefulWidget {
  const Helepers({super.key});

  @override
  State<Helepers> createState() => _HelepersState();
}

class _HelepersState extends State<Helepers> {
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          children: [
            //Page Title
            Text(
              'Helepers',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
