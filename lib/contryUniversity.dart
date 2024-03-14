import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class contryUniversity extends StatefulWidget {
  @override
  _contryUniversityState createState() => _contryUniversityState();
}

class _contryUniversityState extends State<contryUniversity> {
  TextEditingController _countryController = TextEditingController();
  List<University> _universities = [];
  bool _isLoading = false;

  Future<void> searchUniversities(String country) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      setState(() {
        _universities = data.map((e) => University.fromJson(e)).toList();
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
        title: Text('University Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'Enter country name in English',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                searchUniversities(_countryController.text);
              },
              child: Text('Search Universities'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _universities.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_universities[index].name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Domain: ${_universities[index].domain}'),
                              TextButton(
                                onPressed: () {
                                  // Open university website in browser
                                },
                                child: Text('Website: ${_universities[index].webPage}'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class University {
  final String name;
  final String domain;
  final String webPage;

  University({
    required this.name,
    required this.domain,
    required this.webPage,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? '',
      domain: json['domains'].isNotEmpty ? json['domains'][0] : '',
      webPage: json['web_pages'].isNotEmpty ? json['web_pages'][0] : '',
    );
  }
}

