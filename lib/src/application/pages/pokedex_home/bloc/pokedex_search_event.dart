part of 'pokedex_search_bloc.dart';

@immutable
abstract class PokedexSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PokedexSearchStarted extends PokedexSearchEvent {}

class PokedexSearchNextPageStarted extends PokedexSearchEvent {}
