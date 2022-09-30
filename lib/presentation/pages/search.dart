import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../styles/colors.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class StationInformation {
  final String name, address;
  final int availableBikes, capacity;

  StationInformation(
      this.name, this.address, this.availableBikes, this.capacity);
}

class _SearchState extends State<Search> {
  bool availableBikeOnly = false;
  String searchString = "";

  Future getStationData() async {
    var response = await http.get(Uri.https(
        "api.jcdecaux.com", "/vls/v1/stations", {
      "contract": "Nantes",
      "apiKey": ""
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
      );
      stationInformations.add(stationInformation);
    }
    return stationInformations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child:
                  // Search Bar
                  TextField(
                onChanged: (value) {
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                },
                focusNode: FocusNode(canRequestFocus: false),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  labelText: "Recherche",
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
                  hintText: "Nom de station",
                ),
              ),
            ),
            Row(
              children: [
                Switch(
                  value: availableBikeOnly,
                  activeColor: AppColors.mainBlue,
                  onChanged: (bool value){
                    setState(() {
                      availableBikeOnly = value;
                    });
                  },
                ),
                const Text("Vélos disponibles uniquement."),
              ],
            ),
            Card(
              child: FutureBuilder(
                future: getStationData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text('Loading...'),
                    );
                  } else {
                    return Expanded(
                      child: SizedBox(
                        height: 620,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return snapshot.data![index].name
                                    .toLowerCase()
                                    .contains(searchString)
                                ? ListTile(
                                    leading: const Icon(Icons.pedal_bike),
                                    title: Text(snapshot.data![index].name),
                                    subtitle:
                                        Text(snapshot.data![index].address),
                                    trailing: Text(
                                        "${snapshot.data[index].availableBikes}/${snapshot.data[index].capacity} disponibles."),
                                  )
                                : Container();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return snapshot.data![index].name
                                    .toLowerCase()
                                    .contains(searchString)
                                ? const Divider()
                                : Container();
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
