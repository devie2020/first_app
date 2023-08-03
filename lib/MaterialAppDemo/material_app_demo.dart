import 'package:flutter/material.dart';

class MaterialAppDemo extends StatefulWidget {
  const MaterialAppDemo({super.key});

  @override
  State<MaterialAppDemo> createState() => _MaterialAppDemoState();
}

class _MaterialAppDemoState extends State<MaterialAppDemo> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      scaffoldMessengerKey: _scaffoldMessageKey,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          onPressed: () {
            // _navigatorKey
            // showDialog(context: context, builder: (_) => const AlertDialog(title: Text('hello....')));
            // no context
            // showDialog(context: _navigatorKey.currentState!.overlay!.context, builder: (_) => const AlertDialog(title: Text('hello....')));

            // scaffoldMessageKey
            _scaffoldMessageKey.currentState!.showSnackBar(
              const SnackBar(
                content: Text('snack bar'),
                duration: Duration(milliseconds: 2000),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        appBar: AppBar(title: const Text('Material App')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/A');
                },
                child: const Text('A组件'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/B');
                },
                child: const Text('B组件'),
              ),
            ]),
          ),
        ),
      ),
      routes: {'/A': (_) => const A(), '/B': (_) => const B()},
      // initialRoute: '/A',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

class A extends StatefulWidget {
  const A({super.key});

  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A组件')),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/B');
          },
          child: const Text('跳转到B组件'),
        ),
      ),
    );
  }
}

class B extends StatefulWidget {
  const B({super.key});

  @override
  State<B> createState() => _BState();
}

class _BState extends State<B> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('B组件')),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/A');
          },
          child: const Text('跳转到A'),
        ),
      ),
    );
  }
}
