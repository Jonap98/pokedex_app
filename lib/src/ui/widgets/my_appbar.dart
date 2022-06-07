import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/src/bloc/auth_bloc.dart';
import 'package:pokedex_app/src/bloc/pokemon_bloc.dart';

class MyAppbar extends StatefulWidget {
  final DragSelectGridViewController controller;
  MyAppbar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyAppbar> createState() => _MyAppbarState();
}

class _MyAppbarState extends State<MyAppbar> {
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

              final selectedPokemons =
                  widget.controller.value.selectedIndexes.toList().map((index) {
                indexesList.add(index + 1);
              }).toList();

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
