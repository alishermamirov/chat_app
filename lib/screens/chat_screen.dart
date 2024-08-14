import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const routeName = "/chat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text("salom"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/BEspLY2dNQKYILNtwwX9/messages")
              .snapshots()
              .listen((data) {
            print(data.docs);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
