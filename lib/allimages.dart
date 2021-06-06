import 'dart:ui';
import 'package:flutter/material.dart';



class ViewImagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/dback.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}