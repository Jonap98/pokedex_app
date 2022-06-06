import 'package:flutter/material.dart';
import 'package:pokedex_app/src/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/helpers/color_types.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';
import 'package:pokedex_app/src/ui/widgets/type_tag.dart';

class PokemonCard extends StatelessWidget {
  // final pokemonsBloc = PokemonsBloc();

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
    return GestureDetector(
      onTap: () {
        // await pokemonsBloc.selectPokemon(pokemons[index]);
        // print(pokemons[index].name);
        // print(pokemons[index].image);
        // print(pokemons[index].fullImage);
        // print(pokemons[index].url);
        // print(pokemons[index].type![0].type!.name);
        // Navigator.pushNamed(context, 'pokemon_details_screen');
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
            color: ColorTypes.setColor(pokemons[index].type!.first.type!.name!),
          )),
    );
  }
}
