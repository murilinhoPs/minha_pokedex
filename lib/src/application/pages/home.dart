import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/get_all_pokemons_use_case.dart';

class MyHomePage extends StatelessWidget {
  final getAllPokemons = GetIt.I.get<GetAllPokemonsUsecase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Pokédex'),
      ),
      body: Center(
        child: Text(
          'Minha futura pokédex',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getAllPokemons();
        },
        tooltip: 'favorite',
        child: Icon(
          Icons.favorite,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
