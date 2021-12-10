import 'package:flutter/material.dart';

class FavPokemonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text(
          'FavPokemons',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
