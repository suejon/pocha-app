import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:new_mac_test/components/widget_to_map_icon.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utilities/triangle_clipper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool loading = true;
  late LatLng initialLocation;
  List<Marker> markerList = <Marker>[];
  List<String> markerIds = ["marker1", "marker2"];
  List<LatLng> positions = [
    const LatLng(37.5867217, 127.17032),
    const LatLng(37.5867219, 127.17035),
  ];
  List<String> iconUrls = [
    "https://placehold.co/200x.png",
    "https://placehold.co/200x.png",
  ];

  Map<String, BitmapDescriptor> markerIcons = {};
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    loadInitialPoints();
  }

  Future<void> loadInitialPoints() async {
    for (int i = 0; i < markerIds.length; i++) {
      markerList.add(
        Marker(
          draggable: true,
          markerId: MarkerId(markerIds[i]),
          position: positions[i],
          icon: await getCustomIcon(markerIds[i], iconUrls[i], positions[i]),
        ),
      );
    }
    setState(() {});
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      await Permission.location.request();
    } else if (status.isGranted) {
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {
        initialLocation = LatLng(position.latitude, position.longitude);
        print(initialLocation);
        loading = false;
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  Future<BitmapDescriptor> getCustomIcon(String markerId, String imageUrl, LatLng positions) async {
    print(imageUrl);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0, bottom: 14),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Text(
              "23",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 45,
          child: Container(
            width: 15,
            height:15,
            child: ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    ).toBitmapDescriptor();
  }
  late GoogleMapController gMapController;
  late LatLng middlePointOfScreenOnMap;

  @override
  Widget build(BuildContext context) {
    return loading != true
        ? Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              label: const FittedBox(child: Text('Add Markers')),
              onPressed: () async {
                markerList.add(
                  Marker(
                    draggable: true,
                    markerId: MarkerId((Random().nextInt(100) + 1).toString()),
                    position: middlePointOfScreenOnMap,
                    icon: await getCustomIcon((Random().nextInt(100) + 1).toString(), "https://placehold.co/200x.png", middlePointOfScreenOnMap),
                  ),
                );
                setState(() {});
                },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: GoogleMap(
              onCameraMove: (CameraPosition cameraPosition) => middlePointOfScreenOnMap = cameraPosition.target,
              onMapCreated: (GoogleMapController controller) => gMapController = controller,
              initialCameraPosition: CameraPosition(
                target: initialLocation,
                zoom: 14,
              ),
              markers: markerList.toSet(),
            ),
          )
        : const Scaffold(body: Text("Loading"));
  }
}
