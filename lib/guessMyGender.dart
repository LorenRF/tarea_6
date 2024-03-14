import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class guessMyGender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GenderPredictor();
  }
}

class GenderPredictor extends StatefulWidget {
  @override
  _GenderPredictorState createState() => _GenderPredictorState();
}

class _GenderPredictorState extends State<GenderPredictor> {
  TextEditingController _nameController = TextEditingController();
  String _gender = '';
  bool _isLoading = false;

  Future<void> predictGender(String name) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _gender = data['gender'];
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gender Predictor'),
      ),
      body: SingleChildScrollView( // Envuelve el Column con SingleChildScrollView
        child: Center(
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
                    labelText: 'Enter your name',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  predictGender(_nameController.text);
                },
                child: Text('Adivinar el genero'),
              ),
              SizedBox(height: 20),
              _gender.length > 0
                  ? Text(
                'Predicted Gender: $_gender',
                style: TextStyle(fontSize: 20),
              )
                  : Container(),
              SizedBox(height: 20),
              _gender.length > 0
                  ? Image.asset(
                  _gender == 'male' ? 'Images/itsaboy.png' : 'Images/itsagirl.png',
                  width: 200,
                  height: 200,
              )
              
                  : Image.asset(
                  'Images/bog.png',
                  width: 200,
                  height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
