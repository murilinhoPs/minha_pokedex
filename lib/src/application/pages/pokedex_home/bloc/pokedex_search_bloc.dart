import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemons_use_case.dart';

part 'pokedex_search_event.dart';
part 'pokedex_search_state.dart';

class PokedexSearchBloc extends Bloc<PokedexSearchEvent, PokedexSearchState> {
  final GetPokemonsUseCase getPokemons;
  PokedexSearchBloc({
    required this.getPokemons,
  }) : super(PokedexSearchInitial()) {
    on<PokedexSearchOpened>(_onGetPokemonsCalled);
    on<PokedexSearchNextPageFetched>(_onNextPokemonPageFetched);
  }

  bool _isFetching = false;
  List<Pokemon> _pokemonList = [];

  Future<void> _onGetPokemonsCalled(
    PokedexSearchOpened event,
    Emitter<PokedexSearchState> emit,
  ) async {
    emit(PokedexSearchLoadInProgress());

    try {
      final pokemons = await getPokemons(
        pageOffset: 0,
      );
      _pokemonList = pokemons;

      return emit(
        PokedexSearchLoadSuccess(
          pokemonsFromPokedex: pokemons,
          currentPageOffest: 0,
        ),
      );
    } catch (_) {
      emit(PokedexSearchLoadFailure());
    }
  }

  Future<void> _onNextPokemonPageFetched(
    PokedexSearchNextPageFetched event,
    Emitter<PokedexSearchState> emit,
  ) async {
    emit(PokedexSearchNextPageInProgress());

    final offset = event.pageOffset + 24;

    try {
      if (!_isFetching) {
        _isFetching = true;

        final pokemons = await getPokemons(
          pageOffset: offset,
        );
        _pokemonList..addAll(pokemons);

        emit(
          PokedexSearchLoadSuccess(
            pokemonsFromPokedex: _pokemonList,
            currentPageOffest: offset,
          ),
        );
        _isFetching = false;
      }
    } catch (_) {
      emit(PokedexSearchLoadFailure());
    }
  }
}
