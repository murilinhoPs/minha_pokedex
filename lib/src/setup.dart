import 'package:get_it/get_it.dart';
import 'package:minha_pokedex/src/domain/repositories/fav_pokemons_storage_repository.dart';
import 'package:minha_pokedex/src/domain/use_cases/fav_pokemons/get_all_pokemons_use_case.dart';
import 'package:minha_pokedex/src/external/local_storage/local_storage_provider_impl.dart';
import 'package:minha_pokedex/src/external/local_storage/pokemons/fav_pokemons_db_service.dart';
import 'package:minha_pokedex/src/infra/contracts/local_storage_provider.dart';
import 'package:minha_pokedex/src/infra/repositories/fav_pokemons_storage_repository_impl.dart';

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
}

void _setupInfra() {
  GetIt.I.registerLazySingleton<FavPokemonsStorageRepository>(
    () => FavPokemonsStorageRepositoryImpl(
      localStorage: GetIt.I.get<LocalStorageProvider>(),
    ),
  );
}

void _setupDomain() {
  GetIt.I.registerFactory<GetAllPokemonsUsecase>(
    () => GetAllPokemonsUsecase(
      favPokemonsStorageRepository: GetIt.I.get<FavPokemonsStorageRepository>(),
    ),
  );
}

void _setupControllers() {}
