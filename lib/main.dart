import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Add_Employee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DataFromAPi(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DataFromAPi extends StatefulWidget {
  const DataFromAPi({Key? key}) : super(key: key);

  @override
  State<DataFromAPi> createState() => _DataFromAPiState();
}

class _DataFromAPiState extends State<DataFromAPi> {
  Future<List> getUserDAta() async {
    var response = await http
        .get(Uri.parse('https://630eccce498924524a7fc5d0.mockapi.io/Employee'));
    print(jsonDecode(response.body).toString());
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ApiDemo')),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AddEmployee(null);
                },
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List>(
        future: getUserDAta(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              child: Text(
                                  snapshot.data![i]['EmployeeName'].toString()),
                            )),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              deleteEmplyee(snapshot.data![i]['id']).then((
                                  value) =>
                                  (value) {
                                setState(() {
                                  return;
                                });
                              });
                            },
                            child: Icon(Icons.delete),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return AddEmployee(snapshot.data![i]);
                                },
                              )).then((value) {
                                setState(() {

                                });
                              },);
                            },
                            child: Icon(Icons.edit),
                          ),
                        ),

                      ],
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator(
              backgroundColor: Colors.black.withBlue(100),
              color: Colors.red.shade400,
            ));
          }
        },
      ),
    );
  }

  Future<List> getDetails() async {
    var response1 = await http.get(Uri.parse(
        "https://630eccce498924524a7fc5d0.mockapi.io/Employee"));
    return jsonDecode(response1.body);
  }

  Future<void> deleteEmplyee(id) async {
    var  response1 = await http.delete(Uri.parse(
        "https://630eccce498924524a7fc5d0.mockapi.io/Employee/" + id));
    return;
  }
}

class User {
  final String EmployeeName, EmployeeEmail, EmployeeMobile;
  User(this.EmployeeName, this.EmployeeEmail, this.EmployeeMobile);
}
