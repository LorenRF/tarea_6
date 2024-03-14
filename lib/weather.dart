import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherPage();
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  var hour = DateTime.now().hour;
  String _weather = '';
  String _description = '';
  String _iconCode = '';
  bool _isLoading = false;

  DecorationImage getBackgroundImage() {
    if (hour > 6 && hour < 18) {
      // Día
      return DecorationImage(
        image: AssetImage('Images/day.jpg'), 
        fit: BoxFit.cover,
      );
    } else if (hour > 19 && hour < 23 || hour < 5){
      // Noche
      return DecorationImage(
        image: AssetImage('Images/night.jpg'), 
        fit: BoxFit.cover,
      );
    }
      else {
      // Noche
      return DecorationImage(
        image: AssetImage('Images/sunset.jpg'), 
        fit: BoxFit.cover,
      );
    } 
  }

  Future<void> fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=18.4861&lon=-69.9312&appid=81aad83f4c9f2d58407131d0cdb0781b&units=metric'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        double temp = data['main']['temp'];
        _description = data['weather'][0]['description'];
        _iconCode = data['weather'][0]['icon'];
        _weather = 'Temperatura: ${temp.toStringAsFixed(1)}°C';
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: getBackgroundImage(), // Establecer la imagen de fondo
        ),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    Text(
                      _weather,
                      style: TextStyle(fontSize: 20,
                      color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _description,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    _iconCode.isNotEmpty
                        ? Image.network(
                            'http://openweathermap.org/img/wn/$_iconCode.png')
                        : Container(),
                  ],
                ),
        ),
      ),
    );
  }
}
