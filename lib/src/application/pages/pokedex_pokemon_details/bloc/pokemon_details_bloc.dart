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
  }

  Future<void> _onPokemonDetailsFecthed(
    PokemonDetailsReceived event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    emit(PokemonDetailsLoadInProgress());

    try {
      final pokemon = await getPokemonDetails(event.pokemonId);

      return emit(
        PokemonDetailsLoadSuccess(pokemon: pokemon),
      );
    } catch (_) {
      emit(PokemonDetailsLoadFailed());
    }
  }

  Future<void> _onPokemonDetailsCheckFavorite(
    PokemonDetailsRetrieveIsFavorite event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    final isFavorite = false; //TODO: Get from local storage

    return emit(
      PokemonDetailsCheckIsFavorite(
        isFavorite: isFavorite,
      ),
    );
  }
}
