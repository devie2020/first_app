import 'package:flutter/material.dart';
import 'SnH48/sn_h48_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const SnH48Grid(),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
    );
  }
}
