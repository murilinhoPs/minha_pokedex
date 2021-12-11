part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokemonDetailsReceived extends PokemonDetailsEvent {
  final int? pokemonId;

  PokemonDetailsReceived({
    this.pokemonId,
  });

  @override
  List<Object?> get props => [
        pokemonId,
      ];
}

class PokemonDetailsRetrieveIsFavorite extends PokemonDetailsEvent {}

class PokemonDetailsChangeIsFavorite extends PokemonDetailsEvent {
  final bool setFavorite;

  PokemonDetailsChangeIsFavorite({
    required this.setFavorite,
  });

  @override
  List<Object?> get props => [
        setFavorite,
      ];
}
