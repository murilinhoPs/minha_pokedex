import 'package:flutter/material.dart';

class PokemonCircularStat extends StatelessWidget {
  const PokemonCircularStat({
    Key? key,
    required this.pokemonStatColor,
    required this.baseStat,
    required this.statName,
  }) : super(key: key);

  final Color pokemonStatColor;
  final int baseStat;
  final String statName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80.0,
          height: 80.0,
          child: CircularProgressIndicator(
            color: pokemonStatColor,
            backgroundColor: Colors.grey[700],
            value: baseStat.toDouble() / 100,
            strokeWidth: 8.0,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                statName,
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
              Text(
                '$baseStat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
