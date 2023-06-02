import 'package:dio/dio.dart';
import 'package:weatherapp/provider/weather.dart';

List<Weather> weather = [];
List<String> favoriteList = [];

class WeatherManager {
  List<Weather> get weatherList => weather;
  static List<String> get getFavoriteList => favoriteList;
  static void setFavoriteList(List<String> favoriteList) =>
      favoriteList = favoriteList;
  static void addToFavoriteList(String city) => favoriteList.add(city);
  static void deleteFromFavoriteList(String city) =>
      favoriteList.removeWhere((element) => element == city);
  static const url =
      "https://api.collectapi.com/weather/getWeather?data.lang=de&data.city=";

  static const apiKey = "apikey 3ygIzZUDsTbWk09FoMs189:04Opb9zghEo0PT9rrdhRZP";

  Future getWeather(String city) async {
    try {
      Dio dio = Dio();
      var result = await dio.get(url + city,
          options: Options(headers: {"Authorization": apiKey}));

      if (result.data["success"] == false) {
        // throw Error();
      } else {
        weather.clear();
        List wList = result.data["result"];

        for (int i = 0; i < wList.length; i++) {
          weather.add(Weather(
            day: wList[i]["day"],
            city: city,
            min: wList[i]["min"],
            max: wList[i]["max"],
            degree: wList[i]["degree"],
            iconLink: wList[i]["icon"],
          ));
        }
      }
      print(weather);
    } catch (e) {
      print(e);
      throw Error();
    }
  }
}
