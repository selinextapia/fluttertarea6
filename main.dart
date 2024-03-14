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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = '';
  String gender = '';
  int age = 0;
  String country = '';
  List<dynamic> universities = [];
  String weather = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toolbox App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Widget para mostrar la foto de la caja de herramientas
            // Agrega aquí el widget para mostrar la imagen de la caja de herramientas

            SizedBox(height: 20),

            // Widget para aceptar el nombre de la persona y predecir el género
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Ingrese su nombre',
                labelText: 'Nombre',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                fetchGender();
              },
              child: Text('Predecir Género'),
            ),
            Text('Género: $gender'),

            SizedBox(height: 20),

            // Widget para determinar la edad de la persona
            ElevatedButton(
              onPressed: () {
                fetchAge();
              },
              child: Text('Determinar Edad'),
            ),
            Text('Edad: $age'),

            SizedBox(height: 20),

            // Widget para mostrar el clima en RD
            ElevatedButton(
              onPressed: () {
                fetchWeather();
              },
              child: Text('Ver Clima en RD'),
            ),
            Text('Clima en RD: $weather'),

            SizedBox(height: 20),

            // Widget para mostrar las universidades de un país
            TextField(
              onChanged: (value) {
                setState(() {
                  country = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Ingrese el nombre del país',
                labelText: 'País',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                fetchUniversities();
              },
              child: Text('Buscar Universidades'),
            ),
            Column(
              children: universities.map((uni) {
                return ListTile(
                  title: Text(uni['name']),
                  subtitle: Text(uni['country']),
                  trailing: IconButton(
                    icon: Icon(Icons.open_in_browser),
                    onPressed: () {},
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> fetchGender() async {
    final response =
        await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    final jsonData = json.decode(response.body);
    setState(() {
      gender = jsonData['gender'];
    });
  }

  Future<void> fetchAge() async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    final jsonData = json.decode(response.body);
    setState(() {
      age = jsonData['age'];
    });
  }

  Future<void> fetchUniversities() async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    final jsonData = json.decode(response.body);
    setState(() {
      universities = jsonData;
    });
  }

  Future<void> fetchWeather() async {}
}
