import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/src/api/cafe_api.dart';
import 'package:pokedex_app/src/helpers/pokemon_numbers.dart';
import 'package:pokedex_app/src/models/pokemon_info_model.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonsBloc {
  Stream<String> getType(int pokemonId) async* {
    PokemonInfoModel pokemonInfoModel = PokemonInfoModel();

    Dio _dio = Dio();
    final resp =
        await _dio.get('https://pokeapi.co/api/v2/pokemon-form/$pokemonId');

    pokemonInfoModel = PokemonInfoModel.fromMap(resp.data);

    yield pokemonInfoModel.types![0].type!.name!;
  }

  selectTeam(BuildContext context, List<int> pokemonIndexes) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('one', pokemonIndexes[0]);
    await prefs.setInt('two', pokemonIndexes[1]);
    await prefs.setInt('three', pokemonIndexes[2]);
    await prefs.setInt('four', pokemonIndexes[3]);
    await prefs.setInt('five', pokemonIndexes[4]);
    await prefs.setInt('six', pokemonIndexes[5]);

    Navigator.pushNamed(context, 'team_screen');
  }

  List<int> _team = [];
  getSharedTeam() async {
    final prefs = await SharedPreferences.getInstance();

    final List<int> teamList = [];

    teamList.add(prefs.getInt('one')!);
    teamList.add(prefs.getInt('two')!);
    teamList.add(prefs.getInt('three')!);
    teamList.add(prefs.getInt('four')!);
    teamList.add(prefs.getInt('five')!);
    teamList.add(prefs.getInt('six')!);

    _team = teamList;
  }

  static PokemonInfoModel poke = PokemonInfoModel();
  getPokemon(BuildContext context, String pokemonName) async {
    Dio _dio = Dio();

    final pokemon =
        await _dio.get('https://pokeapi.co/api/v2/pokemon-form/$pokemonName');
    poke = PokemonInfoModel.fromMap(pokemon.data);
    Navigator.pushNamed(context, 'pokemon_details_screen');
  }

  Result selected =
      Result(name: '', url: '', image: '', fullImage: '', type: []);
  Stream<Result> get getPoke async* {
    final temp = poke;

    String number = PokemonNumbers.setThreeNumbers(poke.id!);

    selected = Result(
        name: poke.name!,
        url: poke.pokemon!.url!,
        image:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${poke.id}.png',
        fullImage:
            'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$number.png',
        type: poke.types);

    yield selected;
  }

  Stream<List<Result>> get getTeam async* {
    await getSharedTeam();

    List<Result> pokemonsList = [];

    Dio _dio = Dio();

    for (int index = 0; index < _team.length; index++) {
      final tipo = await _dio
          .get('https://pokeapi.co/api/v2/pokemon-form/${_team[index]}');
      PokemonInfoModel poke = PokemonInfoModel.fromMap(tipo.data);

      yield pokemonsList;

      String number = PokemonNumbers.setThreeNumbers(_team[index]);

      pokemonsList.add(
        Result(
            name: poke.pokemon!.name!,
            url: poke.pokemon!.url!,
            image:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${_team[index]}.png',
            fullImage:
                'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$number.png',
            type: poke.types),
      );
    }
  }

  Stream<List<Result>> get get150 async* {
    List<Result> pokemonsList = [];
    PokemonModel pokemonModel = PokemonModel(
      count: 0,
      next: '',
      previous: '',
      results: [],
    );

    Dio _dio = Dio();

    for (int index = 0; index < 150; index++) {
      final tipo =
          await _dio.get('https://pokeapi.co/api/v2/pokemon-form/${index + 1}');
      PokemonInfoModel info = PokemonInfoModel();

      info = PokemonInfoModel.fromMap(tipo.data);

      String number = PokemonNumbers.setThreeNumbers(index + 1);

      pokemonsList.add(
        Result(
            name: info.name!,
            url: info.pokemon!.url!,
            image:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
            fullImage:
                'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$number.png',
            type: info.types!),
      );
    }
    // _dio.delete('https://pokeapi.co/api/v2/pokemon-form');
    _dio.close();
    yield pokemonsList;
  }

  static PokemonInfoModel poke = PokemonInfoModel();
  getPokemon(BuildContext context, String pokemonName) async {
    Dio _dio = Dio();

    final pokemon =
        await _dio.get('https://pokeapi.co/api/v2/pokemon-form/$pokemonName');
    poke = PokemonInfoModel.fromMap(pokemon.data);
    Navigator.pushNamed(context, 'pokemon_details_screen');
  }

  Result selected =
      Result(name: '', url: '', image: '', fullImage: '', type: []);
  Stream<Result> get getPoke async* {
    String number = PokemonNumbers.setThreeNumbers(poke.id!);

    selected = Result(
        name: poke.name!,
        url: poke.pokemon!.url!,
        image:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${poke.id}.png',
        fullImage:
            'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$number.png',
        type: poke.types);

    yield selected;
  }

  Stream<List<Result>> get getPokemnos async* {
    List<Result> pokemonsList = [];
    PokemonModel pokemonModel = PokemonModel(
      count: 0,
      next: '',
      previous: '',
      results: [],
    );

    Dio _dio = Dio();
    final resp = await _dio.get('https://pokeapi.co/api/v2/pokemon/?limit=15');

    pokemonModel = PokemonModel.fromMap(resp.data);

    for (int index = 0; index < pokemonModel.results.length; index++) {
      final tipo =
          await _dio.get('https://pokeapi.co/api/v2/pokemon-form/${index + 1}');
      PokemonInfoModel info = PokemonInfoModel();

      info = PokemonInfoModel.fromMap(tipo.data);

      yield pokemonsList;

      String number = PokemonNumbers.setThreeNumbers(index + 1);

      pokemonsList.add(
        Result(
            name: pokemonModel.results[index].name,
            url: pokemonModel.results[index].url,
            image:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
            fullImage:
                'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$number.png',
            type: info.types!),
      );
    }
  }

  final StreamController<List<Result>> _pokemonsContador =
      StreamController<List<Result>>();
  Stream<List<Result>> get pokemonsContadorStream => _pokemonsContador.stream;

  // final StreamController<Result> _poke = StreamController<Result>();
  // Stream<Result> get pokeStream => _poke.stream;

  // Constructor
  PokemonsBloc() {
    // Cuando getPokemons emite, el listenr escucha ese nuevo listado y lo
    // añade al stream
    getPokemnos.listen((pokemonsList) {
      _pokemonsContador.add(pokemonsList);
    });

    // getPoke.listen((selected) {
    //   _poke.add(selected);
    // });
  }

  dispose() {
    _pokemonsContador.close();
    // _poke.close();
  }
}
