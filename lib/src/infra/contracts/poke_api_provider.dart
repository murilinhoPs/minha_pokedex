import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon_details.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/pokemon_list_response.dart';

abstract class PokeApiProvider {
  Future<PokemonListResponse> getPokemonsSimpleList();

  Future<List<Pokemon>> getAllPokemonsFullList();

  Future<PokemonDetails> getPokemonDetails(int pokemonId);
}
