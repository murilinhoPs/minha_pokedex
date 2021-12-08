import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/domain/exceptions/pokemon_storage_exceptions.dart';
import 'package:minha_pokedex/src/domain/repositories/fav_pokemons_storage_repository.dart';

class GetAllFavPokemonsUsecase {
  final FavPokemonsStorageRepository favPokemonsStorageRepository;

  GetAllFavPokemonsUsecase({
    required this.favPokemonsStorageRepository,
  });

  Future<List<Pokemon>> call() async {
    try {
      return await favPokemonsStorageRepository.getAllPokemons();
    } on CouldNotGetAllPokemons {
      rethrow;
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
