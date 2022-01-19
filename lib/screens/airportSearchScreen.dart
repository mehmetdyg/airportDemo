// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'package:airport_app/screens/airportListScreen.dart';
import 'package:flutter/material.dart';

class AirPortPage extends StatefulWidget {
  const AirPortPage({Key? key}) : super(key: key);

  @override
  State<AirPortPage> createState() => _AirPortPageState();
}

class _AirPortPageState extends State<AirPortPage> {
  final airportController = TextEditingController();

  static const airportLengthSnackBar = SnackBar(
    content: Text('Please provide at least 3 characters...'),
  );

  @override
  Widget build(BuildContext context) {
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
                controller: airportController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.flight),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (airportController.text.length < 3) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(airportLengthSnackBar);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AirportList(
                                  searchedAirport: airportController.text)),
                        );
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
