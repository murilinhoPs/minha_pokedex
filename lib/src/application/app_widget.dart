import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/pages/home.dart';
import 'package:minha_pokedex/src/application/routes/router.dart';
import 'package:minha_pokedex/src/application/routes/routes_names.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: Colors.red[600],
            ),
        scaffoldBackgroundColor: Colors.grey[800],
      ),
      initialRoute: RoutesNames.homePage,
      routes: AppRouter.routes,
      // home: MyHomePage(),
    );
  }
}
