// To parse this JSON data, do
//
//     final pokemonInfoModel = pokemonInfoModelFromMap(jsonString);

import 'dart:convert';

PokemonInfoModel pokemonInfoModelFromMap(String str) =>
    PokemonInfoModel.fromMap(json.decode(str));

String pokemonInfoModelToMap(PokemonInfoModel data) =>
    json.encode(data.toMap());

class PokemonInfoModel {
  PokemonInfoModel({
    this.formName,
    this.formNames,
    this.formOrder,
    this.id,
    this.isBattleOnly,
    this.isDefault,
    this.isMega,
    this.name,
    this.names,
    this.order,
    this.pokemon,
    this.sprites,
    this.types,
    this.versionGroup,
  });

  String? formName;
  List<dynamic>? formNames;
  int? formOrder;
  int? id;
  bool? isBattleOnly;
  bool? isDefault;
  bool? isMega;
  String? name;
  List<dynamic>? names;
  int? order;
  Pokemon? pokemon;
  Sprites? sprites;
  List<Type>? types;
  Pokemon? versionGroup;

  factory PokemonInfoModel.fromMap(Map<String, dynamic> json) =>
      PokemonInfoModel(
        formName: json["form_name"],
        formNames: List<dynamic>.from(json["form_names"].map((x) => x)),
        formOrder: json["form_order"],
        id: json["id"],
        isBattleOnly: json["is_battle_only"],
        isDefault: json["is_default"],
        isMega: json["is_mega"],
        name: json["name"],
        names: List<dynamic>.from(json["names"].map((x) => x)),
        order: json["order"],
        pokemon: Pokemon.fromMap(json["pokemon"]),
        sprites: Sprites.fromMap(json["sprites"]),
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        versionGroup: Pokemon.fromMap(json["version_group"]),
      );

  Map<String, dynamic> toMap() => {
        "form_name": formName,
        "form_names": List<dynamic>.from(formNames!.map((x) => x)),
        "form_order": formOrder,
        "id": id,
        "is_battle_only": isBattleOnly,
        "is_default": isDefault,
        "is_mega": isMega,
        "name": name,
        "names": List<dynamic>.from(names!.map((x) => x)),
        "order": order,
        "pokemon": pokemon!.toMap(),
        "sprites": sprites!.toMap(),
        "types": List<dynamic>.from(types!.map((x) => x.toMap())),
        "version_group": versionGroup!.toMap(),
      };
}

class Pokemon {
  Pokemon({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Pokemon.fromMap(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class Sprites {
  Sprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  String? backDefault;
  dynamic? backFemale;
  String? backShiny;
  dynamic? backShinyFemale;
  String? frontDefault;
  dynamic? frontFemale;
  String? frontShiny;
  dynamic? frontShinyFemale;

  factory Sprites.fromMap(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"],
        backFemale: json["back_female"],
        backShiny: json["back_shiny"],
        backShinyFemale: json["back_shiny_female"],
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
      );

  Map<String, dynamic> toMap() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
      };
}

class Type {
  Type({
    this.slot,
    this.type,
  });

  int? slot;
  Pokemon? type;

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Pokemon.fromMap(json["type"]),
      );

  Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type!.toMap(),
      };
}
