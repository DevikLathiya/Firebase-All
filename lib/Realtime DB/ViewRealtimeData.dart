import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'RealTime Firebase.dart';

class ViewRealtime extends StatefulWidget {
  const ViewRealtime({Key? key}) : super(key: key);

  @override
  State<ViewRealtime> createState() => _ViewRealtimeState();
}

class _ViewRealtimeState extends State<ViewRealtime> {
  List key=[];
  List value=[];
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('student');

  @override
  void initState() {
    super.initState();
    /*starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map m = data as Map;
      key = m.keys.toList();
      value = m.values.toList();
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("view RealTime Data",),
        backgroundColor: Colors.amber.shade500,
      ),
      body:StreamBuilder(
        stream: starCountRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final data = snapshot.data!.snapshot.value;
            Map m = data as Map;
            key = m.keys.toList();
            value = m.values.toList();
            print(key);

            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${value[index]['name']}"),
                  subtitle: Text("${value[index]['contact']}"),
                  trailing:
                  Row(mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {

                        DatabaseReference starCountRef = FirebaseDatabase.instance.ref('student').child(key[index]);
                        starCountRef.remove();

                      }, icon: Icon(Icons.delete)),
                      IconButton(onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return FbRealTIme(key[index],value[index]);
                        },));
                      }, icon: Icon(Icons.edit)),

                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

/*ListView.builder(
        itemCount: value.length,
       itemBuilder: (context, index) {
          print(value);
         return ListTile(
           title: Text("${value[index]['name']} | ${value[index]['contact']}"),
           subtitle: Text("${value[index]['marks']['sub1']} | ${value[index]['marks']['sub2']} | ${value[index]['marks']['sub3']}"),
           trailing: Wrap(
             children: [
               IconButton(onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => FbRealTIme(key[index],value[index])));
               }, icon: const Icon(Icons.edit)),
               IconButton(onPressed: () {
                 DatabaseReference ref = FirebaseDatabase.instance.ref("student").child(key[index]);
                 ref.remove();
                 setState(() {});
               }, icon: const Icon(Icons.delete))
             ],
           ),
         );
       },
      ),*/