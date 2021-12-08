import 'package:minha_pokedex/src/domain/exceptions/pokemon_storage_exceptions.dart';
import 'package:minha_pokedex/src/domain/repositories/fav_pokemons_storage_repository.dart';

class DeleteAllFavPokemonUsecase {
  final FavPokemonsStorageRepository favPokemonsStorageRepository;

  DeleteAllFavPokemonUsecase({
    required this.favPokemonsStorageRepository,
  });

  Future<int> call() async {
    try {
      return await favPokemonsStorageRepository.deletePokemons();
    } on CouldNotDeleteAllPokemons {
      rethrow;
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
