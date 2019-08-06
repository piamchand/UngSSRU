import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:ung_ssru/models/product_model.dart';

class Showproduct extends StatefulWidget {
  @override
  _ShowproductState createState() => _ShowproductState();
}

class _ShowproductState extends State<Showproduct> {
// Explicit
  Firestore firestore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  List<ProductModel> productModels = [];

//Method
  @override
  void initState() {
    super.initState();
    readFireStore();
  }

  Future<void> readFireStore() async {
    CollectionReference collectionReference = firestore.collection('Product');
    subscription = await collectionReference.snapshots().listen((dataSnapshot) {
      snapshots = dataSnapshot.documents;

      for (var snapshot in snapshots) {
        String nameProduct = snapshot.data['Name'];

        String detailProduct = snapshot.data['Detail'];
        String urlProduct = snapshot.data['Url'];
        print('url = $urlProduct');

        ProductModel productModel =
            ProductModel(nameProduct, detailProduct, urlProduct);

        setState(() {
          productModels.add(productModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(30.0)),
      width: 150.0,
      height: 100.0,
      child: Image.network(
        productModels[index].url,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showText(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[showName(index), showDetailShort(index)],
    );
  }

  Widget showName(int index) {
    return Text(
      productModels[index].name,
      style: TextStyle(fontSize: 24.0),
    );
  }

  Widget showDetailShort(int index) {
    String detailShort = (productModels[index].detail).substring(1, 70);
    return Container(
      width: 200.0,
      child: Text('$detailShort...'),
    );
  }

  Widget showListProduct() {
    return Container(
          child: ListView.builder(
        itemCount: productModels.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(decoration: index % 2 == 0 
          ? BoxDecoration(color: Colors.blue[50])
          : BoxDecoration(color: Colors.blue[200]),
                      child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                showImage(index),
                SizedBox(
                  width: 8.0,
                ),
                showText(index),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showListProduct(),
    );
  }
}