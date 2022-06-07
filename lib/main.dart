import 'package:flutter/material.dart';
import 'package:pokedex_app/src/providers/seleccion_provider.dart';
import 'package:pokedex_app/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  prefs.getString('user');

  runApp(AppState(prefs: prefs));
}

class AppState extends StatelessWidget {
  const AppState({
    Key? key,
    required this.prefs,
  }) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SeleccionProvider(),
        ),
      ],
      child: MyApp(prefs: prefs),
    );
  }
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      initialRoute: (prefs.getString('user') == null)
          ? 'login_screen'
          : 'pokemons_screen',
      routes: getApplicationRoutes(),
    );
  }
}
