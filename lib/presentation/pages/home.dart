import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
                center: LatLng(47.2070626, -1.5588555),
                zoom: 9.2,
                interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                maxBounds: LatLngBounds(
                  LatLng(51.3588166, -5.5522604),
                  LatLng(40.1290318, 11.8739863),
                )
            ),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: "OpenStreetMap contributors",
                onSourceTapped: null,
              ),
            ],
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.beapp.beapp_exercice',
              ),
            ],
          ),
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
