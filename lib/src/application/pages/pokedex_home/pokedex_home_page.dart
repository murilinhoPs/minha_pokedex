import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/application/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/bloc/pokedex_search_bloc.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/widgets/pokedex_header.dart';
import 'package:minha_pokedex/src/application/widgets/loading_indicator.dart';
import 'package:minha_pokedex/src/application/widgets/pokemon_list.dart';
import 'package:minha_pokedex/src/application/widgets/reload_content_button.dart';
import 'package:minha_pokedex/src/utils/assets.dart';
import 'package:minha_pokedex/src/utils/strings.dart';

class PokedexHomePage extends StatefulWidget {
  @override
  State<PokedexHomePage> createState() => _PokedexHomePageState();
}

class _PokedexHomePageState extends State<PokedexHomePage> {
  final pokedexSearchBloc = GetIt.I.get<PokedexSearchBloc>();

  @override
  void initState() {
    pokedexSearchBloc.add(
      PokedexSearchStarted(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -184,
              left: 0,
              right: 0,
              child: Container(
                child: Image.asset(
                  Assets.pokeball3x,
                  scale: 0.6,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                16.0,
                12.0,
                16.0,
                0.0,
              ),
              child: Column(
                children: [
                  PokedexHeader(),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: _buildPokemonCards(),
                  ),
                  SizedBox(height: 64.0),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonCards() {
    return BlocBuilder<PokedexSearchBloc, PokedexSearchState>(
      bloc: pokedexSearchBloc,
      builder: (context, state) {
        if (state is PokedexSearchLoadSuccess) {
          final pokemonsList = state.pokemonsFromPokedex;

          return PokemonList(
            pokemons: pokemonsList,
          );
        }

        if (state is PokedexSearchLoadFailure) {
          return ReloadContentButton(
            onReload: () => pokedexSearchBloc.add(
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
