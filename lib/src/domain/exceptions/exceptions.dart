abstract class PokemonsStorageExceptions implements Exception {
  final String message;
  PokemonsStorageExceptions(this.message) : super();
}

class CouldNotGetAllPokemons extends PokemonsStorageExceptions {
  CouldNotGetAllPokemons() : super('CouldNotGetAllPokemons');
}

class CouldNotGetPokemon extends PokemonsStorageExceptions {
  CouldNotGetPokemon() : super('CouldNotGetPokemon with details');
}

class CouldNotAddFavPokemon extends PokemonsStorageExceptions {
  CouldNotAddFavPokemon() : super('CouldNotAddFavPokemon to fav list');
}

class CouldNotUpdateFavPokemon extends PokemonsStorageExceptions {
  CouldNotUpdateFavPokemon()
      : super(
          'CouldNotUpdateFavPokemon to add or remove from fav list',
        );
}

class CouldNotDeletePokemonFromFav extends PokemonsStorageExceptions {
  CouldNotDeletePokemonFromFav() : super('CouldNotDeletePokemonFromFav');
}

class CouldNotDeleteAllPokemons extends PokemonsStorageExceptions {
  CouldNotDeleteAllPokemons()
      : super(
          'CouldNotDeleteAllPokemons from fav storage',
        );
}
