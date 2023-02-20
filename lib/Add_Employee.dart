import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddEmployee extends StatefulWidget {
  @override
  State<AddEmployee> createState() => _AddEmployeeState();

  dynamic? map;
  AddEmployee(this.map);

  GlobalKey<FormState> formkey = GlobalKey();
  var EmployeeName = new TextEditingController();
  var EmployeeEmail = new TextEditingController();
  var EmployeeMobile = new TextEditingController();
}

class _AddEmployeeState extends State<AddEmployee> {
  void initState(){
    widget.EmployeeName.text = widget.map==null?'':widget.map['EmployeeName'];
    widget.EmployeeEmail.text = widget.map==null?'':widget.map['EmployeeEmail'];
    widget.EmployeeMobile.text = widget.map==null?'':widget.map['EmployeeMobile'].toString();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                child: TextFormField(
                  controller: widget.EmployeeName,
                  decoration: InputDecoration(
                    hintText: "Enter Employee's name",
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Employee's Email",
              ),
              controller: widget.EmployeeEmail,
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Employee's Mobile Number",
              ),
              controller: widget.EmployeeMobile,
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () async {
                if(widget.map==null){
                  await addEmployee().then((value) => (value) {

                  });
                }
                else{
                  await editEmployee().then((value) => (value) {

                  });
                }

                Navigator.of(context).pop(true);

              }, child: Text("Submit",style: TextStyle(fontSize: 24),),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addEmployee() async{
    var map ={};
    map['EmployeeName']=widget.EmployeeName.text;
    map['EmployeeCode']=widget.EmployeeEmail.text;
    map['EmployeeEmail']=widget.EmployeeMobile.text;
    var response1 = http.post(Uri.parse("https://630eccce498924524a7fc5d0.mockapi.io/Employee",),body: map);
  }

  Future<void> editEmployee() async{
    var map ={};
    map['EmployeeName']=widget.EmployeeName.text;
    map['EmployeeCode']=widget.EmployeeEmail.text;
    map['EmployeeEmail']=widget.EmployeeMobile.text;
    var response1 = http.put(Uri.parse("https://630eccce498924524a7fc5d0.mockapi.io/Employee"+widget.map['id'].toString(),),body: map);
  }
}