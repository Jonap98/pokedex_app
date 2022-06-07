import 'package:flutter/material.dart';

class ColorTypes {
  static Color setColor(String type) {
    Color color = const Color(0xffaca592);
    switch (type) {
      case 'bug':
        color = const Color(0xff869409);
        break;
      case 'dark':
        color = const Color(0xff342a23);
        break;
      case 'dragon':
        color = const Color(0xff6e5bcb);
        break;
      case 'electric':
        color = const Color(0xffde981f);
        break;
      case 'fairy':
        color = const Color(0xffdb92d6);
        break;
      case 'fighting':
        color = const Color(0xff482416);
        break;
      case 'fire':
        color = const Color(0xffc71e00);
        break;
      case 'flying':
        color = const Color(0xff5e72d2);
        break;
      case 'ghost':
        color = const Color(0xff474491);
        break;
      case 'grass':
        color = const Color(0xff499322);
        break;
      case 'ground':
        color = const Color(0xffc4a453);
        break;
      case 'ice':
        color = const Color(0xff6cd3f7);
        break;
      case 'normal':
        color = const Color(0xffaca592);
        break;
      case 'poison':
        color = const Color(0xff602863);
        break;
      case 'psychic':
        color = const Color(0xffdb3065);
        break;
      case 'rock':
        color = const Color(0xff9e873c);
        break;
      case 'steel':
        color = const Color(0xff8e8f9e);
        break;
      case 'water':
        color = const Color(0xff0d6bc2);
        break;
    }

    return color;
  }
}
