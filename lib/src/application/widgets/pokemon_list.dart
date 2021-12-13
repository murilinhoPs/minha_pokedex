import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/routes/routes_names.dart';
import 'package:minha_pokedex/src/application/widgets/pokemon_card.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({
    Key? key,
    required this.pokemons,
  }) : super(key: key);

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: pokemons.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(height: 16.0),
      itemBuilder: (context, index) => PokemonCard(
        pokemon: pokemons[index],
        onTap: () {
          Navigator.pushNamed(
            context,
            RoutesNames.pokemonDetailsPage,
            arguments: pokemons[index].pokedexNumber,
          );
        },
      ),
    );
  }
}
