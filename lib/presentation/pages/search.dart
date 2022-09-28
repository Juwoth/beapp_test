import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class StationInformation {
  final String name, address;
  final int availableBikes, capacity;

  //final double latitude, longitude;

  StationInformation(this.name,
      this.address,
      this.availableBikes,
      this.capacity,
      //this.latitude,
      //this.longitude,
      );
}

class _SearchState extends State<Search> {
  bool availableBikeOnly = false;

  Future getStationData() async {
    var response = await http.get(Uri.https(
        "api.jcdecaux.com", "/vls/v1/stations", {
      "contract": "Nantes",
      "apiKey": "45e674c06ed7a697fa6a3137149229a77f73e8fc"
    }));
    var utf8Response = Utf8Decoder().convert(response.bodyBytes);
    var jsonData = jsonDecode(utf8Response);
    List<StationInformation> stationInformations = [];

    for (var u in jsonData) {
      StationInformation stationInformation = StationInformation(
        u['name'],
        u['address'],
        u['available_bikes'],
        u['bike_stands'],
        //u['position'],
        //u['position']
      );
      stationInformations.add(stationInformation);
    }
    return stationInformations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            child: TextField(
              focusNode: FocusNode(canRequestFocus: false),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
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
                contentPadding: const EdgeInsets.all(12.0),
                hintText: "Recherche",
              ),
            ),
          ),
          Container(
            child: Card(
              child: FutureBuilder(
                future: getStationData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('Loading...'),
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        height: 620,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            if (availableBikeOnly =
                                true && snapshot.data[i].availableBikes > 15) {
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                child: ListTile(
                                  leading: Icon(Icons.bike_scooter),
                                  title: Text(snapshot.data[i].name),
                                  subtitle: Text(snapshot.data[i].address),
                                  trailing: Text(
                                      "${snapshot.data[i]
                                          .availableBikes}/${snapshot.data[i]
                                          .capacity} disponibles."),
                                ),
                              );
                            } else
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                child: ListTile(
                                  leading: Icon(Icons.bike_scooter),
                                  title: Text(snapshot.data[i].name),
                                  subtitle: Text(snapshot.data[i].address),
                                  trailing: Text(
                                      "${snapshot.data[i]
                                          .availableBikes}/${snapshot.data[i]
                                          .capacity} disponibles."),
                                ),
                              );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}