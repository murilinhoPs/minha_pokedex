import 'package:flutter/material.dart';

class PokedexHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Pokedex',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
