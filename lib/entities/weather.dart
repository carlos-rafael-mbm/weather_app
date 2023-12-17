class Weather {
  String? description;
  double? temp;
  double? pressure;
  double? humidity;
  double? windSpeed;
  String? city;
  int? timezone;
  String? icon;

  Weather(
      {this.description,
      this.temp,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.city,
      this.timezone,
      this.icon});

  Weather.fromJson(dynamic json) {
    description = json['description'];
    temp = json['temp'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    windSpeed = json['windSpeed'];
    city = json['city'];
    timezone = json['timezone'];
    icon = json['icon'];
  }
}
