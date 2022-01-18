// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class Item {
  String? icao;
  String? iata;
  String? name;
  String? shortName;
  String? municipalityName;
  Location? location;
  String? countryCode;

  Item(
      {this.icao,
      this.iata,
      this.name,
      this.shortName,
      this.municipalityName,
      this.location,
      this.countryCode});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      icao: json['icao'],
      iata: json['iata'],
      name: json['name'],
      shortName: json['shortName'],
      municipalityName: json['municipalityName'],
      location: json['location'] != null
          ? new Location.fromJson(json['location'])
          : null,
      countryCode: json['countryCode']);
}

class Location {
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(lat: json['lat'], lon: json['lon']);
}
