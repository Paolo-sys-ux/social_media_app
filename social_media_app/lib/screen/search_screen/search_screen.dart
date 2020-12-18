import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:social_media_app/bloc/display_post/display_post_bloc.dart';
import 'package:social_media_app/constants/style.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textCont = TextEditingController();
  String text;

  final firestore = FirebaseFirestore.instance;
  final _sendKey = GlobalKey<FormState>();

  final form = FormGroup({
    'text': FormControl(validators: [Validators.required]),
  });

  void dispose() {
    textCont.clear();
  }

  @override
  Widget build(BuildContext context) {
    var uid, url, name;

    var send;
    final orientation = MediaQuery.of(context).orientation;
    BlocProvider.of<DisplayPostBloc>(context).add(DisplayData());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Search',
          style: kTextButton.copyWith(color: Color(0xFF514A43)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ListTile(
                // trailing: IconButton(
                //     key: send,
                //     tooltip: 'Send',
                //     icon: Icon(
                //       Icons.,
                //       color: Colors.black,
                //       size: 30,
                //     ),
                //     onPressed: () {
                //       if (_sendKey.currentState.validate()) {
                //         firestore.collection('messages').add({'text': text});
                //         dispose();
                //         // getMessages();
                //       }
                //     }),
                title: Form(
                  key: _sendKey,
                  child: TextFormField(
                    controller: textCont,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Type anything you want to search';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      text = value;
                    },
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                      hoverColor: Colors.black,
                      prefixIcon: Icon(Icons.search_sharp),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: 'Search',
                      hintText: 'Search...',
                    ),
                  ),
                ),
              ),
            ),
            //POST
            BlocBuilder<DisplayPostBloc, DisplayPostState>(
              builder: (context, state) {
                if (state is DisplayPostLoading) {
                  return Align(
                    alignment: Alignment.center,
                    child: SpinKitFadingCircle(
                      color: Colors.grey,
                      size: 50.0,
                    ),
                  );
                } else if (state is DisplayPostFetch) {
                  return Container(
                    child: SizedBox(
                      height: 700,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 2 : 3),
                        itemCount: state.post == null ? 0 : state.post.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: InkWell(
                              onTap: () {
                                url = (state.post[index]["url"]);
                                name = (state.post[index]["name"]);
                                uid = "${state.post[index].id}";

                                url = "${state.post[index]["url"]}";

                                print(url);
                                print(name);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: FadeInImage(
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage(
                                            'assets/images/default.jpg'),
                                        image: NetworkImageWithRetry(
                                            "${state.post[index]["url"]}"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
