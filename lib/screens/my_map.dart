import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  //Explicit
  static const LatLng ssruLatLng = const LatLng(13.776577, 100.508846);
  CameraPosition cameraPosition = CameraPosition(
    target: ssruLatLng,
    zoom: 16.0,
  );

  //Method

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        position: ssruLatLng,markerId: MarkerId('idSSRU'),
      ),
    ].toSet();
  }

  Widget showMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {},
      markers: myMarker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return showMap();
  }
}
