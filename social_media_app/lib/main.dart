import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:social_media_app/bloc/display_post/display_post_bloc.dart';
import 'package:social_media_app/bloc/facebook/facebook_bloc.dart';
import 'package:social_media_app/bloc/google/google_bloc.dart';
import 'package:social_media_app/bloc/upload_image/upload_image_bloc.dart';
import 'package:social_media_app/constants/navigation_bar.dart';
import 'package:social_media_app/screen/home/home.dart';
import 'package:social_media_app/screen/home_screen/home_screen.dart';
import 'package:social_media_app/screen/signin/signin.dart';
import 'package:social_media_app/screen/user_screen/user_screen.dart';
import 'package:social_media_app/view_data/view_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FacebookBloc>(
          create: (BuildContext context) => FacebookBloc(),
        ),
        BlocProvider<GoogleBloc>(
          create: (BuildContext context) => GoogleBloc(),
        ),
        BlocProvider<UploadImageBloc>(
          create: (BuildContext context) => UploadImageBloc(),
        ),
        BlocProvider<DisplayPostBloc>(
          create: (BuildContext context) => DisplayPostBloc(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/signup': (context) => SignIn(),
          '/home': (context) => Home(),
          '/navigationbar': (context) => NavigationBar(),
          '/viewdata': (context) => ViewData(),
          '/homescreen': (context) => HomeScreen(),
          '/userscreen': (context) => UserScreen(),
        },
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        debugShowCheckedModeBanner: false,
        title: 'Social Media App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignIn(),
      ),
    );
  }
}
