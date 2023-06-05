import 'package:firebase/Components/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Components/default_button.dart';

import 'View Data.dart';
class AddUpdate extends StatefulWidget {
  String? id;
  String? name;
  String? contact;
  AddUpdate([this.id, this.name, this.contact]);

  @override
  State<AddUpdate> createState() => _AddUpdateState();
}

class _AddUpdateState extends State<AddUpdate> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController _name = TextEditingController();
  TextEditingController _contact = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id!=null)
      {
        _name.text = widget.name!;
        _contact.text = widget.contact!;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Cloud Store Data",),
        backgroundColor: kPrimarysColor.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: 30,),
              TextFormField(
                controller: _contact,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Contact No",
                  hintText: "Enter your Contact No",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: 30,),
              DefaultButton(
                text: (widget.id!=null) ? "Update User" :"Add User",
                press: (){
                  String name = _name.text;
                  String contact = _contact.text;

                  if(widget.id!=null)
                    {
                      users.doc(widget.id).update({'Name' : name,'Contact' : contact})
                          .then((value) => print("User Updated"))
                          .catchError((error) => print("Failed to update user: $error"));
                    }
                  else{
                    users.add({
                      'Name': name, // John Doe
                      'Contact': contact, // Stokes and Sons
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Added")));
                    }).catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to add user: $error"))));
                  }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewData(),));
                },
              ),

              SizedBox(height: 50,),
              DefaultButton(
                text: "View User",
                press: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewData(),));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
