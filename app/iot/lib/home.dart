import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iot/model/dhtModel.dart';
import 'package:http/http.dart' as http;
import 'package:iot/model/pulseModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Timer _timer;
  late Future<DhtModel> dhtModel;
  late Future<PulseModel> pulseModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3
    ), (timer) {
      setState(() {
        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (context) => Home()),
        //         (route) => false);
        dhtModel = fetchDhtData();
        pulseModel = fetchPulseData();
      });
    });
    dhtModel = fetchDhtData();
    pulseModel = fetchPulseData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: dhtModel,
              builder: (context, snapshot1) {
                if (snapshot1.hasData) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,

                            ),
                          )
                          ,child: Padding(
                            padding: const EdgeInsets.all(8.0),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [
                                Text(
                                  "Temperature",
                                    style: TextStyle(color: Colors.yellow,
                                    fontSize: 15,
                                    decoration: TextDecoration.none)
                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                          height: 50
                                          ,child: (snapshot1.data!.temperature > 20)?
                                      Image(image: AssetImage('assets/hot.png'), fit: BoxFit.cover,) :
                                      Image(image: AssetImage('assets/cold.png'), fit: BoxFit.cover,)
                                      ),

                                      Text("${snapshot1.data!.temperature}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            fontSize: 45,
                                            decoration: TextDecoration.none
                                          )
                                      )
                                    ],
                                  ),
                                        ],
                            ),
                          ),
                        ),



                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white
                          )
                        )
                        ,child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Text(
                                "Humidity",
                                style: TextStyle(color: Colors.yellow,
                                    fontSize: 15,
                                    decoration: TextDecoration.none)
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                    height: 50
                                    ,child: Image(image: AssetImage('assets/hum.png'), fit: BoxFit.cover,)
                                ),

                                Text("${snapshot1.data!.humidity}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 45,
                                        decoration: TextDecoration.none
                                    )
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      ]
                    )
                  );



                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 30,),
            FutureBuilder(
              future: pulseModel,
              builder: (context, snapshot2) {
                if (snapshot2.hasData) {
                  return Container(
                    width: 110,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Text(
                            "BPM",
                            style: TextStyle(color: Colors.yellow,
                                fontSize: 15,
                                decoration: TextDecoration.none)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                                height: 50
                                ,child: Image(image: AssetImage('assets/bpm.png'), fit: BoxFit.cover,)
                            ),

                            Text("${snapshot2.data!.bpm}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 45,
                                    decoration: TextDecoration.none
                                )
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      );

  }
}


Future<DhtModel> fetchDhtData() async {
  final response = await http
      .get(Uri.parse("http://192.168.42.211:6969/dht/get"));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DhtModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<PulseModel> fetchPulseData() async {
  final response = await http
      .get(Uri.parse("http://192.168.42.211:6969/pulse/get"));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PulseModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}