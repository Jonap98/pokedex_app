// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pokedex_app/src/bloc/auth_bloc.dart';
import 'package:pokedex_app/src/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/helpers/color_types.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';
import 'package:pokedex_app/src/providers/pokemon_provider.dart';
import 'package:pokedex_app/src/ui/widgets/pokemon_card.dart';
import 'package:pokedex_app/src/ui/widgets/selectable_item_widget.dart';
import 'package:provider/provider.dart';

class PokemonsScreenProvider extends StatelessWidget {
  final pokemonsBloc = PokemonsBloc();

  PokemonsScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonsList = Provider.of<PokemonProvider>(context).getPokemons();
    //  Provider.of<PokemonProvider>(context, listen:false).pokemonsList;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: size.width * -0.3,
              top: size.width * -0.2,
              child: Image(
                width: size.width * 0.9,
                color: Colors.blue.withOpacity(0.3),
                colorBlendMode: BlendMode.modulate,
                image: AssetImage('assets/pokeball_icon.png'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    'Pokedex',
                    // 'Pokedex, mostrando: ${snapshot.data ?? 0}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: FutureBuilder(
                      future: pokemonsList,
                      // builder: (_, AsyncSnapshot snapshot) {
                      builder: (_, AsyncSnapshot<List<Result>> snapshot) {
                        final pokemons = snapshot.data ?? [];

                        //GirdView
                        // return DragSelectGridView(
                        return GridView.builder(
                          scrollDirection: Axis.vertical,
                          // gridController: gridController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.5, crossAxisCount: 2),
                          itemCount: pokemons.length,
                          // itemBuilder: (_, index, isSelected) =>
                          //     SelectableItemWidget(
                          //   isSelected: isSelected,
                          //   size: size,
                          //   pokemons: pokemons,
                          //   index: index,
                          // ),
                          itemBuilder: (_, index) {
                            return PokemonCard(
                              size: size,
                              pokemons: pokemons,
                              index: index,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
