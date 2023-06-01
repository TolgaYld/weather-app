class Weather {
  String day;
  String city;
  String min;
  String max;
  String degree;
  String? iconLink;

  Weather({
    required this.day,
    required this.city,
    required this.min,
    required this.max,
    required this.degree,
     this.iconLink,
  });
}
