// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class AirportIcaoItem {
  String? icao;
  String? iata;
  String? shortName;
  String? fullName;
  String? municipalityName;
  Location? location;
  Country? country;
  Continent? continent;
  String? timeZone;
  Urls? urls;

  AirportIcaoItem(
      {this.icao,
      this.iata,
      this.shortName,
      this.fullName,
      this.municipalityName,
      this.location,
      this.country,
      this.continent,
      this.timeZone,
      this.urls});

  factory AirportIcaoItem.fromJson(Map<String, dynamic> json) =>
      AirportIcaoItem(
        icao: json['icao'],
        iata: json['iata'],
        shortName: json['shortName'],
        fullName: json['fullName'],
        municipalityName: json['municipalityName'],
        location: json['location'] != null
            ? new Location.fromJson(json['location'])
            : null,
        country: json['country'] != null
            ? new Country.fromJson(json['country'])
            : null,
        continent: json['continent'] != null
            ? new Continent.fromJson(json['continent'])
            : null,
        timeZone: json['timeZone'],
        urls: json['urls'] != null ? new Urls.fromJson(json['urls']) : null,
      );
}

class Location {
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(lat: json['lat'], lon: json['lon']);
}

class Country {
  String? code;
  String? name;

  Country({this.code, this.name});

  factory Country.fromJson(Map<String, dynamic> json) =>
      Country(code: json['code'], name: json['name']);
}

class Continent {
  String? code;
  String? name;

  Continent({this.code, this.name});

  factory Continent.fromJson(Map<String, dynamic> json) =>
      Continent(code: json['code'], name: json['name']);
}

class Urls {
  String? webSite;
  String? wikipedia;
  String? twitter;
  String? googleMaps;
  String? flightRadar;

  Urls(
      {this.webSite,
      this.wikipedia,
      this.twitter,
      this.googleMaps,
      this.flightRadar});

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
      webSite: json['webSite'],
      wikipedia: json['wikipedia'],
      twitter: json['twitter'],
      googleMaps: json['googleMaps'],
      flightRadar: json['flightRadar']);
}
