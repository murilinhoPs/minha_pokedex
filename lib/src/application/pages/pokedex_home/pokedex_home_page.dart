import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/application/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/bloc/pokedex_search_bloc.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/widgets/pokedex_header.dart';
import 'package:minha_pokedex/src/application/widgets/loading_indicator.dart';
import 'package:minha_pokedex/src/application/widgets/pokemon_list.dart';
import 'package:minha_pokedex/src/application/widgets/reload_content_button.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/utils/assets.dart';
import 'package:minha_pokedex/src/utils/strings.dart';

class PokedexHomePage extends StatefulWidget {
  @override
  State<PokedexHomePage> createState() => _PokedexHomePageState();
}

class _PokedexHomePageState extends State<PokedexHomePage> {
  final pokedexSearchBloc = GetIt.I.get<PokedexSearchBloc>();
  final scrollController = ScrollController();

  @override
  void initState() {
    pokedexSearchBloc.add(
      PokedexSearchPageOpened(),
    );
    scrollController.addListener(_nextPageListener);
    super.initState();
  }

  void _nextPageListener() {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      Timer(Duration(milliseconds: 20), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 240),
          curve: Curves.decelerate,
        );
      });

      pokedexSearchBloc.add(
        PokedexSearchNextPageFetched(
          pageOffset: pokedexSearchBloc.state.currentPageOffset,
        ),
      );
    }
  }

  void _onSearchPokemon(String text) {
    pokedexSearchBloc.add(
      PokedexSearchPokemonFetched(searchTerm: text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -182,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  Assets.pokeball3x,
                  scale: 0.62,
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
                  PokedexHeader(
                    onChanged: _onSearchPokemon,
                  ),
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
        final status = state.status;
        final pokemonList = state.searchPokemons.isEmpty
            ? state.pokemons
            : state.searchPokemons;

        if (status == SearchStatus.failure) {
          return ReloadContentButton(
            onReload: () => pokedexSearchBloc.add(
              PokedexSearchPageOpened(),
            ),
            reloadText: Strings.reloadPokedex,
          );
        }

        if (status == SearchStatus.firstPageLoading) {
          return LoadingIndicator();
        }

        return PokemonList(
          pokemons: pokemonList,
          controller: scrollController,
          isLoadingPokemons: status == SearchStatus.nextPageLoading,
        );
      },
    );
  }
}
