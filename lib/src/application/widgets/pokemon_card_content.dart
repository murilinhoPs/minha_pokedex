import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/widgets/pokemon_type_widget.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon.dart';
import 'package:minha_pokedex/src/utils/element_types.dart';
import 'package:minha_pokedex/src/utils/string_extension.dart';

class PokemonCardContent extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCardContent({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  String _getFullPokemonId(int num) {
    final numLenght = num.toString().length;

    if (numLenght == 1) {
      return '#00$num';
    }
    if (numLenght == 2) {
      return '#0$num';
    }
    return '#$num';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPokemonImage(),
        SizedBox(width: 36.0),
        _buildPokemonDetails(),
      ],
    );
  }

  Widget _buildPokemonImage() {
    return Transform.scale(
      scale: 1.6,
      origin: Offset(-10, 0),
      child: Image.network(
        pokemon.imageUrl,
        fit: BoxFit.fitHeight,
        scale: 1.6,
      ),
    );
  }

  Widget _buildPokemonDetails() {
    final types = pokemon.types.map((type) {
      final color = elementTypesColors[type];

      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: PokemonTypeWidget(
          name: type.toCapitalized(),
          color: color!,
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          _getFullPokemonId(pokemon.pokedexNumber),
          style: TextStyle(
            letterSpacing: 1,
            color: Colors.red[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        // SizedBox(height: 4.0),
        Text(
          pokemon.name.toCapitalized(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            height: 0.8,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...types,
          ],
        ),
      ],
    );
  }
}
