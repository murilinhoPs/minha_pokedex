import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_pokemon_details/bloc/pokemon_details_bloc.dart';
import 'package:minha_pokedex/src/application/widgets/loading_indicator.dart';
import 'package:minha_pokedex/src/application/widgets/reload_content_button.dart';
import 'package:minha_pokedex/src/utils/strings.dart';

class PokedexPokemonDetailsPage extends StatefulWidget {
  const PokedexPokemonDetailsPage({
    Key? key,
    this.pokemonId,
  }) : super(key: key);

  final int? pokemonId;

  @override
  State<PokedexPokemonDetailsPage> createState() =>
      _PokedexPokemonDetailsPageState();
}

class _PokedexPokemonDetailsPageState extends State<PokedexPokemonDetailsPage> {
  final pokemonDetails = GetIt.I.get<PokemonDetailsBloc>();

  @override
  void initState() {
    pokemonDetails.add(
      PokemonDetailsReceived(
        pokemonId: widget.pokemonId,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
          bloc: pokemonDetails,
          builder: (context, state) {
            if (state is PokemonDetailsLoadSuccess) {
              final pokemon = state.pokemon;

              return Text(
                '${pokemon.name} : ${pokemon.pokedexNumber}',
              );
            }

            if (state is PokemonDetailsLoadFailed) {
              return ReloadContentButton(
                onReload: () => pokemonDetails.add(
                  PokemonDetailsReceived(
                    pokemonId: widget.pokemonId,
                  ),
                ),
                reloadText: Strings.reloadPokemonDetails,
              );
            }

            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
