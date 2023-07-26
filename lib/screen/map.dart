import 'package:app/db/database.dart';
import 'package:app/model/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late List<Location> locations;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    locations = await LocationDatabase.instance.readAllLocations();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // LocationDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Flexible(
              child: FlutterMap(
            options: MapOptions(
              center: const LatLng(19.0, -70.6667),
              zoom: 10.0,
            ),
          ))
        ],
      )),
    );
  }

  List<Marker> _buildMarkers() {
    return locations.map((location) {
      return Marker(
          point: LatLng(location.lat, location.lng),
          builder: (ctx) => const Icon(Icons.pin_drop));
    }).toList();
  }
}
