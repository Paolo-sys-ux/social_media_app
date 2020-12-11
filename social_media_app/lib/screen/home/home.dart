import 'package:flutter/material.dart';
import 'package:social_media_app/constants/style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Home',
          style: kTextButton.copyWith(color: Colors.white),
        ),
      ),
      body: Center(child: Text('Welcome Bro')),
    );
  }
}
