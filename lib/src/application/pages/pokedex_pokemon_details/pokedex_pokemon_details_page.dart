import 'package:flutter/material.dart';

class PokedexPokemonDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text(
          'Pokemon details from pokedex',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
