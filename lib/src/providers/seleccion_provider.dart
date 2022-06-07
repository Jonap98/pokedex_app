import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeleccionProvider extends ChangeNotifier {
  bool isSelecting = false;
  Future<bool> seleccion(bool selecting) async {
    isSelecting = selecting;
    notifyListeners();
    return isSelecting;
  }

  get getSelecting async {
    String text = (isSelecting) ? 'Seleccionando' : 'Na';

    return text;
  }

  List<String> selectionList = [];
  selectPokemon(String name) {
    if (selectionList.length > 5) selectionList.removeAt(5);

    selectionList.add(name);
    notifyListeners();
  }

  removePokemon(String name) {
    selectionList.remove(name);
    notifyListeners();
  }

  clearList() {
    selectionList = [];
    notifyListeners();
  }

  List<String> get getSelection {
    return selectionList;
  }

  selectTeam(BuildContext context, List<String> pokemonNames) async {
    if (pokemonNames.length < 5) {
      return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'El equipo debe contener 6 pokemons',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Aceptar'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('one', pokemonNames[0]);
      await prefs.setString('two', pokemonNames[1]);
      await prefs.setString('three', pokemonNames[2]);
      await prefs.setString('four', pokemonNames[3]);
      await prefs.setString('five', pokemonNames[4]);
      await prefs.setString('six', pokemonNames[5]);

      Navigator.pushNamed(context, 'team_screen');
    }
  }
}
