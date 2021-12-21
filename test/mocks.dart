import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:minha_pokedex/src/application/pages/fav_pokemons/bloc/fav_pokemons_list_bloc.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/bloc/pokedex_search_bloc.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_pokemon_details/bloc/fav_icon_bloc/favorite_icon_bloc.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_pokemon_details/bloc/pokemon_details_bloc.dart';
import 'package:minha_pokedex/src/domain/repositories/fav_pokemons_storage_repository.dart';
import 'package:minha_pokedex/src/domain/repositories/poke_api_repository.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/add_fav_pokemon_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/delete_fav_pokemon_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/delete_fav_pokemons_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/get_fav_pokemon_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/get_fav_pokemons_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemon_details_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemons_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/search_pokemons_use_case.dart';
import 'package:minha_pokedex/src/infra/contracts/local_storage_provider.dart';
import 'package:minha_pokedex/src/infra/contracts/poke_api_provider.dart';
import 'package:mocktail/mocktail.dart';

class PokedexSearchBlocMock
    extends MockBloc<PokedexSearchEvent, PokedexSearchState>
    implements PokedexSearchBloc {}

class MockFavPokemonsListBlocMock
    extends MockBloc<FavPokemonsListEvent, FavPokemonsListState>
    implements FavPokemonsListBloc {}

class MockPokemonDetailsBlocMock
    extends MockBloc<PokemonDetailsEvent, PokemonDetailsState>
    implements PokemonDetailsBloc {}

class MockFavoriteIconBlocMock
    extends MockBloc<FavoriteIconEvent, FavoriteIconCheckFavState>
    implements FavoriteIconBloc {}

class GetPokemonsUseCaseMock extends Mock implements GetPokemonsUseCase {}

class SearchPokemonsUseCaseMock extends Mock implements SearchPokemonsUseCase {}

class GetPokemonDetailsUseCaseMock extends Mock
    implements GetPokemonDetailsUseCase {}

class AddFavPokemonUsecaseMock extends Mock implements AddFavPokemonUsecase {}

class DeleteFavPokemonUsecaseMock extends Mock
    implements DeleteFavPokemonUsecase {}

class DeleteFavPokemonsUsecaseMock extends Mock
    implements DeleteFavPokemonsUsecase {}

class GetFavPokemonUsecaseMock extends Mock implements GetFavPokemonUsecase {}

class GetFavPokemonsUsecaseMock extends Mock implements GetFavPokemonsUsecase {}

class FavPokemonsStorageRepositoryMock extends Mock
    implements FavPokemonsStorageRepository {}

class PokeApiRepositoryMock extends Mock implements PokeApiRepository {}

class DioMock extends Mock implements Dio {}

class PokeApiProviderMock extends Mock implements PokeApiProvider {}

class LocalStorageProviderMock extends Mock implements LocalStorageProvider {}
