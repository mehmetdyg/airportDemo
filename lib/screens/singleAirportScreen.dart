import 'dart:convert';

import 'package:airport_app/models/airportIcaoModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:airport_app/models/airportmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

class SingleAirportClass extends StatefulWidget {
  const SingleAirportClass({required this.airport});

  final Item airport;

  @override
  _SingleAirportClassState createState() => _SingleAirportClassState();
}

class _SingleAirportClassState extends State<SingleAirportClass> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;
  late Future<List<AirportIcaoItem>> airportIcaoItemsFuture;

  final List<AirportIcaoItem> _icaoItemList = [];
  String? airportUrl;

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    "rapidapi-app": "default-application_5973306",
    "request-url": "rapidapi.com",
    "x-rapidapi-host": "aerodatabox.p.rapidapi.com",
    "x-rapidapi-key": "019a9c4b65mshf0c90d099ff6e4cp171530jsna3d2094d8af1",
  };

  Future<List<AirportIcaoItem>> getAirportIcaoItems() async {
    var dio = Dio();
    var options = Options();
    options.headers = _headers;

    String url =
        "https://aerodatabox.p.rapidapi.com/airports/icao/${widget.airport.icao}";

    Map<String, String> qParams = {
      'codeType': "icao",
      'code': widget.airport.icao!
    };
    var response =
        await dio.get(url, options: options, queryParameters: qParams);

    if (response.statusCode == 200) {
      var itemsJson = jsonDecode(json.encode(response.data));
      print(itemsJson['icao']);
      if (itemsJson['icao'].toString() == widget.airport.icao) {
        airportUrl = itemsJson['urls']['webSite'];
        _icaoItemList.add(AirportIcaoItem.fromJson(itemsJson));
      }
    } else {
      print("error while parsing json object");
    }

    return _icaoItemList;
  }

  _launchURL() async {
    if (await canLaunch(airportUrl!)) {
      await launch(airportUrl!);
    } else {
      throw 'Could not launch $airportUrl';
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
      final marker = Marker(
        onTap: _launchURL,
        markerId: MarkerId(widget.airport.name ?? "null"),
        position: LatLng(widget.airport.location!.lat ?? 0,
            widget.airport.location!.lon ?? 0),
        infoWindow: InfoWindow(
          title: airportUrl,
          snippet: widget.airport.shortName,
        ),
      );
      _markers[widget.airport.name ?? "null"] = marker;
    });
  }

  final LatLng _center =
      const LatLng(39.8651, 32.6475); // Yasamkent's coordinates.

  @override
  void initState() {
    airportIcaoItemsFuture = getAirportIcaoItems();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
