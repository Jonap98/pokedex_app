import 'package:flutter/material.dart';
import 'package:pokedex_app/src/models/pokemon_model.dart';

class TypeTag extends StatelessWidget {
  const TypeTag({
    Key? key,
    required this.index,
    required this.text,
  }) : super(key: key);

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
