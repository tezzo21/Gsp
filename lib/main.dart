import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsp/Controller/controll__bind.dart';
import 'package:gsp/UI/home.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Controller_binding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home_screen(),
    );
  }
}

