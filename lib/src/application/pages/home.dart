import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/get_all_fav_pokemons_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemon_details_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemons_use_case.dart';

class MyHomePage extends StatelessWidget {
  final getFavPokemons = GetIt.I.get<GetAllFavPokemonsUsecase>();

  final getPokemons = GetIt.I.get<GetPokemonsUseCase>();
  final getPokemon = GetIt.I.get<GetPokemonDetailsUseCase>();

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
          // getAllPokemons();
          getPokemons();
          // getPokemon(1);
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
