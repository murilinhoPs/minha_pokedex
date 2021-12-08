import 'package:json_annotation/json_annotation.dart';

part 'pokemon_from_list.g.dart';

@JsonSerializable()
class PokemonFromList {
  final String? name;
  final String? url;

  PokemonFromList({
    this.name,
    this.url,
  });

  factory PokemonFromList.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromListFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonFromListToJson(this);
}
