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
    on<PokedexSearchStarted>(
      _onGetPokemonsCalled,
    );
  }

  Future<void> _onGetPokemonsCalled(
    PokedexSearchStarted event,
    Emitter<PokedexSearchState> emit,
  ) async {
    emit(PokedexSearchLoadInProgress());

    try {
      final pokemons = await getPokemons();

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
}
