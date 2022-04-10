import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: CounterStorage()),
    ),
  );
}

class CounterStorage {
  Future<void> setIntInCache({String? key, int? val}) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt(key!, val!);
  }

  Future<int?> getIntFromCache({String? key}) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(key!) ?? 0;
  }
}

// Future<File> writeCounter(int counter) async {
//   final file = await _localFile;
//
//   // Write the file
//   return file.writeAsString('$counter');
// }
// }

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({Key? key, required this.storage}) : super(key: key);

  final CounterStorage storage;

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.getIntFromCache(key: 'counter').then((value) {
      setState(() {
        _counter = value!;
      });
    });
  }

  Future<void> _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Write the variable as a string to the file.
    return widget.storage.setIntInCache(key: 'counter', val: _counter);
  }

  Future<void> _decrementCounter() {
    setState(() {
      _counter--;
    });

    // Write the variable as a string to the file.
    return widget.storage.setIntInCache(key: 'counter', val: _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Text(
          'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      persistentFooterButtons: [
        FloatingActionButton(
          onPressed: _decrementCounter,
          tooltip: 'decrement',
          child: Icon(Icons.remove),
        ),
        SizedBox(
          width: 210,
        ),
        FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
