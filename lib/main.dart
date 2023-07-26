import 'package:app/screen/create.dart';
import 'package:app/screen/list.dart';
import 'package:app/screen/map.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  Map<String, WidgetBuilder> routes = {
    '/lista':(context) =>  const Lista(),
    '/create':(context) => const Create(),
    '/map':(context) =>  const Mapa(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP 911',
      routes: routes,
      initialRoute: '/lista',
    );
  }
}
