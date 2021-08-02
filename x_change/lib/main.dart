import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:x_change/Login.dart';
import 'package:x_change/RouterGenerator.dart';
import 'views/Anuncios.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    home: Login(),
    title: "xChange",
    theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.deepOrange
    ),
    initialRoute: "/",
    onGenerateRoute: RouterGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}