import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/domain/entities/pokemon_details.dart';

class FavoriteIconAppBar extends StatelessWidget {
  const FavoriteIconAppBar({
    Key? key,
    required this.onIconTap,
    required this.isFavorite,
    required this.pokemon,
  }) : super(key: key);

  final bool isFavorite;
  final PokemonDetails pokemon;
  final VoidCallback onIconTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          splashRadius: 20.0,
          onPressed: onIconTap,
          icon: Icon(
            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          ),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}
