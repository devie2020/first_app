import 'package:flutter/material.dart';

class ScaffoldDemo extends StatefulWidget {
  const ScaffoldDemo({super.key});

  @override
  State<ScaffoldDemo> createState() => _ScaffoldDemoState();
}

class _ScaffoldDemoState extends State<ScaffoldDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scaffold'),
      ),
      body: const Center(
        child: Text('内容区域'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('....');
        },
        child: const Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
    );
  }
}
