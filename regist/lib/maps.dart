import 'dart:async';

import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kpostal/kpostal.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => MapSampleState();
}

class MapSampleState extends State<Maps> {
  String postCode = "";
  String address = "";
  dynamic latitude = "";
  dynamic longtude = "";
  late LatLng searchedPosition;
  late GoogleMapController _mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.562591, 126.970805),
    zoom: 17.5,
  );

  final List<Marker> markers = [];
  addMarker(cordinate) {
    // marker 여러개 사용시
    // int id = Random().nextInt(100);
    // 한 개의 마커만 사용
    int id = 1;
    setState(() {
      markers
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _mapController = controller;
              });
            },
            markers: markers.toSet(),
            onTap: (cordinate) {
              _mapController.animateCamera(CameraUpdate.newLatLng(cordinate));
              addMarker(cordinate);
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                width: 500,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => KpostalView(
                        useLocalServer: true,
                        localPort: 1024,
                        callback: (result) {
                          postCode = result.postCode;
                          address = result.address;
                          latitude = result.latitude!.toInt();
                          longtude = result.longitude!.toInt();
                          LatLng searchedPosition = LatLng(latitude, longtude);
                          _mapController.animateCamera(
                              CameraUpdate.newLatLng(searchedPosition));
                        },
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: const Text(
                  "주소검색",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
