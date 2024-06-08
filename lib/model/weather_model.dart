class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double latitude;
  final double longitude;
  final String description;
  final num humidity;
  final double windspeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.latitude, 
    required this.longitude,
    required this.description,
    required this.humidity,
    required this.windspeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      cityName: json['name'], 
      temperature: json['main']['temp'].toDouble(), 
      mainCondition: json['weather'][0]['main'], 
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windspeed: json['wind']['speed'],
    );
  }
}