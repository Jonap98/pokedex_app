import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc {
  register(BuildContext context, String user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user', user);

    Navigator.pushReplacementNamed(context, 'pokemons_screen');
  }

  logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    Navigator.pushReplacementNamed(context, 'login_screen');
  }

  Stream<String> getSettings() async* {
    final prefs = await SharedPreferences.getInstance();

    final user = prefs.getString('user');

    yield user!;
  }
}
