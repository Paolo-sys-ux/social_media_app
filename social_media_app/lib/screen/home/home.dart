import 'dart:io';

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
  File _image;
  final picker = ImagePicker();

  // Future uploadImageToFirebase(BuildContext context) async {
  //   String fileName = basename.basename(_image.path);
  //   Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('uploads/$fileName');
  //   UploadTask uploadTask = firebaseStorageRef.putFile(_image);
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //       );
  // }

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            _image == null ? Text('No image selected.') : Image.file(_image),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                selectImage(context);
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 50, right: 50),
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
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
                      } else if (state is UploadImageError) {
                        return Text('Error uploading');
                      }
                      return Text('');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
