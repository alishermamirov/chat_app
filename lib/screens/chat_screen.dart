import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widgets/messages.dart';
import '../widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    requestNotificationPermission();
    super.initState();
  }

  void requestNotificationPermission() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    fcm.subscribeToTopic('flutterchat');

    // print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');

      // if (message.notification != null) {
      // print('Message also contained a notification: ${message.notification}');
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // print('Got a message whilst in the background!');
      // print('Message data: ${message.data}');
      // if (message.notification != null) {
      // print('Message also contained a notification: ${message.notification}');
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: const Icon(
              Icons.more_vert,
            ),
            items: const [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('Chiqish'),
                  ],
                ),
              )
            ],
            onChanged: (selectedItem) {
              if (selectedItem == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          NewMessages()
        ],
      ),
    );
  }
}
