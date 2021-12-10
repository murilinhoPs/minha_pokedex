part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PokemonDetailsInitial extends PokemonDetailsState {}

class PokemonDetailsLoadInProgress extends PokemonDetailsState {}

class PokemonDetailsLoadSuccess extends PokemonDetailsState {
  final PokemonDetails pokemon;

  PokemonDetailsLoadSuccess({
    required this.pokemon,
  });

  @override
  List<Object> get props => [
        pokemon,
      ];
}

class PokemonDetailsLoadFailed extends PokemonDetailsState {}

class PokemonDetailsCheckIsFavorite extends PokemonDetailsState {
  final bool isFavorite;

  PokemonDetailsCheckIsFavorite({
    required this.isFavorite,
  });

  @override
  List<Object> get props => [
        isFavorite,
      ];
}
