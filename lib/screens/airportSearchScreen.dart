// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';

import 'package:airport_app/screens/airportListScreen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/airportmodel.dart';
import 'package:provider/provider.dart';
import '../providers/airportprovider.dart';

class AirPortPage extends StatefulWidget {
  const AirPortPage({Key? key}) : super(key: key);

  @override
  State<AirPortPage> createState() => _AirPortPageState();
}

class _AirPortPageState extends State<AirPortPage> {
  final airportController = TextEditingController();
  List<Item> items = [];

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    "rapidapi-app": "default-application_5973306",
    "request-url": "rapidapi.com",
    "x-rapidapi-host": "aerodatabox.p.rapidapi.com",
    "x-rapidapi-key": "019a9c4b65mshf0c90d099ff6e4cp171530jsna3d2094d8af1",
  };

  static const airportLengthSnackBar = SnackBar(
    content: Text('Please provide at least 3 characters...'),
  );

  @override
  Widget build(BuildContext context) {
    final airportData = Provider.of<AirportProvider>(context);
    Future<void> _updateAirportState() async {
      var dio = Dio();
      var options = Options();
      options.headers = _headers;
      String url = "https://aerodatabox.p.rapidapi.com/airports/search/term";
      Map<String, String> qParams = {
        'q': airportController.text,
      };
      var response =
          await dio.get(url, options: options, queryParameters: qParams);

      if (response.statusCode == 200) {
        var itemsJson = jsonDecode(json.encode(response.data));
        for (var item in itemsJson['items']) {
          items.add(Item.fromJson(item));
        }
      } else {
        print("error while parsing json object");
      }

      airportData.updateItems(items);
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width / 1.2,
              child: TextField(
                onSubmitted: (_) {
                  _updateAirportState();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AirportList()),
                  ).then((_) {
                    airportData.isComplete = false;
                    airportController.clear();
                    items.clear();
                  });
                },
                controller: airportController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.flight),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (airportController.text.length < 3) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(airportLengthSnackBar);
                      } else {
                        _updateAirportState();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AirportList()),
                        ).then((_) {
                          airportData.isComplete = false;
                          airportController.clear();
                          items.clear();
                        });
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Search Airports',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
