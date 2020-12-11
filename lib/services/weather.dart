import 'package:flutter_clima/services/location.dart';
import 'package:flutter_clima/services/networking.dart';

const apiKey = '78f976916af7b523b6cca9979b57df2f';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

// https://api.openweathermap.org/data/2.5/weather?q=London&appid=78f976916af7b523b6cca9979b57df2f&units=metric

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    print('getCityWeather started');
    NetworkHelper networkhelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weather = await networkhelper.getData();
    print(weather);
    return weather;
  }

  Future<dynamic> getLocationWeather() async {
    print('getLocationWeather started');
    Location location = Location();
    await location.getCurrentLocation();
    print('got location');
    NetworkHelper networkhelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weather = await networkhelper.getData();
    print('got json');
    return weather;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
