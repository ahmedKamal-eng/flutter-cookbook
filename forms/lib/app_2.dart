import 'package:flutter/material.dart';

class App2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('form styling demo'),
        ),
        body: MyForm2(),
      ),
    );
  }
}

class MyForm2 extends StatefulWidget {
  @override
  _MyForm2State createState() => _MyForm2State();
}

class _MyForm2State extends State<MyForm2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'search',
              border: const OutlineInputBorder(),
            ),
          )
        ],
      ),
    );
  }
}
