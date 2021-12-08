import 'package:dio/dio.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon_details.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon_stats.dart';
import 'package:minha_pokedex/src/domain/exceptions/pokemon_api_exceptions.dart';
import 'package:minha_pokedex/src/external/global_dio.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/pokemon_details_model.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/pokemon_list_response.dart';
import 'package:minha_pokedex/src/infra/contracts/poke_api_provider.dart';

class PokeApiProviderImpl implements PokeApiProvider {
  final GlobalDio client;

  PokeApiProviderImpl({
    required this.client,
  });

  @override
  Future<PokemonListResponse> getPokemonsSimpleList() async {
    try {
      final pokemonListData = await client.dio.get(
        'pokemon/?offset=0&limit=60',
      );

      print('PokemonListData: ${pokemonListData.data}');

      if (pokemonListData.data == null) throw CouldNotGetPokemonsList();

      return PokemonListResponse.fromJson(pokemonListData.data);
    } on DioError catch (_) {
      throw CouldNotGetPokemonsList();
    }
  }

  @override
  Future<List<Pokemon>> getAllPokemonsFullList() async {
    try {
      final pokemonFromApi = await getPokemonsSimpleList();

      var apiList = <PokemonDetailsModel>[];
      var pokemonList = <Pokemon>[];

      for (var pokemonFromList in pokemonFromApi.pokemonsFromList!) {
        final pokemonDetails = await client.dio.get('${pokemonFromList!.url}/');

        apiList.add(PokemonDetailsModel.fromJson(pokemonDetails.data));
      }

      for (var pokemonDetails in apiList) {
        final pokemon = Pokemon(
          name: pokemonDetails.name!,
          imageUrl: pokemonDetails.sprites!.frontDefault!,
          pokedexNumber: pokemonDetails.id!,
          types: pokemonDetails.types!
              .map(
                (type) => type!.type!.name!,
              )
              .toList(),
        );

        pokemonList.add(pokemon);
      }

      return pokemonList;
    } catch (e) {
      throw CouldNotGetPokemon();
    }
  }

  @override
  Future<PokemonDetails> getPokemonDetails(int pokemonId) async {
    try {
      final pokemonDetailsData = await client.dio.get('pokemon/$pokemonId');

      final pokemonDetails = PokemonDetailsModel.fromJson(
        pokemonDetailsData.data,
      );

      final pokemon = PokemonDetails(
        name: pokemonDetails.name!,
        imageUrl: pokemonDetails.sprites!.frontDefault!,
        pokedexNumber: pokemonDetails.id!,
        types: pokemonDetails.types!
            .map(
              (type) => type!.type!.name!,
            )
            .toList(),
        weight: pokemonDetails.weight!,
        height: pokemonDetails.height!,
        stats: pokemonDetails.stats!
            .map(
              (stat) => PokemonStats(
                baseStat: stat!.baseStat!,
                effort: stat.effort!,
                name: stat.stat!.name!,
              ),
            )
            .toList(),
      );

      return pokemon;
    } on DioError catch (_) {
      throw CouldNotGetPokemon();
    }
  }
}
