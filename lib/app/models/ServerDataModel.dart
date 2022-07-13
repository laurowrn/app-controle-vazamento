import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ServerDataModel {
  final ref = FirebaseDatabase.instance.ref("");

  Future<List> getSensorData(String sensor, String variable) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    var snapshot = (await ref.child("/sensores/$sensor/$variable").get()).value as Map;
    List list = [];
    snapshot.forEach((key, value) {
      int tempo = value["timestamp"];
      dynamic data = value["value"];
      double data2 = data + 0.0;
      Map<String, dynamic> mapa = {};
      mapa["timestamp"] = tempo;
      mapa["value"] = data2;
      list.add(mapa);
    });
    list.sort((a, b) => a["timestamp"].compareTo(b["timestamp"]));
    return list;
  }

  Future<bool> getValveState(String valve) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    bool state = (await ref.child("/$valve").get()).value as bool;
    return state;
  }

  setValveState(String valve, bool currentState) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await ref.child("/$valve").set(currentState ? false : true);
  }

  Future<Map> getSettings() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    Map settings = (await ref.child("/settings").get()).value as Map;
    return settings;
  }

  setSettings(Map newSettings) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await ref.child("/settings").set(newSettings);
  }
}
