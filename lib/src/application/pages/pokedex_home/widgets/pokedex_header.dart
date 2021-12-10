import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/pages/pokedex_home/widgets/search_bar.dart';
import 'package:minha_pokedex/src/utils/strings.dart';

class PokedexHeader extends StatelessWidget {
  const PokedexHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.pokedex,
              style: TextStyle(
                letterSpacing: 2.8,
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            Icon(
              Icons.circle,
              color: Colors.white,
            ),
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
        SizedBox(height: 12.0),
        SearchBar(),
      ],
    );
  }
}