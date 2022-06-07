import 'package:flutter/material.dart';
import 'package:pokedex_app/src/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/helpers/color_types.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';
import 'package:pokedex_app/src/providers/seleccion_provider.dart';
import 'package:pokedex_app/src/ui/widgets/type_tag.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatelessWidget {
  PokemonCard({
    Key? key,
    required this.size,
    required this.pokemons,
    required this.index,
  }) : super(key: key);

  final Size size;
  final List<Result> pokemons;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isSelecting = Provider.of<SeleccionProvider>(context).isSelecting;
    List<String> selectionList =
        Provider.of<SeleccionProvider>(context).selectionList;

    return GestureDetector(
      onTap: (isSelecting)
          ? () {
              final selectionList =
                  Provider.of<SeleccionProvider>(context, listen: false)
                      .getSelection;

              if (!selectionList.contains(pokemons[index].name)) {
                Provider.of<SeleccionProvider>(context, listen: false)
                    .selectPokemon(pokemons[index].name);
              } else {
                Provider.of<SeleccionProvider>(context, listen: false)
                    .removePokemon(pokemons[index].name);
              }
            }
          : () async {
              await PokemonsBloc().getPokemon(context, pokemons[index].name);
            },
      child: Container(
        margin: const EdgeInsets.all(5),
        width: size.width * 0.4,
        padding: const EdgeInsets.all(10),
        height: size.width * 0.3,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemons[index].name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TypeTag(
                  text: pokemons[index].type!.first.type!.name!,
                  index: index,
                ),
              ],
            ),
            Positioned(
              right: -10.0,
              bottom: -10.0,
              child: Stack(
                children: [
                  Image(
                    width: size.width * 0.2,
                    color: Colors.blue.withOpacity(0.3),
                    colorBlendMode: BlendMode.modulate,
                    image: const AssetImage('assets/pokeball_icon.png'),
                  ),
                  Image.network(
                    pokemons[index].image!,
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: (isSelecting)
              ? (selectionList.contains(pokemons[index].name))
                  ? ColorTypes.setColor(pokemons[index].type!.first.type!.name!)
                  : Colors.black12
              : ColorTypes.setColor(pokemons[index].type!.first.type!.name!),
        ),
      ),
    );
  }
}
