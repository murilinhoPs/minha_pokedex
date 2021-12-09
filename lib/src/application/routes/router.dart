import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/pages/fav_pokemons/fav_pokemons_page.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/pokedex_home_page.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_pokemon_details/pokedex_pokemon_details_page.dart';
import 'package:minha_pokedex/src/application/routes/routes_names.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesNames.homePage: (context) => PokedexHomePage(),
    RoutesNames.pokemonDetailsPage: (context) => PokedexPokemonDetailsPage(),
    RoutesNames.favPokemonsPage: (context) => FavPokemonsPage(),
  };
}
