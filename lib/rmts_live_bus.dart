import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rmts_brts/Model/rmts_live_bus_model.dart';

class RmtsLiveBus extends StatefulWidget {
  const RmtsLiveBus({super.key});

  @override
  State<RmtsLiveBus> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RmtsLiveBus> {
  TextEditingController textEditingController = TextEditingController();
  late Future<List<RmtsLiveBusModel>> futureBus;
  int busfoundcount = 0;
  int bus_no = -1;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      flex: 70,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                        child: TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 217, 217, 217),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 185, 185, 185),
                                  width: 1.0),
                            ),
                            hintText: "Enter Bus no.",
                          ),
                          keyboardType: TextInputType.number,
                          controller: textEditingController,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                        ),
                        onPressed: () {
                          // if(!isLoading){
                            setState(() {
                              bus_no = int.parse(textEditingController.text.toString());
                              buses;
                              // fetchBus();
                            });
                          // }
                        },
                        child: Text("Search"),
                      ),
                    ),
                  ],
                ),

                if (bus_no != -1)
                  FutureBuilder<List<RmtsLiveBusModel>>(
                    future: fetchBus(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data?.length != 0) {
                        return Column(
                          children: [
                            Text(buses.length.toString()),
                            ListView.builder(
                              itemBuilder: (context, index) {
                                return SingleBus(buses[index]);
                              },
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data?.length,
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }else if(!isLoading && busfoundcount==0){
                        return Text("no buses found.");
                      }
                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SingleBus(RmtsLiveBusModel b) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      height: 200,
      child: Column(
        children: [
          //Maps
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                    "https://maps.rmtsbus.in/?lat=" +
                        b.Latitude +
                        "&lon=" +
                        b.Longitude,
                    fit: BoxFit.fill),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      MapsLauncher.launchCoordinates(
                          double.parse(b.Latitude), double.parse(b.Longitude));
                    },
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(top: 15, left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.fromLTRB(8, 10, 4, 10),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/icon_google_maps.png',
                            width: 16,
                            fit: BoxFit.fitWidth,
                          ),
                          Text('  Maps',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      setState(() {
                        b.A_BusNo;
                        bus_no;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: Text('Refresh'),
                    ),
                  )
                ],
              ),
            ],
          ),
          Text(b.A_BusNo.toString()),
        ],
      ),
    );
  }

  List<RmtsLiveBusModel> buses = [];

  Future<List<RmtsLiveBusModel>> fetchBus() async {
    isLoading=true;
    buses.clear();
    busfoundcount=0;
    final response = await http
        .get(Uri.parse('http://www.rajkotrajpath.com/get_location.php'));
    if (response.statusCode == 200) {
      List<dynamic> d_buses = List.from(jsonDecode(response.body));

      for (var d_bus in d_buses) {
        if (d_bus['VehName']
            .toString()
            .toLowerCase()
            .contains("Route No".toLowerCase())) {
          var temp = "Route No ".toLowerCase().length;
          d_bus['A_BusNo'] = int.parse(d_bus['VehName'].toString().substring(
              d_bus['VehName']
                      .toString()
                      .toLowerCase()
                      .indexOf("Route No".toLowerCase()) +
                  temp,
              d_bus['VehName']
                      .toString()
                      .toLowerCase()
                      .indexOf("Route No".toLowerCase()) +
                  temp +
                  2));
          print(d_bus['A_BusNo']);
          if (d_bus['A_BusNo'] == int.parse(bus_no.toString())) {
            busfoundcount++;
            buses.add(RmtsLiveBusModel.fromJSON(d_bus));
          }
        }
      }

      print(buses.length);
      isLoading=false;
      return buses;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}