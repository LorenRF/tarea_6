import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Wordpress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WordPressNews();
  }
}

class WordPressNews extends StatefulWidget {
  @override
  _WordPressNewsState createState() => _WordPressNewsState();
}

class _WordPressNewsState extends State<WordPressNews> {
  List<Article> _articles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://aeropuertolasamericas.com/wp-json/wp/v2/posts?per_page=3'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _articles = data.take(3).map((articleJson) => Article.fromJson(articleJson)).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aeropuerto las americas'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            _articles[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(_articles[index].excerpt),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${_articles[index].date}'),
                              Text('Link: ${_articles[index].link}'),
                              Image.asset(
              'Images/logo.png',
              width: 300,
              height: 180,
            ), 
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class Article {
  final String title;
  final String excerpt;
  final String date;
  final String link;

  Article({
    required this.title,
    required this.excerpt,
    required this.date,
    required this.link,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      date: json['date'],
      link: json['link'],
    );
  }
}
