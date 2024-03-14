import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WordPressNewsScreen(),
    );
  }
}

class WordPressNewsScreen extends StatefulWidget {
  @override
  _WordPressNewsScreenState createState() => _WordPressNewsScreenState();
}

class _WordPressNewsScreenState extends State<WordPressNewsScreen> {
  List<NewsItem> _newsList = [];

  @override
  void initState() {
    super.initState();
    fetchWordPressNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPress News'),
      ),
      body: ListView.builder(
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_newsList[index].title),
            subtitle: Text(_newsList[index].summary),
            leading: Image.network(_newsList[index].logoUrl),
            onTap: () {},
          );
        },
      ),
    );
  }

  Future<void> fetchWordPressNews() async {
    String apiUrl = 'https://underc0de.org/foro/';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<NewsItem> newsItems = [];
        for (var item in data) {
          NewsItem newsItem = NewsItem(
            title: item['title']['rendered'],
            summary: item['excerpt']['rendered'],
            logoUrl: 'URL_DE_LA_IMAGEN_DEL_LOGO',
          );
          newsItems.add(newsItem);
        }
        setState(() {
          _newsList = newsItems;
        });
      } else {
        throw Exception('Failed to fetch WordPress news');
      }
    } catch (error) {
      print('Error fetching WordPress news: $error');
    }
  }
}

class NewsItem {
  final String title;
  final String summary;
  final String logoUrl;

  NewsItem({
    required this.title,
    required this.summary,
    required this.logoUrl,
  });
}
