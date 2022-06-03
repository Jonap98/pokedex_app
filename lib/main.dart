import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pokedex App'),
        ),
        body: Center(
          child: Container(
            child: Text('Pokedex'),
          ),
        ),
      ),
    );
  }
}