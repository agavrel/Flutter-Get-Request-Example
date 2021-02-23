# get_request

Flutter app showcasing how to do a get request

## Dependencies

```
http: ^0.12.2
```

## Create the class that will get your json data

```flutter
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
```

## GET function

```flutter
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
```

## FutureBuilder

```
import 'dart:convert'; // for json.decode
import 'package:http/http.dart' as http; // for get request

// main etc

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
```