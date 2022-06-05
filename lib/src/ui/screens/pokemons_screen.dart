// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pokedex_app/src/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/helpers/color_types.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';

class PokemonsScreen extends StatelessWidget {
  final pokemonsBloc = PokemonsBloc();

  PokemonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: pokemonsBloc.pokemonsContadorStream,
                    builder: (context, AsyncSnapshot<int> snapshot) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          'Pokedex',
                          // 'Pokedex, mostrando: ${snapshot.data ?? 0}',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                          ),
                        ),
                      );
                    }),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: StreamBuilder(
                      stream: pokemonsBloc.getPokemnos,
                      builder: (_, AsyncSnapshot<List<Result>> snapshot) {
                        final pokemons = snapshot.data ?? [];

                        //GirdView
                        return GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.5, crossAxisCount: 2),
                          itemCount: pokemons.length,
                          itemBuilder: (_, index) {
                            return Container(
                                margin: EdgeInsets.all(5),
                                width: size.width * 0.4,
                                padding: EdgeInsets.all(10),
                                height: size.width * 0.3,
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pokemons[index].name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            pokemons[index]
                                                .type!
                                                .first
                                                .type!
                                                .name!,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
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
                                            image: AssetImage(
                                                'assets/pokeball_icon.png'),
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
                                  color: ColorTypes.setColor(
                                      pokemons[index].type!.first.type!.name!),
                                ));
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
