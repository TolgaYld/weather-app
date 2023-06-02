import 'package:flutter/material.dart';
import 'package:weatherapp/provider/weather_manager.dart';
import 'package:weatherapp/services/database_helper.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesList = WeatherManager.getFavoriteList;
    return favoritesList == null ||
            (favoritesList != null && favoritesList!.isEmpty)
        ? Center(
            child: Text("Keine Einträge"),
          )
        : ListView(
            children: List.generate(
              favoritesList!.length,
              (index) => ListTile(
                title: Text(favoritesList![index]),
              ),
            ),
          );
  }
}
