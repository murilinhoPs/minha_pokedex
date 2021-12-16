import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/widgets/search_bar.dart';
import 'package:minha_pokedex/src/utils/assets.dart';
import 'package:minha_pokedex/src/utils/strings.dart';

class PokedexHeader extends StatelessWidget {
  PokedexHeader({
    Key? key,
    required this.onChanged,
    this.searchText = '',
  }) : super(key: key);

  final Function(String) onChanged;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.pokedex.toUpperCase(),
              style: TextStyle(
                letterSpacing: 2.8,
                color: Colors.white,
                fontSize: 36,
              ),
            ),
            Image.asset(
              Assets.pokeball,
              height: 32,
            )
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          Strings.searchInPokedex,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.0,
          ),
        ),
        SizedBox(height: 16.0),
        SearchBar(
          onChanged: onChanged,
          searchText: searchText,
        ),
      ],
    );
  }
}
