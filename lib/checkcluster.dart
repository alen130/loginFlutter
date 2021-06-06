import 'dart:ui';
import 'package:flutter/material.dart';



class CheckClusterPage extends StatelessWidget {
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
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              // even space distribution
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Column(
            children: <Widget>[
              Text(
              "Verify the work",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.yellowAccent
              ),
            ),
  ],
          ),
  ],
      ),
          ),
      ),
          );
  }
  }