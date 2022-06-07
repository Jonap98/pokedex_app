// ignore_for_file: prefer_const_constructors

import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/src/bloc/auth_bloc.dart';
import 'package:pokedex_app/src/bloc/pokemon_bloc.dart';
import 'package:pokedex_app/src/helpers/color_types.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';
import 'package:pokedex_app/src/ui/widgets/my_appbar.dart';
import 'package:pokedex_app/src/ui/widgets/pokemon_card.dart';
import 'package:pokedex_app/src/ui/widgets/selectable_item_widget.dart';

class PokemonsScreen extends StatelessWidget {
  final gridController = DragSelectGridViewController();

  final pokemonsBloc = PokemonsBloc();

  PokemonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isSelected = gridController.value.isSelecting;
    final text = (isSelected)
        ? '${gridController.value.amount} pokemons seleccionados'
        : 'No pokemon selected';

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          gridController.value = Selection({1});
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
                  child: MyAppbar(controller: gridController),
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
                    child: StreamBuilder(
                      stream: pokemonsBloc.getPokemnos,
                      // builder: (_, AsyncSnapshot snapshot) {
                      builder: (_, AsyncSnapshot<List<Result>> snapshot) {
                        final pokemons = snapshot.data ?? [];

                        //GirdView
                        return DragSelectGridView(
                          // return GridView.builder(
                          // scrollDirection: Axis.vertical,
                          gridController: gridController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.5, crossAxisCount: 2),
                          itemCount: pokemons.length,
                          itemBuilder: (_, index, isSelected) =>
                              SelectableItemWidget(
                            isSelected: isSelected,
                            size: size,
                            pokemons: pokemons,
                            index: index,
                          ),
                          // itemBuilder: (_, index) {
                          //   return PokemonCard(
                          //     size: size,
                          //     pokemons: pokemons,
                          //     index: index,
                          //   );
                          // },
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

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
    required this.isSelecting,
  }) : super(key: key);

  final bool isSelecting;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SeleccionProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (provider.isSelecting)
            ? IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () {
                  provider.seleccion(false);
                  provider.clearList();
                },
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  AuthBloc().logout(context);
                },
              ),
        (provider.isSelecting)
            ? Text('Seleccionando: ${provider.selectionList.length} pokemons')
            : Text(''),
        (provider.isSelecting)
            ? IconButton(
                icon: const Icon(Icons.done),
                onPressed: () {
                  provider.selectTeam(context, provider.selectionList);

                  provider.seleccion(false);
                },
              )
            : IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Navigator.pushNamed(context, 'team_screen');
                },
              ),
      ],
    );
  }
}
