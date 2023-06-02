import 'package:flutter/material.dart';
import 'package:weatherapp/provider/weather.dart';
import 'package:weatherapp/provider/weather_manager.dart';
import 'package:weatherapp/screens/favorites_screen.dart';
import 'package:weatherapp/screens/show_weather_screen.dart';

class ShowNavigationBar extends StatefulWidget {
  const ShowNavigationBar({super.key});

  @override
  State<ShowNavigationBar> createState() => _ShowNavigationBarState();
}

class _ShowNavigationBarState extends State<ShowNavigationBar> {
  int currentIndex = 0;

  List<Weather> weatherList = [];

  WeatherManager weatherManager = WeatherManager();

  List<Widget> screens = [
    ShowWeatherScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather-App"),
        centerTitle: true,
      ),
      body: GestureDetector(
          onTap: () => FocusScope, child: screens[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        // type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: "Wetter",
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favoriten",
            backgroundColor: Colors.yellow,
          )
        ],
      ),
    );
  }
}
