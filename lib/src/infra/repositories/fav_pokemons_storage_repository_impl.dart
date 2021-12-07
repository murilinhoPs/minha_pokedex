import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/domain/repositories/fav_pokemons_storage_repository.dart';
import 'package:minha_pokedex/src/external/local_storage/pokemons/fav_pokemons_db_fields.dart';
import 'package:minha_pokedex/src/infra/contracts/local_storage_provider.dart';
import 'package:minha_pokedex/src/infra/models/pokemon_model.dart';

class FavPokemonsStorageRepositoryImpl implements FavPokemonsStorageRepository {
  final LocalStorageProvider localStorage;

  const FavPokemonsStorageRepositoryImpl({
    required this.localStorage,
  });

  Future<Pokemon> insertPokemon({
    required String tableName,
    required PokemonModel pokemon,
  }) async {
    final id = await localStorage.insertItem(tableName, pokemon.toMap());

    return pokemon.copyWith(id: id);
  }

  Future<Pokemon> getPokemon(int itemId) async {
    final pokemonMap = await localStorage.getItem(
      tableName: favPokemonsTable,
      values: FavPokemonsFields.values,
      itemId: itemId,
    );

    return PokemonModel.fromMap(pokemonMap);
  }

  Future<List<Pokemon>> getAllPokemons() async {
    print('Get All Pokemos');

    final allPokemons = await localStorage.getAllItems(favPokemonsTable);

    return allPokemons
        .map(
          (json) => PokemonModel.fromMap(json),
        )
        .toList();
  }

  Future<int> updatePokemon({
    required int id,
    required PokemonModel pokemon,
  }) async {
    final updatedPokemon = await localStorage.updateItem(
      tableName: favPokemonsTable,
      values: pokemon.toMap(),
      itemId: id,
    );

    return updatedPokemon;
  }

  Future<int> deletePokemon(int id) async {
    return await localStorage.deleteItem(
      favPokemonsTable,
      id,
    );
  }

  @override
  Future deletePokemons() async {
    return await localStorage.deleteTable(favPokemonsTable);
  }
}
