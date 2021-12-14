import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/utils/string_extension.dart';

class PokemonNameTitle extends StatelessWidget {
  const PokemonNameTitle({
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name.toCapitalized(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        letterSpacing: 1.2,
      ),
    );
  }
}
