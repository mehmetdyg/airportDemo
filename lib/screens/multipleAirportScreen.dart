import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:airport_app/models/airportmodel.dart';

class MultipleAirportClass extends StatefulWidget {
  const MultipleAirportClass({required this.airportList});

  final List<Item> airportList;

  @override
  _MultipleAirportClassState createState() => _MultipleAirportClassState();
}

class _MultipleAirportClassState extends State<MultipleAirportClass> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
      for (final airport in widget.airportList) {
        final marker = Marker(
          markerId: MarkerId(airport.name ?? "null"),
          position:
              LatLng(airport.location!.lat ?? 0, airport.location!.lon ?? 0),
          infoWindow: InfoWindow(
            title: airport.name,
            snippet: airport.shortName,
          ),
        );
        _markers[airport.name ?? "null"] = marker;
      }
    });
  }

  final LatLng _center =
      const LatLng(39.8651, 32.6475); // Yasamkent's coordinates.

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
