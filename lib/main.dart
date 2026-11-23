import 'package:flutter/material.dart';
import 'package:albay_1_pas_flutter/routes.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: Routes.login,
      getPages: Routes.myPages,
    );
  }
}

