import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/routes/routes_names.dart';
import 'package:minha_pokedex/src/application/widgets/loading_indicator.dart';
import 'package:minha_pokedex/src/application/widgets/pokemon_card.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({
    Key? key,
    required this.pokemons,
    this.controller,
    this.isLoadingPokemons = false,
  }) : super(key: key);

  final List<Pokemon> pokemons;
  final ScrollController? controller;
  final bool isLoadingPokemons;

  int get loadingPokemonsLenght => isLoadingPokemons ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      shrinkWrap: true,
      itemCount: pokemons.length + loadingPokemonsLenght,
      separatorBuilder: (context, index) => SizedBox(height: 16.0),
      itemBuilder: (context, index) => index < pokemons.length
          ? PokemonCard(
              pokemon: pokemons[index],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesNames.pokemonDetailsPage,
                  arguments: pokemons[index].pokedexNumber,
                );
              },
            )
          : Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 16,
              ),
              child: LoadingIndicator(),
            ),
    );
  }
}
