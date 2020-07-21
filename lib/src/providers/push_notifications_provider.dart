import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

String firebaseToken;

class PushNotificatinProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      firebaseToken = token;

      print("==== FCM token ====");
      print(firebaseToken);

      //dBEx7pHR6JI:APA91bE7rlvTC6QAH5eFON-eMB84oxVISEEk5q6LQBepIqf3EWUVpHKvJb4ATTWaxnf0OR_PpWpZQJn1-vT0jaPIwm-5QSH6C4EfvsmNtzzA3ZCn76w1KcqY6aTk-CGf0N3EuSE23j8V
    });

    _firebaseMessaging.configure(onMessage: (info) async {
      print("===== On Message =====");
      print(info);

      String argumento = 'no-data';

      if (Platform.isAndroid) {
        argumento = info['data']['comida'] ?? 'no-data';
      }

      _mensajesStreamController.sink.add(argumento);
    }, onLaunch: (info) async {
      print("===== On Launch =====");
      print(info);
    }, onResume: (info) async {
      print("===== On Resume =====");
      print(info);

      final noti = info['data']['comida'];

      //print(noti);
      _mensajesStreamController.sink.add(noti);
    });
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
