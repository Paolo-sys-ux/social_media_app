import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:social_media_app/bloc/upload_image/upload_image_bloc.dart';
import 'package:social_media_app/screen/home/home.dart';
import 'package:social_media_app/screen/home_screen/home_screen.dart';
import 'package:social_media_app/screen/messages/messages.dart';
import 'package:social_media_app/screen/notifications_screen/notifications_screen.dart';
import 'package:social_media_app/screen/search_screen/search_screen.dart';
import 'package:social_media_app/screen/signin/signin.dart';
import 'package:social_media_app/screen/user_screen/user_screen.dart';
import 'package:social_media_app/view_data/view_data.dart';

import 'style.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    NotificationsScreen(),
    UserScreen(),
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
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        child: Container(
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              spreadRadius: 5,
            )
          ]),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    _currentIndex == 0 ? Icons.home : Icons.home_filled,
                    size: 30,
                    color: _currentIndex == 0
                        ? Color(0xFF514A43)
                        : Color(0xFF514A43),
                  ),
                  title: Text('')
                  // Text(
                  //   'Home',
                  //   style: kTextButton.copyWith(
                  //     color: _currentIndex == 0 ? Colors.black : Colors.black87,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  ),
              BottomNavigationBarItem(
                  icon: Icon(
                    _currentIndex == 1 ? Icons.search : Icons.search_outlined,
                    size: 30,
                    color: _currentIndex == 1
                        ? Color(0xFF514A43)
                        : Color(0xFF514A43),
                  ),
                  title: Text('')
                  // Text(
                  //   'Search',
                  //   style: kTextButton.copyWith(
                  //     color: _currentIndex == 1 ? Colors.black : Colors.black87,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  ),
              BottomNavigationBarItem(
                  icon: Icon(
                    _currentIndex == 2
                        ? Icons.notifications
                        : Icons.notifications,
                    size: 30,
                    color: _currentIndex == 2
                        ? Color(0xFF514A43)
                        : Color(0xFF514A43),
                  ),
                  title: Text('')
                  // Text(
                  //   'Notifications',
                  //   style: kTextButton.copyWith(
                  //     color: _currentIndex == 2 ? Colors.black : Colors.black87,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  ),
              BottomNavigationBarItem(
                  icon: Icon(
                    _currentIndex == 3 ? Icons.person : Icons.person,
                    size: 30,
                    color: _currentIndex == 3
                        ? Color(0xFF514A43)
                        : Color(0xFF514A43),
                  ),
                  title: Text('')
                  // Text(
                  //   'User',
                  //   style: kTextButton.copyWith(
                  //     color: _currentIndex == 3 ? Colors.black : Colors.black87,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.black,
        elevation: 5,
      ),
    );
  }
}
