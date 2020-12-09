import 'package:flutter/material.dart';
import 'package:flutter_clima/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_clima/services/location.dart';
import 'package:flutter_clima/services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '78f976916af7b523b6cca9979b57df2f';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }



    void getLocationData() async{

      Location location = Location();

      await location.getCurrentLocation();

      NetworkHelper networkhelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

      var weather = await networkhelper.getData();

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weather,);
      }));

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
