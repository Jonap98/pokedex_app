import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/src/api/cafe_api.dart';
import 'package:pokedex_app/src/helpers/pokemon_numbers.dart';
import 'package:pokedex_app/src/models/pokemon_info_model.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';

class PokemonProvider extends ChangeNotifier {
  late List<Result> pokemonsList = [];

  Future<List<Result>> getPokemons() async {
    // final resp = await CafeApi.httpGet('/limit=10');
    Dio _dio = Dio();
    final resp = await _dio.get('https://pokeapi.co/api/v2/pokemon/?limit150');

    final pokemonResp = PokemonModel.fromMap(resp.data);

    for (int index = 0; index < pokemonResp.results.length; index++) {
      final tipo =
          await _dio.get('https://pokeapi.co/api/v2/pokemon-form/${index + 1}');
      PokemonInfoModel info = PokemonInfoModel();

      info = PokemonInfoModel.fromMap(tipo.data);
      String number = PokemonNumbers.setThreeNumbers(index + 1);

      pokemonsList.add(Result(
        name: pokemonResp.results[index].name,
        url: pokemonResp.results[index].url,
        image:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
        fullImage:
            'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$number.png',
        type: info.types!,
      ));
    }

    notifyListeners();

    return pokemonsList;
  }
}
