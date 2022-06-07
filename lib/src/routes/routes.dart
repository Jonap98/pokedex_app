import 'package:flutter/material.dart';
import 'package:pokedex_app/src/ui/screens/login_screen.dart';
import 'package:pokedex_app/src/ui/screens/pokemon_details_screen.dart';
import 'package:pokedex_app/src/ui/screens/pokemons_screen.dart';
import 'package:pokedex_app/src/ui/screens/pokemons_screen_provider.dart';
import 'package:pokedex_app/src/ui/screens/team_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'login_screen': (BuildContext context) => LoginScreen(),
    'pokemons_screen': (BuildContext context) => PokemonsScreen(),
    'pokemons_screen_provider': (BuildContext context) =>
        PokemonsScreenProvider(),
    'pokemon_details_screen': (BuildContext context) => PokemonDetailsScreen(),
    'team_screen': (BuildContext context) => TeamScreen(),
  };
}
