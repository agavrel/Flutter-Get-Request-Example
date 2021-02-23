import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GET request Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'GET request Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
MyHomePage({Key key, this.title}) : super(key: key);

final String title;

@override
_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:  FutureBuilder<Country>(
        future: getCountryByName("colombia"),
        builder: (context, AsyncSnapshot<Country> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Text(snapshot.data.toString());
          }
          else
            return CircularProgressIndicator();
    })

      ),
    );
  }
}



class Country {
  final String name;
  final String capital;
  final String region;

  Country({this.name, this.capital, this.region});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      capital: json['capital'],
      region: json['region'],
    );
  }

  @override
  String toString() {
    return 'Country{name: $name, capital: $capital, region: $region)';
  }


}


Future<Country> getCountryByName  (String name) async {
  Country country;
  try {
    final url = 'https://restcountries.eu/rest/v2/name/$name';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);

      country = Country.fromJson(json.decode(response.body)[0]);
    }
    else
      print("error: ${response.statusCode}");
  }
  catch (e) {
    print(e);
  }
    print(country.toString());
    return country;
}
