import 'dart:convert';

import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ServerDataModel {
  final ref = FirebaseDatabase.instance.ref("");

  Future<List> getSensorData(String sensor, String data) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    Map snapshot = (await ref.child("/sensores/$sensor/$data").get()).value as Map;
    var values = snapshot.entries.map((e) => e.value).toList();
    return values;
  }

  Future<bool> getValveState(String valve) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    bool state = (await ref.child("/$valve").get()).value as bool;
    return state;
  }
}
