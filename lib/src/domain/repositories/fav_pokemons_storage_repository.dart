import 'package:minha_pokedex/src/infra/models/pokemon_model.dart';

abstract class FavPokemonsStorageRepository {
  Future getPokemon(int itemId) async {}

  Future getAllPokemons() async {}

  Future insertPokemon({
    required String tableName,
    required PokemonModel pokemon,
  }) async {}

  Future updatePokemon({
    required int id,
    required PokemonModel pokemon,
  }) async {}

  Future deletePokemon(int id) async {}

  Future deletePokemons() async {}
}
