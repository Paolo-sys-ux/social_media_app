import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:social_media_app/constants/style.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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

  void getMessages() async {
    final messages = await firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  @override
  Widget build(BuildContext context) {
    var send;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Messages',
          style: kTextButton.copyWith(color: Colors.white),
        ),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: ListTile(
          trailing: IconButton(
              key: send,
              tooltip: 'Send',
              icon: Icon(
                Icons.send_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                if (_sendKey.currentState.validate()) {
                  firestore.collection('messages').add({'text': text});
                  dispose();
                  getMessages();
                }
              }),
          title: Form(
            key: _sendKey,
            child: TextFormField(
              controller: textCont,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Type your message here...';
                }
                return null;
              },
              onChanged: (value) {
                text = value;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.messenger_rounded),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                labelText: 'Message',
                hintText: 'Kamusta ka?',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
