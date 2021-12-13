import 'package:flutter_test/flutter_test.dart';
import 'package:minha_pokedex/src/infra/models/pokemon_model.dart';

void main() {
  test('Default test', () {
    final model = PokemonModel(
      name: 'pokemon',
      imageUrl: 'nada',
      pokedexNumber: 000,
      types: ['grass', 'dark'],
    );

    final jsonModel = model.toJson();
    print(jsonModel);

    final fromJsonModel = PokemonModel.fromJson(jsonModel);
    print(fromJsonModel.toString());

    expect(model.types, fromJsonModel.types);
  });
}
