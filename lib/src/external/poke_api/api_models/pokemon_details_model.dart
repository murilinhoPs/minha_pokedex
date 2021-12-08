import 'package:json_annotation/json_annotation.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/ability.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/game_indice.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/item.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/species.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/sprites.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/move.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/stats.dart';
import 'package:minha_pokedex/src/external/poke_api/api_models/type.dart';

part 'pokemon_details_model.g.dart';

@JsonSerializable()
class PokemonDetailsModel {
  int? id;
  String? name;
  int? baseExperience;
  int? height;
  int? weight;
  bool? isDefault;
  int? order;
  String? locationAreaEncounters;
  Sprites? sprites;
  Species? species;
  List<Ability?>? abilities;
  List<GameIndice?>? gameIndices;
  List<Item?>? heldItems;
  List<Move?>? moves;
  List<TypeInfo?>? types;
  List<Stats?>? stats;

  PokemonDetailsModel({
    this.abilities,
    this.baseExperience,
    this.gameIndices,
    this.height,
    this.heldItems,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.moves,
    this.name,
    this.order,
    this.species,
    this.sprites,
    this.stats,
    this.types,
    this.weight,
  });

  factory PokemonDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailsModelToJson(this);
}
