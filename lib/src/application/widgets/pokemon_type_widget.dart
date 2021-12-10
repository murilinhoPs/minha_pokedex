import 'package:flutter/material.dart';

class PokemonTypeWidget extends StatelessWidget {
  const PokemonTypeWidget({
    required this.name,
    required this.color,
  });

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.0,
          ),
        ),
      ),
      color: color.withOpacity(0.9),
      child: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(
          // horizontal: 16.0,
          vertical: 1.4,
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.4,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
