import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rmts_brts/bus.dart';

class DetailBus extends StatefulWidget {
  const DetailBus({
    Key? key,
    required this.bus_no,
  }) : super(key: key);
  final bus_no;

  @override
  State<DetailBus> createState() => _DetailBusState();
}

class _DetailBusState extends State<DetailBus> {
  late Future<List<Bus>> futureBus;
  int busfoundcount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // futureBus = fetchBus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(widget.bus_no.toString()),
            FutureBuilder<List<Bus>>(
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
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget SingleBus(Bus b) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      height: 200,
      child: Column(
        children: [
          //Maps
          Stack(
            children: [
              Container(
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
                      b.A_BusNo;
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

  List<Bus> buses = [];

  Future<List<Bus>> fetchBus() async {
    buses.clear();
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
          if (d_bus['A_BusNo'] == int.parse(widget.bus_no.toString())) {
            busfoundcount++;
            buses.add(Bus.fromJSON(d_bus));
          }
        }
        // d_bus['A_BusNo'] = int.parse(d_bus['VehName'].toString().substring(d_bus['VehName'].toString().length-2,d_bus['VehName'].toString().length));
        /*if (d_bus['A_BusNo'] == int.parse(widget.bus_no.toString())) {
            busfoundcount++;
            buses.add(Bus.fromJSON(d_bus));
          }*/
        // }
      }
      return buses;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}
