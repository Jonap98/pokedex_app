// ignore_for_file: prefer_const_constructors

import 'package:drag_select_grid_view/drag_select_grid_view.dart';
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
  final gridController = DragSelectGridViewController();

  final pokemonsBloc = PokemonsBloc();

  PokemonsScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonsList = Provider.of<PokemonProvider>(context).getPokemons();
    //  Provider.of<PokemonProvider>(context, listen:false).pokemonsList;

    final size = MediaQuery.of(context).size;
    bool isSelected = gridController.value.isSelecting;
    final text = (isSelected)
        ? '${gridController.value.amount} pokemons seleccionados'
        : 'No pokemon selected';

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gridController.value = Selection({0});
        },
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
                  child: DynamicAppBar(controller: gridController),
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

class DynamicAppBar extends StatefulWidget {
  final DragSelectGridViewController controller;
  DynamicAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DynamicAppBar> createState() => _DynamicAppBarState();
}

class _DynamicAppBarState extends State<DynamicAppBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(rebuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(rebuild);
    super.dispose();
  }

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final pokemonsBloc = PokemonsBloc();

    final isSelected = widget.controller.value.isSelecting;
    final text = (isSelected)
        ? '${widget.controller.value.amount} pokemons seleccionados'
        : '';
    final leadingButton = (isSelected)
        ? IconButton(
            icon: const Icon(Icons.cancel_outlined),
            onPressed: () {
              widget.controller.clear();
            },
          )
        : IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              AuthBloc().logout(context);
            },
          );
    final actionsButton = (isSelected)
        ? IconButton(
            icon: const Icon(Icons.done),
            onPressed: () async {
              final List<int> indexesList = [];
              print(widget.controller.value.selectedIndexes);
              final selectedPokemons =
                  widget.controller.value.selectedIndexes.toList().map((index) {
                indexesList.add(index + 1);
                print('Correct index:${index + 1}');
              }).toList();
              print(indexesList);
              await pokemonsBloc.selectTeam(context, indexesList);
              widget.controller.clear();
              // Navigator.pushNamed(context, 'team_screen');
            },
          )
        : IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.pushNamed(context, 'team_screen');
            },
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leadingButton,
        Text(text),
        actionsButton,
      ],
    );
  }
}
