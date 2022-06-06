// To parse this JSON data, do
//
//     final pokemonModel = pokemonModelFromMap(jsonString);

import 'dart:convert';

import 'package:pokedex_app/src/models/pokemon_info_model.dart';

PokemonModel pokemonModelFromMap(String str) =>
    PokemonModel.fromMap(json.decode(str));

String pokemonModelToMap(PokemonModel data) => json.encode(data.toMap());

class PokemonModel {
  PokemonModel({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  int count;
  String next;
  dynamic? previous;
  List<Result> results;

  factory PokemonModel.fromMap(Map<String, dynamic> json) => PokemonModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    required this.name,
    required this.url,
    this.image,
    this.fullImage,
    this.type,
  });

  String name;
  String url;
  String? image;
  String? fullImage;
  List<Type>? type;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
        image: json["image"],
        fullImage: json["fullImage"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
        "image": image,
        "fullImage": fullImage,
        "type": type,
      };
}
