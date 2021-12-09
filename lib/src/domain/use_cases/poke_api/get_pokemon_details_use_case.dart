import 'package:minha_pokedex/src/domain/entities/pokemon_details.dart';
import 'package:minha_pokedex/src/domain/exceptions/pokemon_storage_exceptions.dart';
import 'package:minha_pokedex/src/domain/repositories/poke_api_repository.dart';

class GetPokemonDetailsUseCase {
  final PokeApiRepository pokeApiRepository;

  GetPokemonDetailsUseCase({
    required this.pokeApiRepository,
  });

  Future<PokemonDetails> call(int pokemonId) async {
    try {
      return await pokeApiRepository.getPokemonDetails(pokemonId);
    } on CouldNotGetFavPokemon {
      rethrow;
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
