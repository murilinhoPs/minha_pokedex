import 'package:flutter/material.dart';
import 'package:minha_pokedex/src/application/routes/router.dart';
import 'package:minha_pokedex/src/application/routes/routes_names.dart';
import 'package:minha_pokedex/src/utils/strings.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.pokedex,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[900],
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesNames.homePage,
      routes: AppRouter.routes,
      // home: MyHomePage(),
    );
  }
}
