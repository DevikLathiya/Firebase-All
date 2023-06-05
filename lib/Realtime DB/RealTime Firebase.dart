import 'package:firebase/Components/constants.dart';
import 'package:firebase/Realtime%20DB/ViewRealtimeData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Components/default_button.dart';

class FbRealTIme extends StatefulWidget {
  String? id;
  Map? value;
  FbRealTIme([this.id, this.value]);



  @override
  State<FbRealTIme> createState() => _FbRealTImeState();
}

class _FbRealTImeState extends State<FbRealTIme> {

  TextEditingController _name = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _sub1 = TextEditingController();
  TextEditingController _sub2 = TextEditingController();
  TextEditingController _sub3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref("student");
    if(widget.id!=null){
      _name.text = widget.value!['name'] ;
       _contact.text = widget.value!['contact'];
       _sub1.text = widget.value!['marks']['sub1'];
       _sub2.text = widget.value!['marks']['sub2'];
      _sub3.text = widget.value!['marks']['sub3'];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add RealTime Data",),
        backgroundColor: kPrimarysColor.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "Enter your Name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _contact,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Contact No",
                    hintText: "Enter your Contact No",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _sub1,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Sub 1 No",
                    hintText: "Enter your Sub1 No",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _sub2,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Sub 2 No",
                    hintText: "Enter your Sub2 No",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _sub3,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Sub 3 No",
                    hintText: "Enter your Sub3 No",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 30,),

                DefaultButton(
                  text: (widget.id!=null) ? "Update Data" :"Add Data",
                  press: () async {
                    String name = _name.text;
                    String contact = _contact.text;
                    String sub1 = _sub1.text;
                    String sub2 = _sub2.text;
                    String sub3 = _sub3.text;

                    if(widget.id!=null){
                      DatabaseReference ref = FirebaseDatabase.instance.ref("student").push();
                      await ref.update({
                        "name": name,
                        "contact": contact,
                        "marks": {
                          "sub1": sub1,
                          "sub2": sub2,
                          "sub3": sub3,
                        }
                      });
                    }
                    else
                      {
                        DatabaseReference ref = FirebaseDatabase.instance.ref("student").push();
                        await ref.set({
                          "name": name,
                          "contact": contact,
                          "marks": {
                            "sub1": sub1,
                            "sub2": sub2,
                            "sub3": sub3,
                          }
                        });
                      }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewRealtime()));
                  },
                ),
                DefaultButton(
                  text: "View Data",
                  press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewRealtime(),));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
