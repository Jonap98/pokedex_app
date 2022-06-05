import 'package:flutter/material.dart';
import 'package:pokedex_app/src/ui/screens/login_screen.dart';
import 'package:pokedex_app/src/ui/screens/pokemons_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login_screen': (BuildContext context) => const LoginScreen(),
    'pokemons_screen': (BuildContext context) => PokemonsScreen(),
  };
}
