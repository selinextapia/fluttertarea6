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
      home: GenderPredictionScreen(),
    );
  }
}

class GenderPredictionScreen extends StatefulWidget {
  @override
  _GenderPredictionScreenState createState() => _GenderPredictionScreenState();
}

class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  TextEditingController _nameController = TextEditingController();
  String _gender = '';
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gender Prediction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                predictGender();
              },
              child: Text('Predict Gender'),
            ),
            SizedBox(height: 20),
            Text('Predicted Gender: $_gender'),
            SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              color: _backgroundColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> predictGender() async {
    String name = _nameController.text;
    String apiUrl = 'https://api.genderize.io/?name=$name';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _gender = data['gender'];
          _backgroundColor = (_gender.toLowerCase() == 'male') ? Colors.blue : Colors.pink;
        });
      } else {
        throw Exception('Failed to predict gender');
      }
    } catch (error) {
      print('Error predicting gender: $error');
      setState(() {
        _gender = 'Error';
      });
    }
  }
}
