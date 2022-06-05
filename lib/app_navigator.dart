import 'package:flutter/material.dart';
import 'package:pokedex_app/src/services/local_storage.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AppNavigator {
  AuthStatus authStatus = AuthStatus.checking;

  AppNavigator() {
    isAuthenticated();
  }

  Stream<bool> isAuthenticated() async* {
    final user = LocalStorage.prefs.getString('user');

    if (user == null) {
      authStatus == AuthStatus.notAuthenticated;

      yield false;
    }
    authStatus == AuthStatus.authenticated;

    yield true;
  }
}
