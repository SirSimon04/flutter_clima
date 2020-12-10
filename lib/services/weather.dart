import 'package:flutter_clima/services/location.dart';
import 'package:flutter_clima/services/networking.dart';

const openWeatherApiURL = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = '78f976916af7b523b6cca9979b57df2f';

class WeatherModel {


  Future<dynamic> getWeatherLocation() async{
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkhelper = NetworkHelper('$openWeatherApiURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weather = await networkhelper.getData();

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
