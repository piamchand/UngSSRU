import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Showproduct extends StatefulWidget {
  @override
  _ShowproductState createState() => _ShowproductState();
}

class _ShowproductState extends State<Showproduct> {

// Explicit
Firestore firestore = Firestore.instance;
StreamSubscription<QuerySnapshot> subscription;
List<DocumentSnapshot> snapshots;

//Method
  @override
  void initState(){
    super. initState();
    readFireStore();
  }

  Future<void> readFireStore()async{

    CollectionReference collectionReference = firestore.collection('Product');
    subscription = await collectionReference.snapshots().listen((dataSnapshot){
      snapshots = dataSnapshot.documents;

      for (var snapshot in snapshots) {
        
        String nameProduct = snapshot.data['Name'];
        print('nameProduct = $nameProduct');
      }

    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
     child: Text('This is Showproduct'), 
    );
  }
}