import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/widgets/pokemon_type_widget.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/utils/element_types.dart';
import 'package:minha_pokedex/src/utils/formatters.dart';
import 'package:minha_pokedex/src/utils/string_extension.dart';

class PokemonCardContent extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCardContent({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPokemonImage(),
        SizedBox(width: 20.0),
        Expanded(
          child: _buildPokemonDetails(),
        ),
      ],
    );
  }

  Widget _buildPokemonImage() {
    return Transform.scale(
      scale: 1.6,
      origin: Offset(-8, 0),
      child: Image.network(
        pokemon.imageUrl,
        scale: 1.8,
      ),
    );
  }

  Widget _buildPokemonDetails() {
    final types = pokemon.types.map((type) {
      final color = elementTypesColors[type];

      return PokemonTypeWidget(
        name: type.toCapitalized(),
        color: color!,
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getFullPokemonId(pokemon.pokedexNumber),
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.red[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              pokemon.name.toCapitalized(),
              style: TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                height: 1.0,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8.0)
          ],
        ),
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          spacing: 8.0,
          children: [
            ...types,
          ],
        ),
      ],
    );
  }
}
