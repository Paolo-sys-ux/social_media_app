import 'package:flutter/material.dart';
import 'package:social_media_app/constants/style.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Notifications',
          style: kTextButton.copyWith(color: Color(0xFF514A43)),
        ),
      ),
    );
  }
}
