import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_pokemon_details/bloc/fav_icon_bloc/favorite_icon_bloc.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_pokemon_details/bloc/pokemon_details_bloc.dart';
import 'package:minha_pokedex/src/application/widgets/loading_indicator.dart';
import 'package:minha_pokedex/src/application/widgets/pokemon_type_widget.dart';
import 'package:minha_pokedex/src/application/widgets/reload_content_button.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon_details.dart';
import 'package:minha_pokedex/src/utils/assets.dart';
import 'package:minha_pokedex/src/utils/element_types.dart';
import 'package:minha_pokedex/src/utils/formatters.dart';
import 'package:minha_pokedex/src/utils/stats_abbreviations.dart';
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

                return Scaffold(
                  appBar: _buildAppBar(pokemon),
                  body: _buildPokemonDetails(pokemon),
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
        SizedBox(width: 16.0),
      ],
    );
  }

  Widget _buildPokemonDetails(PokemonDetails pokemon) {
    final types = pokemon.types.map((type) {
      final color = elementTypesColors[type];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: PokemonTypeWidget(
          name: type.toCapitalized(),
          color: color!,
        ),
      );
    }).toList();

    final stats = pokemon.stats.map((stat) {
      final pokemonStatColor = stat.baseStat <= 46
          ? Colors.red[400]
          : elementTypesColors[pokemon.types[0]];

      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            child: CircularProgressIndicator(
              color: pokemonStatColor,
              backgroundColor: Colors.grey[700],
              value: stat.baseStat.toDouble() / 100,
              strokeWidth: 8.0,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  statsAbbr[stat.name]!,
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
                Text(
                  '${stat.baseStat}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();

    return Column(
      children: [
        Container(
          height: 184,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [
                        Colors.white,
                        elementTypesColors[pokemon.types[0]]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.2, 1.2],
                    ).createShader(bounds);
                  },
                  child: Image.asset(
                    Assets.pokeball2x,
                    scale: 0.86,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
              Container(
                child: Transform.scale(
                  scale: 2.0,
                  origin: Offset(0, -4),
                  child: Image.network(
                    pokemon.imageUrl,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                32.0,
              ),
              topRight: Radius.circular(
                32.0,
              ),
            ),
            color: Colors.grey[800],
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 20.0,
                right: 20.0,
              ),
              children: [
                Text(
                  pokemon.name.toCapitalized(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...types,
                  ],
                ),
                SizedBox(height: 24.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${pokemon.height / 10} M',
                                  style: TextStyle(
                                    letterSpacing: 1.4,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  Strings.height,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              color: elementTypesColors[pokemon.types[0]],
                              thickness: 2.4,
                            ),
                            Column(
                              children: [
                                Text(
                                  '${pokemon.weight / 10} KG',
                                  style: TextStyle(
                                    letterSpacing: 1.4,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  Strings.weight,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              color: elementTypesColors[pokemon.types[0]],
                              thickness: 2.4,
                            ),
                            Column(
                              children: [
                                Text(
                                  getFullPokemonId(pokemon.pokedexNumber),
                                  style: TextStyle(
                                    letterSpacing: 1.4,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  Strings.pokedex,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.0),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 24.0,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: stats,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
