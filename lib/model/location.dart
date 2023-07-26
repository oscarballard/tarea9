const String tableLocations = 'Location';

class LocationField {
  static final List<String> values = [id, title, lng, lat];

  static const String id = "_id";
  static const String title = "_title";
  static const String lng = "_lng";
  static const String lat = "_lat";
}

class Location {
  final int? id;
  final String title;
  final double lng;
  final double lat;

  const Location(
      {this.id, required this.title, required this.lng, required this.lat});

  Location copy({
    int? id,
    String? title,
    double? lng,
    double? lat,
  }) =>
      Location(
          id: id ?? this.id,
          title: title ?? this.title,
          lng: lng ?? this.lng,
          lat: lat ?? this.lat);

  static Location fromJson(Map<String, Object?> json) => Location(
      id: json[LocationField.id] as int?,
      title: json[LocationField.title] as String,
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      lng: double.tryParse(json['lng'].toString()) ?? 0.0);

  Map<String, Object?> toJson() => {
        LocationField.id: id,
        LocationField.title: title,
        LocationField.lng: lng,
        LocationField.lat: lat
      };
}
