part of 'pokedex_search_bloc.dart';

@immutable
abstract class PokedexSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokedexSearchInitial extends PokedexSearchState {}

class PokedexSearchLoadInProgress extends PokedexSearchState {}

class PokedexSearchLoadSuccess extends PokedexSearchState {
  final List<Pokemon> pokemonsFromPokedex;
  final int currentPageOffest;

  PokedexSearchLoadSuccess({
    required this.pokemonsFromPokedex,
    required this.currentPageOffest,
  });

  @override
  List<Object?> get props => [];
}

class PokedexSearchLoadFailure extends PokedexSearchState {}
