import 'package:pokedex_app/src/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  register(String user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user', user);

    NavigationService.replaceTo('pokemons_screen');
  }
}
