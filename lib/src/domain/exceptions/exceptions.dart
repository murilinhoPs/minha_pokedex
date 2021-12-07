abstract class PokemonsStorageExceptions implements Exception {
  final String message;
  PokemonsStorageExceptions(this.message) : super();
}

class CouldNotGetAllPokemons extends PokemonsStorageExceptions {
  CouldNotGetAllPokemons(String message) : super(message);
}
