import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

class PatientList {
  final List<Patients> patients;

  PatientList({
    required this.patients,
  }); 

  factory PatientList.fromJson(List<dynamic> parsedJson) {
    List<Patients> patients = [];
    patients = parsedJson.map((i) => Patients.fromJson(i)).toList();

    return PatientList(patients: patients);
  }
}

class Patients {
  final String firstName;
  final String lastName;
  final String bookingDate;
  final String bookingTime;

  Patients(
      {required this.firstName,
      required this.lastName,
      required this.bookingDate,
      required this.bookingTime});

  factory Patients.fromJson(Map<String, dynamic> json) {
    return Patients(
      firstName: json['FirstName'],
      lastName: json['LastName'],
      bookingDate: json['BookingDate'],
      bookingTime: json['BookingTime'],
    );
  }
}

Future<PatientList> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'http://192.168.0.121:9010/api/getappoinmentlistbydoc/DC5170200'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var doclist = PatientList.fromJson(jsonDecode(response.body));

    return PatientList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main() {
  runApp(const PatientListScreen());
}

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  late Future<PatientList> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<PatientList>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.patients.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: Colors.teal[100],
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                    children: [

                                      const Text("Patient Name:", style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),),
                                      Row(
                                          mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        
                                        children: [
                                       Text(
                                                  "${snapshot.data!.patients[index].firstName} ${snapshot.data!.patients[index].lastName}",
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),



                                      ],),
                                    ],
                                  ),
                                 const SizedBox(height: 10),
                                   Row(
                                      mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                    children: [

                                      const Text("Booking Date:", style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),),
                                      Row(
                                          mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        
                                        children: [
                                       Text(
                                                  snapshot.data!.patients[index].bookingDate,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),



                                      ],),
                                    ],
                                  ),
                                 const SizedBox(height: 10),

                                    Row(
                                      mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                    children: [

                                      const Text("Booking Time:", style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),),
                                      Row(
                                          mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        
                                        children: [
                                       Text(
                                                  snapshot.data!.patients[index].bookingTime,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),



                                      ],),
                                    ],
                                  ),
                                 const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          onPressed: () {



                                          },
                                          child: const Text(
                                            "Accept",
                                            style: TextStyle(
                                                color: Colors.brown,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text("Waiting",
                                              style: TextStyle(
                                                  color: Colors.brown,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold))),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text("Reject",
                                              style: TextStyle(
                                                  color: Colors.brown,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)))
                                    ],
                                  )



                                
                                  //String Interpolation

                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         const Text(
                                  //           "Patient Name:",
                                  //           style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 15),
                                  //         ),
                                  //         //String Interpolation
                                  //         Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: Text(
                                  //             "${snapshot.data!.patients[index].firstName} ${snapshot.data!.patients[index].lastName}",
                                  //             style: const TextStyle(
                                  //                 color: Colors.deepPurple,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 fontSize: 15),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         const Text(
                                  //           "Booking Date:",
                                  //           style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 15),
                                  //         ),
                                  //         //String Interpolation
                                  //         Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: Text(
                                  //             "${snapshot.data!.patients[index].bookingDate} ",
                                  //             style: const TextStyle(
                                  //                 color: Colors.deepPurple,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 fontSize: 15),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Row(
                                  //       children: [
                                  //         const Text(
                                  //           "Booking Time:",
                                  //           style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 15),
                                  //         ),
                                  //         //String Interpolation
                                  //         Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: Text(
                                  //             "${snapshot.data!.patients[index].bookingTime} ",
                                  //             style: const TextStyle(
                                  //                 color: Colors.deepPurple,
                                  //                 fontWeight: FontWeight.bold,
                                  //                 fontSize: 15),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     TextButton(
                                  //         onPressed: () {



                                  //         },
                                  //         child: const Text(
                                  //           "Accept",
                                  //           style: TextStyle(
                                  //               color: Colors.brown,
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.bold),
                                  //         )),
                                  //     TextButton(
                                  //         onPressed: () {},
                                  //         child: const Text("Waiting",
                                  //             style: TextStyle(
                                  //                 color: Colors.brown,
                                  //                 fontSize: 18,
                                  //                 fontWeight: FontWeight.bold))),
                                  //     TextButton(
                                  //         onPressed: () {},
                                  //         child: const Text("Reject",
                                  //             style: TextStyle(
                                  //                 color: Colors.brown,
                                  //                 fontSize: 18,
                                  //                 fontWeight: FontWeight.bold)))
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {}

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
