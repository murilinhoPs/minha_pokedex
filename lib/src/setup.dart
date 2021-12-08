import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/domain/repositories/fav_pokemons_storage_repository.dart';
import 'package:minha_pokedex/src/domain/repositories/poke_api_repository.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/add_fav_pokemon_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/delete_all_fav_pokemons_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/delete_fav_pokemon_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/get_all_fav_pokemons_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemon_details_use_case.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemons_use_case.dart';
import 'package:minha_pokedex/src/external/global_dio.dart';
import 'package:minha_pokedex/src/external/local_storage/local_storage_provider_impl.dart';
import 'package:minha_pokedex/src/external/local_storage/pokemons/fav_pokemons_db_service.dart';
import 'package:minha_pokedex/src/external/poke_api/poke_api_provider_impl.dart';
import 'package:minha_pokedex/src/infra/contracts/local_storage_provider.dart';
import 'package:minha_pokedex/src/infra/contracts/poke_api_provider.dart';
import 'package:minha_pokedex/src/infra/repositories/fav_pokemons_storage_repository_impl.dart';
import 'package:minha_pokedex/src/infra/repositories/poke_api_repository_impl.dart';

void setupAll() {
  _setupExternal();
  _setupInfra();
  _setupDomain();
  _setupControllers();
}

void _setupExternal() {
  GetIt.I.registerLazySingleton<LocalStorageProvider>(
    () => LocalStorageProviderImpl(
      database: FavPokemonsDbService.instance.database,
    ),
  );

  GetIt.I.registerLazySingleton<GlobalDio>(
    () => GlobalDio(),
  );

  GetIt.I.registerLazySingleton<PokeApiProvider>(
    () => PokeApiProviderImpl(
      client: GetIt.I.get<GlobalDio>(),
    ),
  );
}

void _setupInfra() {
  GetIt.I.registerLazySingleton<FavPokemonsStorageRepository>(
    () => FavPokemonsStorageRepositoryImpl(
      localStorage: GetIt.I.get<LocalStorageProvider>(),
    ),
  );

  GetIt.I.registerLazySingleton<PokeApiRepository>(
    () => PokeApiRepositroyImpl(
      pokeApiProvider: GetIt.I.get<PokeApiProvider>(),
    ),
  );
}

void _setupDomain() {
  GetIt.I.registerFactory<GetAllFavPokemonsUsecase>(
    () => GetAllFavPokemonsUsecase(
      favPokemonsStorageRepository: GetIt.I.get<FavPokemonsStorageRepository>(),
    ),
  );

  GetIt.I.registerFactory<AddFavPokemonUsecase>(
    () => AddFavPokemonUsecase(
      favPokemonsStorageRepository: GetIt.I.get<FavPokemonsStorageRepository>(),
    ),
  );

  GetIt.I.registerFactory<DeleteFavPokemonUsecase>(
    () => DeleteFavPokemonUsecase(
      favPokemonsStorageRepository: GetIt.I.get<FavPokemonsStorageRepository>(),
    ),
  );

  GetIt.I.registerFactory<DeleteAllFavPokemonUsecase>(
    () => DeleteAllFavPokemonUsecase(
      favPokemonsStorageRepository: GetIt.I.get<FavPokemonsStorageRepository>(),
    ),
  );

  GetIt.I.registerLazySingleton<GetPokemonsUseCase>(
    () => GetPokemonsUseCase(
      pokeApiRepository: GetIt.I.get<PokeApiRepository>(),
    ),
  );

  GetIt.I.registerLazySingleton<GetPokemonDetailsUseCase>(
    () => GetPokemonDetailsUseCase(
      pokeApiRepository: GetIt.I.get<PokeApiRepository>(),
    ),
  );
}

void _setupControllers() {}
