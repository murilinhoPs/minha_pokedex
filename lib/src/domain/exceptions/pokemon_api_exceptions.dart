abstract class PokemonApiExceptions implements Exception {
  final String message;
  PokemonApiExceptions(this.message) : super();
}

class CouldNotGetPokemonsList extends PokemonApiExceptions {
  CouldNotGetPokemonsList() : super('Could not get pokemon list from api');
}

class CouldNotGetAllPokemons extends PokemonApiExceptions {
  CouldNotGetAllPokemons() : super('Could not find all pokemons from api');
}

class CouldNotGetPokemon extends PokemonApiExceptions {
  CouldNotGetPokemon() : super('Could not find that specific pokemon');
}
