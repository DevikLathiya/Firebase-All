import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Cloud%20Firestore/Add%20&%20Update%20Data.dart';
import 'package:flutter/material.dart';

import '../Components/constants.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("View Cloud Store Data",),
          backgroundColor: kPrimarysColor.shade500,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {return const Text('Something went wrong');}

          if (snapshot.connectionState == ConnectionState.waiting) {return const Text("Loading");}

          return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

            return ListTile(
              title: Text(data['Name']),
              subtitle: Text(data['Contact']),
              trailing: Wrap(
                children: [
                  IconButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddUpdate(document.id ,data['Name'],data['Contact'])));
                  }, icon: const Icon(Icons.edit)),
                  IconButton(onPressed: () {
                    users.doc(document.id).delete()
                          .then((value) => print("User Deleted"))
                          .catchError((error) => print("Failed to delete user: $error"));

                  }, icon: const Icon(Icons.delete))
                ],
              ),
            );
          }).toList(),
        );
      },
    ));
  }
}
