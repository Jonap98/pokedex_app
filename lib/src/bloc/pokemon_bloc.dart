import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pokedex_app/src/api/cafe_api.dart';
import 'package:pokedex_app/src/models/pokemon_info_model.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';

// const POKEMONS = ['Charmander', 'Bulbazur', 'Squirtle'];

class PokemonsBloc {
  Stream<String> getType(int pokemonId) async* {
    PokemonInfoModel pokemonInfoModel = PokemonInfoModel();

    Dio _dio = Dio();
    final resp =
        await _dio.get('https://pokeapi.co/api/v2/pokemon-form/$pokemonId');

    pokemonInfoModel = PokemonInfoModel.fromMap(resp.data);

    yield pokemonInfoModel.types![0].type!.name!;
  }

  Stream<List<Result>> get getPokemnos async* {
    // final List<String> pokemons = [];
    List<Result> pokemonsList = [];
    PokemonModel pokemonModel = PokemonModel(
      count: 0,
      next: '',
      previous: '',
      results: [],
    );

    // final resp = await CafeApi.httpGet('/?limit=5');
    Dio _dio = Dio();
    final resp = await _dio.get('https://pokeapi.co/api/v2/pokemon/?limit=150');

    pokemonModel = PokemonModel.fromMap(resp.data);

    for (int index = 0; index < pokemonModel.results.length; index++) {
      final tipo =
          await _dio.get('https://pokeapi.co/api/v2/pokemon-form/${index + 1}');
      PokemonInfoModel info = PokemonInfoModel();

      info = PokemonInfoModel.fromMap(tipo.data);

      // print(info.types![0].type!.name!);

      yield pokemonsList;
      // final type = getType(index + 1);
      // print(type.first.toString());
      // print('Pokemon #$index: ${pokemonModel.results[index].name}');
      pokemonsList.add(
        Result(
            name: pokemonModel.results[index].name,
            url: pokemonModel.results[index].url,
            image:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
            type: info.types!),
      );
    }

    // for (Result element in pokemonModel.results) {
    //   // print(element);
    //   pokemonsList.add(element);
    //   yield pokemonsList;
    // }

    // for (String pokemon in POKEMONS) {
    //   pokemons.add(pokemon);

    //   yield pokemons;
    // }
  }

  final StreamController<int> _pokemonsContador = StreamController<int>();
  Stream<int> get pokemonsContadorStream => _pokemonsContador.stream;

  // Constructor
  PokemonsBloc() {
    // Cuando getPokemons emite, el listenr escucha ese nuevo listado y lo
    // añade al stream
    getPokemnos.listen((pokemonsList) {
      _pokemonsContador.add(pokemonsList.length);
    });
  }

  dispose() {
    _pokemonsContador.close();
  }
}
