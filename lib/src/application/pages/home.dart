import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/get_fav_pokemons_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemon_details_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemons_use_case.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final getFavPokemons = GetIt.I.get<GetFavPokemonsUsecase>();
  final getPokemons = GetIt.I.get<GetPokemonsUseCase>();
  final getPokemon = GetIt.I.get<GetPokemonDetailsUseCase>();

  var pokemons = <Pokemon>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Pokédex'),
      ),
      body: pokemons.length == 0
          ? Center(
              child: Text(
                'Minha futura pokédex',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: pokemons
                      .map(
                        (pkm) => Text(
                          '${pkm.name} - Nº:${pkm.pokedexNumber}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // getAllPokemons();
          pokemons = await getPokemons();
          setState(() {});
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
