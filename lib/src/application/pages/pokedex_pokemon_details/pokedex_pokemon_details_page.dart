import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_pokemon_details/bloc/fav_icon_bloc/favorite_icon_bloc.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_pokemon_details/bloc/pokemon_details_bloc.dart';
import 'package:minha_pokedex/src/application/widgets/loading_indicator.dart';
import 'package:minha_pokedex/src/application/widgets/pokemon_type_widget.dart';
import 'package:minha_pokedex/src/application/widgets/reload_content_button.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon_details.dart';
import 'package:minha_pokedex/src/utils/element_types.dart';
import 'package:minha_pokedex/src/utils/formatters.dart';
import 'package:minha_pokedex/src/utils/string_extension.dart';
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
  final pokemonDetailsBloc = GetIt.I.get<PokemonDetailsBloc>();
  final favoriteIconBloc = GetIt.I.get<FavoriteIconBloc>();

  @override
  void initState() {
    pokemonDetailsBloc.add(
      PokemonDetailsReceived(
        pokemonId: widget.pokemonId,
      ),
    );

    favoriteIconBloc.add(
      FavoriteIconRetrieveIsFavorite(
        pokemonId: widget.pokemonId,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
            bloc: pokemonDetailsBloc,
            builder: (context, state) {
              if (state is PokemonDetailsLoadSuccess) {
                final pokemon = state.pokemon;

                return Container(
                  color: Colors.white,
                  child: Scaffold(
                    backgroundColor:
                        elementTypesColors[pokemon.types[0]]!.withOpacity(0.6),
                    appBar: _buildAppBar(pokemon),
                    body: _buildPokemonDetails(pokemon),
                  ),
                );
              }

              if (state is PokemonDetailsLoadFailed) {
                return Center(
                  child: ReloadContentButton(
                    onReload: () => pokemonDetailsBloc.add(
                      PokemonDetailsReceived(
                        pokemonId: widget.pokemonId,
                      ),
                    ),
                    reloadText: Strings.reloadPokemonDetails,
                  ),
                );
              }

              return Center(
                child: LoadingIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(PokemonDetails pokemon) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          splashRadius: 20.0,
          onPressed: () {
            favoriteIconBloc.add(
              FavoriteIconChangeIsFavorite(
                pokemon: pokemon,
              ),
            );
          },
          icon: BlocBuilder<FavoriteIconBloc, FavoriteIconCheckFavState>(
            bloc: favoriteIconBloc,
            builder: (context, state) {
              return Icon(
                state.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            getFullPokemonId(pokemon.pokedexNumber),
            style: TextStyle(
              letterSpacing: 2.4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildPokemonDetails(PokemonDetails pokemon) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 2.0,
            origin: Offset(-4, 0),
            child: Image.network(
              pokemon.imageUrl,
              // scale: 1.8,
            ),
          ),
          Text(
            '${pokemon.name}',
          ),
          PokemonTypeWidget(
            name: pokemon.types[0].toCapitalized(),
            color: elementTypesColors[pokemon.types[0]]!,
          ),
          Expanded(
            child: Material(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  54.0,
                ),
                topRight: Radius.circular(
                  54.0,
                ),
              ),
              color: Colors.grey[800],
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [Container()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
