import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/weather_widget.dart';

class ShowWeatherScreen extends StatelessWidget {
  const ShowWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(bottom: true, top: true, child: const WeatherWidget());
  }
}
