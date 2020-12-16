import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media_app/bloc/facebook/facebook_bloc.dart';
import 'package:social_media_app/bloc/upload_image/upload_image_bloc.dart';
import 'package:social_media_app/constants/style.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  // Create a storage reference from our app

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: 275);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGallery() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 600, maxWidth: 275);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create Post'),
            children: [
              SimpleDialogOption(
                child: Text('Photo with Camera'),
                onPressed: () {
                  getImage();
                },
              ),
              SimpleDialogOption(
                child: Text('Photo in gallery'),
                onPressed: () {
                  getImageGallery();
                },
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  //for fcm
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (message) async {
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New Notification Alert";
        });
      },
      onResume: (message) async {
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Make a post',
          style: kTextButton.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                // BlocProvider.of<FacebookBloc>(context)
                //     .add(FacebookLogout(context: context));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              _image == null
                  ? InkWell(
                      onTap: () {
                        selectImage(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                        child: Image.asset(
                          'assets/images/default.jpg',
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        selectImage(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                        child: Image.file(
                          _image,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  // uploadImageToFirebase(context);
                  BlocProvider.of<UploadImageBloc>(context)
                      .add(UploadImage(image: _image));
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 50, right: 50),
                        child: Text(
                          'Post',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    BlocBuilder<UploadImageBloc, UploadImageState>(
                      builder: (context, state) {
                        if (state is UploadImageLoading) {
                          return SpinKitFadingCircle(
                            color: Colors.grey,
                            size: 50.0,
                          );
                        } else if (state is UploadImageDone) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              Text('${state.doneMessage}'),
                            ],
                          );
                        } else if (state is UploadImageError) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              Text('${state.errorMessage}'),
                            ],
                          );
                        }
                        return Text('');
                      },
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 50, right: 50),
                        child: Text(
                          'Get token',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    notificationAlert,
                  ),
                  Text(
                    messageTitle,
                    style: Theme.of(context).textTheme.headline4,
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
