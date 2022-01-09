import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/routes/routes_names.dart';
import 'package:minha_pokedex/src/application/widgets/loading_indicator.dart';
import 'package:minha_pokedex/src/application/widgets/pokemon_card.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/utils/strings.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({
    Key? key,
    required this.pokemons,
    this.refreshPokemons,
    this.controller,
    this.isLoadingPokemons = false,
    this.canLoadMore = false,
  }) : super(key: key);

  final bool Function()? refreshPokemons;
  final ScrollController? controller;
  final List<Pokemon> pokemons;
  final bool isLoadingPokemons;
  final bool canLoadMore;

  int get loadingPokemonsLenght => isLoadingPokemons || canLoadMore ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return PullToRefreshNotification(
      onRefresh: () async {
        if (refreshPokemons == null) return false;

        return refreshPokemons!();

        // await Future.delayed(Duration(seconds: 3));

        // return true;
      },
      maxDragOffset: 72,
      armedDragUpCancel: false,
      reverse: true,
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        controller: controller,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => index < pokemons.length
                  ? Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                        top: 8.0,
                      ),
                      child: PokemonCard(
                        pokemon: pokemons[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesNames.pokemonDetailsPage,
                            arguments: pokemons[index].pokedexNumber,
                          );
                        },
                      ),
                    )
                  : canLoadMore
                      ? Text(
                          Strings.loadMore,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
              childCount: pokemons.length + loadingPokemonsLenght,
            ),
          ),
          PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
            final double offset = info?.dragOffset ?? 0.0;

            return SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                height: offset,
                child: LoadingIndicator(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
