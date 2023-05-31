import 'package:dio/dio.dart';
import 'package:weatherapp/provider/weather.dart';

class WeatherManager {
  List<Weather> weather = [];
  List<Weather> get weatherList => [...weather];
  static const url =
      "https://api.collectapi.com/weather/getWeather?data.lang=de&data.city=";

  static const apiKey = "apikey 3ygIzZUDsTbWk09FoMs189:04Opb9zghEo0PT9rrdhRZP";

  static Future getWeather(String city) async {
    try {
      Dio dio = Dio();
      var result = await dio.get(url + city);
    } catch (e) {
      print(e);
    }
  }
}
