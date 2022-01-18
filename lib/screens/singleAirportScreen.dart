import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:airport_app/models/airportmodel.dart';

class SingleAirportClass extends StatefulWidget {
  const SingleAirportClass({required this.airport});

  final Item airport;

  @override
  _SingleAirportClassState createState() => _SingleAirportClassState();
}

class _SingleAirportClassState extends State<SingleAirportClass> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(widget.airport.name ?? "null"),
        position: LatLng(widget.airport.location!.lat ?? 0,
            widget.airport.location!.lon ?? 0),
        infoWindow: InfoWindow(
          title: widget.airport.name,
          snippet: widget.airport.shortName,
        ),
      );
      _markers[widget.airport.name ?? "null"] = marker;
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
