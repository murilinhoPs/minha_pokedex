import 'package:json_annotation/json_annotation.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/pokemon_from_list.dart';

part 'pokemon_list_response.g.dart';

@JsonSerializable()
class PokemonListResponse {
  final int? count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'results')
  final List<PokemonFromList?>? pokemonsFromList;

  PokemonListResponse({
    this.count,
    this.next,
    this.previous,
    this.pokemonsFromList,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListResponseToJson(this);
}
