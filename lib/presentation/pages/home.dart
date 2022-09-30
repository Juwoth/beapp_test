import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../widgets/molecules/searchbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class MarkersInformations {
  final position;
  final int availableBikes, capacity;

  MarkersInformations(
    this.position,
    this.availableBikes,
    this.capacity,
  );
}

class HomeState extends State<Home> {
  List<Marker> markersList = [];

  Future getMarkersData() async {
    var response = await http.get(Uri.https(
        "api.jcdecaux.com", "/vls/v1/stations", {
      "contract": "Nantes",
      "apiKey": "45e674c06ed7a697fa6a3137149229a77f73e8fc"
    }));
    var jsonData = jsonDecode(response.body);
    List<MarkersInformations> markersInformations = [];
    for (var marker in jsonData) {
      MarkersInformations markersInformation = MarkersInformations(
        marker['position'],
        marker['available_bikes'],
        marker['bike_stands'],
      );
      // Create a list of markers to display on the map
      markersInformations.add(markersInformation);
      markersList.add(
        Marker(
          point: LatLng(marker['position']['lat'], marker['position']['lng']),
          builder: (context) => const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 20,
          ),
        ),
      );
    }

    return markersInformations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Card(
            child: FutureBuilder(
          future: getMarkersData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("Loading..."),
              );
            } else {
              return FlutterMap(
                options: MapOptions(
                    // Focus the map on the center of Nantes
                    center: LatLng(47.2156281, -1.5524987),
                    zoom: 14,
                    // Enable only the pinch zoom and drag
                    interactiveFlags:
                        InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    // Set the boundaries to Nantes only
                    maxBounds: LatLngBounds(
                      LatLng(47.301540, -1.621354),
                      LatLng(47.171137, -1.471111),
                    )),
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: "OpenStreetMap contributors",
                    onSourceTapped: null,
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.beapp.beapp_exercice',
                  ),
                  MarkerLayer(
                    markers: markersList,
                  ),
                ],
              );
            }
          },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Searchbar(hintText: "Point de départ"),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 65, 12, 12),
            child: Searchbar(hintText: "Point d'arrivée"),
          ),
        ],
      ),
    );
  }
}


