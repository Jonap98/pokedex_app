import 'package:flutter/material.dart';
import 'package:pokedex_app/src/routes/routes.dart';
import 'package:pokedex_app/src/services/local_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage.configurePrefs();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      initialRoute: 'login_screen',
      routes: getApplicationRoutes(),
    );
  }
}
