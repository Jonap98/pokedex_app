import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pokedex_app/src/api/cafe_api.dart';
import 'package:pokedex_app/src/helpers/pokemon_numbers.dart';
import 'package:pokedex_app/src/models/pokemon_info_model.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';

class PokemonsBloc {
  Stream<String> getType(int pokemonId) async* {
    PokemonInfoModel pokemonInfoModel = PokemonInfoModel();

    Dio _dio = Dio();
    final resp =
        await _dio.get('https://pokeapi.co/api/v2/pokemon-form/$pokemonId');

    pokemonInfoModel = PokemonInfoModel.fromMap(resp.data);

    yield pokemonInfoModel.types![0].type!.name!;
  }

  final Result _selectedPokemon =
      Result(name: '', url: '', image: '', fullImage: '', type: []);

  selectPokemon(Result pokemon) async* {
    // Result selectedPokemon =
    //     Result(name: '', url: '', image: '', fullImage: '', type: []);

    _selectedPokemon.name = pokemon.name;
    _selectedPokemon.url = pokemon.url;
    _selectedPokemon.image = pokemon.image;
    _selectedPokemon.fullImage = pokemon.fullImage;
    _selectedPokemon.type = pokemon.type;

    yield _selectedPokemon;
  }

  Stream<Result> get getSelectedPokemon async* {
    yield _selectedPokemon;
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
    final resp = await _dio.get('https://pokeapi.co/api/v2/pokemon/?limit=150');

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

  final StreamController<int> _pokemonsContador = StreamController<int>();
  Stream<int> get pokemonsContadorStream => _pokemonsContador.stream;

  StreamController<Result> _poke = StreamController<Result>();
  Stream<Result> get selectedPokemonStream => _poke.stream;

  // Constructor
  PokemonsBloc() {
    // Cuando getPokemons emite, el listenr escucha ese nuevo listado y lo
    // añade al stream
    getPokemnos.listen((pokemonsList) {
      _pokemonsContador.add(pokemonsList.length);
    });

    getSelectedPokemon.listen((_selectedPokemon) {
      _poke.add(_selectedPokemon);
    });
  }

  dispose() {
    _pokemonsContador.close();
    _poke.close();
  }
}
