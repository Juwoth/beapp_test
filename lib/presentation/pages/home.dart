import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

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
  Future getMarkersData() async {
    var response = await http.get(Uri.https(
        "api.jcdecaux.com", "/vls/v1/stations", {
      "contract": "Nantes",
      "apiKey": ""
    }));
    var jsonData = jsonDecode(response.body);
    List<MarkersInformations> markersInformations = [];
    for (var m in jsonData) {
      MarkersInformations markersInformation = MarkersInformations(
        m['position'],
        m['available_bikes'],
        m['bike_stands'],
      );
      markersInformations.add(markersInformation);
    }
    return markersInformations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              child: Card(
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
                        center: LatLng(47.2070626, -1.5588555),
                        zoom: 9.2,
                        interactiveFlags:
                            InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                        maxBounds: LatLngBounds(
                          LatLng(51.3588166, -5.5522604),
                          LatLng(40.1290318, 11.8739863),
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
                        markers: [
                          Marker(
                            point: LatLng(47, -1),
                            builder: (context) => const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          )),
          Container(
            padding: const EdgeInsets.all(12),
            child: TextField(
              focusNode: FocusNode(canRequestFocus: false),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xAAFFFFFF),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: const InkWell(
                  child: Icon(Icons.search),
                ),
                contentPadding: const EdgeInsets.fromLTRB(25, 6, 0, 6),
                hintText: "Point de départ",
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 65, 12, 12),
            child: TextField(
              focusNode: FocusNode(canRequestFocus: false),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xAAFFFFFF),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                suffixIcon: const InkWell(
                  child: Icon(Icons.search),
                ),
                contentPadding: const EdgeInsets.fromLTRB(25, 6, 0, 6),
                hintText: "Point d'arrivée",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
