// ignore_for_file: prefer_const_constructors

import 'package:airport_app/screens/singleAirportScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/airportprovider.dart';
import 'multipleAirportScreen.dart';

class AirportList extends StatefulWidget {
  const AirportList({Key? key}) : super(key: key);

  @override
  State<AirportList> createState() => _AirportListState();
}

class _AirportListState extends State<AirportList> {
  @override
  Widget build(BuildContext context) {
    final airportData = Provider.of<AirportProvider>(context);
    var airportList = airportData.items;
    return Scaffold(
      body: airportData.isComplete
          ? Container(
              padding: EdgeInsets.only(top: 25),
              child: airportList.length > 0
                  ? ListView.builder(
                      itemCount: airportList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingleAirportClass(
                                            airport: airportList[index],
                                          )));
                            },
                            leading: Icon(Icons.flight),
                            trailing: Text(
                              airportList[index].name.toString(),
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            subtitle: Text("Icao Code: " +
                                airportList[index].icao.toString()),
                            title:
                                Text(airportList[index].shortName.toString()));
                      })
                  : ListTile(
                      title: Center(child: Text("No Airports Found")),
                    ),
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("See All Airports"),
        tooltip: 'See on Google Maps',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultipleAirportClass(
                        airportList: airportList,
                      )));
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.local_airport_sharp),
      ),
    );
  }
}
