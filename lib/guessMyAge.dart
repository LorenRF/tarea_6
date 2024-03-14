import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class guessMyAgeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return guessMyAge();
  }
}

class guessMyAge extends StatefulWidget {
  @override
  _guessMyAgeState createState() => _guessMyAgeState();
}

class _guessMyAgeState extends State<guessMyAge> {
  TextEditingController _nameController = TextEditingController();
  int _age = 0;
  String _ageGroup = '';
  bool _isLoading = false;

  Future<void> predictAge(String name) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _age = data['age'];
        _isLoading = false;
        _classifyAge();
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  void _classifyAge() {
    if (_age >= 0 && _age <= 3) {
      _ageGroup = 'Bebé';
    } else if (_age >= 4 && _age <= 11) {
      _ageGroup = 'Niño';
    } else if (_age >= 12 && _age <= 14) {
      _ageGroup = 'Preadolecente';
    } else if (_age >= 15 && _age <= 19) {
      _ageGroup = 'Adolecente';
      } else if (_age >= 20 && _age <= 29) {
      _ageGroup = 'Joven adulto';
    } else if (_age >= 30 && _age <= 45) {
      _ageGroup = 'Adulto';
    
    } else if (_age >= 46 && _age <= 59) {
      _ageGroup = 'Adulto mayor';
      
    }else if (_age > 59) {
       _ageGroup = 'Anciano';
      
    }else {
      _ageGroup = 'Bebé';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aberigua que edad tienes segun tu nombre!!!'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Ingresa tu nombre',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                predictAge(_nameController.text);
              },
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20),
            _age != null
                ? Column(
              children: [
                Text(
                  'Edad: $_age años',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  'Grupo de Edad: $_ageGroup',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Image.asset(
                  _getImagePath(),
                  width: 150,
                  height: 150,
                ),
              ],
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  String _getImagePath() {
    if (_ageGroup == 'Baby') {
      return 'Images/baby.jpg';
    } else if (_ageGroup == 'Niño') {
      return 'Images/kid.jpg';
    }else if (_ageGroup == 'Preadolecente') {
      return 'Images/Pre_teen.jpg';
    }else if (_ageGroup == 'Adolecente') {
      return 'Images/teen.png';
    }else if (_ageGroup == 'Joven adulto') {
      return 'Images/adult.png';
    }else if (_ageGroup == 'Adulto') {
      return 'Images/3th_age.png';
    } else if (_ageGroup == 'Adulto mayor') {
      return 'Images/oldadult.png';
    } else {
      return 'Images/old.png';
    }
  }
}
