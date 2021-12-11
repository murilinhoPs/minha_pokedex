import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon_details.dart';
import 'package:minha_pokedex/src/domain/use_cases/poke_api/get_pokemon_details_use_case.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final GetPokemonDetailsUseCase getPokemonDetails;

  PokemonDetailsBloc({
    required this.getPokemonDetails,
  }) : super(PokemonDetailsInitial()) {
    on<PokemonDetailsReceived>(_onPokemonDetailsFecthed);
    on<PokemonDetailsRetrieveIsFavorite>(_onPokemonDetailsCheckFavorite);
    on<PokemonDetailsChangeIsFavorite>(_onPokemonDetailsChangeIsFavorite);
  }

  Future<void> _onPokemonDetailsFecthed(
    PokemonDetailsReceived event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    emit(PokemonDetailsLoadInProgress());

    try {
      final id = pokemonCurrentId(event.pokemonId);

      final pokemon = await getPokemonDetails(id);

      return emit(
        PokemonDetailsLoadSuccess(
          pokemon: pokemon,
        ),
      );
    } catch (_) {
      emit(PokemonDetailsLoadFailed());
    }
  }

  int pokemonCurrentId(int? currentId) {
    if (currentId == null) {
      final min = 1;
      final max = 899;

      return min + Random().nextInt(max - min);
    }

    return currentId;
  }

  Future<void> _onPokemonDetailsChangeIsFavorite(
    PokemonDetailsChangeIsFavorite event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    return emit(
      PokemonDetailsCheckIsFavorite(
        isFavorite: event.setFavorite,
      ),
    );
  }

  Future<void> _onPokemonDetailsCheckFavorite(
    PokemonDetailsRetrieveIsFavorite event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    final isSaved = false; //TODO: Get from local storage on initState

    final isFavorite = isSaved ? isSaved : false;

    return emit(
      PokemonDetailsCheckIsFavorite(
        isFavorite: isFavorite,
      ),
    );
  }
}
