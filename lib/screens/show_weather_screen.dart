import 'package:flutter/material.dart';
import 'package:weatherapp/services/database_helper.dart';
import 'package:weatherapp/widgets/weather_widget.dart';

import '../provider/weather_manager.dart';

class ShowWeatherScreen extends StatefulWidget {
  ShowWeatherScreen({super.key});

  @override
  State<ShowWeatherScreen> createState() => _ShowWeatherScreenState();
}

class _ShowWeatherScreenState extends State<ShowWeatherScreen> {
  WeatherManager weatherManager = WeatherManager();

  TextEditingController searchController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextField(
                    onSubmitted: (value) async {
                      if (searchController.text.isNotEmpty) {
                        setState(() {
                          loading = true;
                        });
                        await weatherManager
                            .getWeather(searchController.text.toLowerCase());

                        await DatabaseHelper.getAllFavorites();

                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(filled: true),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    controller: searchController,
                  ),
                ),
                !loading
                    ? IconButton(
                        onPressed: () async {
                          if (searchController.text.isNotEmpty) {
                            setState(() {
                              loading = true;
                            });
                            await weatherManager.getWeather(
                                searchController.text.toLowerCase());

                            await DatabaseHelper.getAllFavorites();

                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        icon: Icon(Icons.search),
                      )
                    : const CircularProgressIndicator(),
              ],
            ),
            if (weatherManager.weatherList.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(weatherManager.weatherList.first.city),
                  IconButton(
                    icon: Icon(
                      WeatherManager.getFavoriteList
                              .contains(weatherManager.weatherList.first.city)
                          ? Icons.star
                          : Icons.star_border,
                    ),
                    color: Colors.black,
                    onPressed: () async {
                      if (WeatherManager.getFavoriteList
                          .contains(weatherManager.weatherList.first.city)) {
                        await DatabaseHelper.deleteFavorite(weatherManager
                            .weatherList.first.city
                            .toLowerCase());
                      } else {
                        await DatabaseHelper.addFavorite(weatherManager
                            .weatherList.first.city
                            .toLowerCase());
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            Column(
              children: List.generate(
                weatherManager.weatherList.length,
                (index) =>
                    WeatherWidget(weather: weatherManager.weatherList[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
