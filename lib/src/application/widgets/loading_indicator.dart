import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/utils/strings.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RefreshProgressIndicator(),
        Text(
          Strings.loading,
        )
      ],
    );
  }
}
