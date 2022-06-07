import 'package:flutter/material.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';
import 'package:pokedex_app/src/ui/widgets/pokemon_card.dart';

class SelectableItemWidget extends StatelessWidget {
  final bool isSelected;
  final Size size;
  final List<Result> pokemons;
  final int index;

  const SelectableItemWidget({
    Key? key,
    required this.isSelected,
    required this.size,
    required this.pokemons,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PokemonCard(
      isSelected: isSelected,
      size: size,
      pokemons: pokemons,
      index: index,
    );
  }
}
