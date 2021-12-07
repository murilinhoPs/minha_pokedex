import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/domain/exceptions/exceptions.dart';
import 'package:minha_pokedex/src/domain/repositories/fav_pokemons_storage_repository.dart';

class GetAllPokemonsUsecase {
  final FavPokemonsStorageRepository favPokemonsStorageRepository;

  GetAllPokemonsUsecase({
    required this.favPokemonsStorageRepository,
  });

  Future<List<Pokemon>> call() async {
    try {
      return await favPokemonsStorageRepository.getAllPokemons();
    } catch (e) {
      throw CouldNotGetAllPokemons('CouldNotGetAllPokemons, try again.');
    }
  }
}
