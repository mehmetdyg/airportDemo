// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:airport_app/models/airportmodel.dart';
import 'package:airport_app/screens/singleAirportScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'multipleAirportScreen.dart';

class AirportList extends StatefulWidget {
  const AirportList({required this.searchedAirport, Key? key})
      : super(key: key);

  final String searchedAirport;
  @override
  State<AirportList> createState() => _AirportListState();
}

class _AirportListState extends State<AirportList> {
  List<Item> _items = [];

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    "rapidapi-app": "default-application_5973306",
    "request-url": "rapidapi.com",
    "x-rapidapi-host": "aerodatabox.p.rapidapi.com",
    "x-rapidapi-key": "019a9c4b65mshf0c90d099ff6e4cp171530jsna3d2094d8af1",
  };

  @override
  void initState() {
    super.initState();
  }

  Future<List<Item>> _updateAirportState(BuildContext context) async {
    var dio = Dio();
    var options = Options();
    options.headers = _headers;
    String url = "https://aerodatabox.p.rapidapi.com/airports/search/term";
    Map<String, String> qParams = {
      'q': widget.searchedAirport,
    };
    _items.clear();
    var response =
        await dio.get(url, options: options, queryParameters: qParams);

    if (response.statusCode == 200) {
      var itemsJson = jsonDecode(json.encode(response.data));
      for (var item in itemsJson['items']) {
        _items.add(Item.fromJson(item));
      }
    } else {
      print("error while parsing json object");
    }

    return _items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 20,
          ),
          Expanded(
            child: FutureBuilder<List<Item>>(
              future: _updateAirportState(context),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error parsing the airport data'),
                      );
                    } else {
                      if (snapshot.data!.isEmpty)
                        return Center(child: Text('No airport found'));
                      else {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final apItems = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SingleAirportClass(
                                              airport: apItems,
                                            )));
                              },
                              title: Text(
                                apItems.name.toString(),
                              ),
                              leading: Icon(Icons.flight),
                              trailing: Text(
                                apItems.name.toString(),
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15),
                              ),
                              subtitle:
                                  Text("Icao Code: " + apItems.icao.toString()),
                            );
                          },
                        );
                      }
                    }
                  default:
                    return Center(child: Text("Default value"));
                }
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultipleAirportClass(
                              airportList: _items,
                            )));
              },
              child: Text(
                "See All Locations",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )),
        ],
      ),
    );
  }
}
