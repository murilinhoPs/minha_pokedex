part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PokemonDetailsReceived extends PokemonDetailsEvent {
  final int pokemonId;

  PokemonDetailsReceived({
    required this.pokemonId,
  });

  @override
  List<Object> get props => [
        pokemonId,
      ];
}

class PokemonDetailsRetrieveIsFavorite extends PokemonDetailsEvent {}
