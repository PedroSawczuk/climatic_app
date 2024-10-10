class WeatherModel {
  final double temp;
  final double temp_min;
  final double temp_max;
  final double pressure;
  final double humidity;
  final double tempSensation;
  final String nameCity;
  final String description;

  WeatherModel({
    required this.temp,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.humidity,
    required this.tempSensation,
    required this.nameCity,
    required this.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['main']['temp'],
      temp_min: json['main']['temp_min'],
      temp_max: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      tempSensation: json['main']['feels_like'],
      nameCity: json['name'],
      description: json['weather'][0]['description'],
    );
  }
}
