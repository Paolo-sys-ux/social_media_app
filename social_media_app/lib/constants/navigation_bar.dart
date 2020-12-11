import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:social_media_app/screen/signin/signin.dart';

import 'style.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    SignIn(),
  ];

  void onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0 ? Icons.add_circle : Icons.add_circle_outline,
              size: 30,
              color: _currentIndex == 0 ? Colors.deepPurple : Colors.grey,
            ),
            title: Text(
              'Blog feed',
              style: kTextButton.copyWith(
                color: _currentIndex == 0 ? Colors.deepPurple : Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1 ? Icons.assignment : Icons.assignment,
              size: 30,
              color: _currentIndex == 1 ? Colors.deepPurple : Colors.grey,
            ),
            title: Text(
              'Personal Blog',
              style: kTextButton.copyWith(
                color: _currentIndex == 1 ? Colors.deepPurple : Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
