import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/bloc/pokedex_search_bloc.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/widgets/pokedex_header.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/widgets/pokemon_list.dart';
import 'package:minha_pokedex/src/application/widgets/loading_indicator.dart';
import 'package:minha_pokedex/src/application/widgets/reload_content_button.dart';
import 'package:minha_pokedex/src/utils/strings.dart';

class PokedexHomePage extends StatefulWidget {
  @override
  State<PokedexHomePage> createState() => _PokedexHomePageState();
}

class _PokedexHomePageState extends State<PokedexHomePage> {
  final pokedexSearch = GetIt.I.get<PokedexSearchBloc>();

  @override
  void initState() {
    pokedexSearch.add(
      PokedexSearchStarted(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Column(
            children: [
              PokedexHeader(),
              SizedBox(height: 16.0),
              Expanded(
                child: _buildPokemonCards(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPokemonCards() {
    return BlocBuilder<PokedexSearchBloc, PokedexSearchState>(
      bloc: pokedexSearch,
      builder: (context, state) {
        if (state is PokedexSearchLoadSuccess) {
          final pokemonsList = state.pokemonsFromPokedex;

          return PokemonList(
            pokemons: pokemonsList,
          );
        }

        if (state is PokedexSearchLoadFailure) {
          return ReloadContentButton(
            onReload: () => pokedexSearch.add(
              PokedexSearchStarted(),
            ),
            reloadText: Strings.reloadPokedex,
          );
        }

        return LoadingIndicator();
      },
    );
  }
}
