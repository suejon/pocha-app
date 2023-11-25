import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool loading = true;
  late LatLng initialLocation;
  List<String> markerIds = ["marker1", "marker2"];
  List<LatLng> positions = [
    const LatLng(37.5867217, 127.17032),
    const LatLng(37.5867218, 127.17033),
  ];
  List<String> iconUrls = [
    "https://placehold.co/200x.png",
    "https://placehold.co/200x.png",
  ];

  Map<String, BitmapDescriptor> markerIcons = {};

  @override
  void initState() {
    super.initState();
    loadCustomIcons();
    requestLocationPermission();
  }

  Future<void> loadCustomIcons() async {
    for (int i = 0; i < iconUrls.length; i++) {
      final http.Response response = await http.get(Uri.parse(iconUrls[i]));
      if (response.statusCode == 200) {
        final BitmapDescriptor bitmapDescriptor =
        BitmapDescriptor.fromBytes(response.bodyBytes);
        setState(() {
          markerIcons[markerIds[i]] = bitmapDescriptor;
        });
      } else {
        throw Exception('Failed to load marker icon');
      }
    }
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

  Set<Marker> generateMarkers() {
    return Set<Marker>.from(List.generate(
      markerIds.length,
          (index) => Marker(
        markerId: MarkerId(markerIds[index]),
        position: positions[index],
        draggable: true,
        icon: markerIcons[markerIds[index]]!,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return loading != true ? Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 14,
        ),
        markers: generateMarkers(),
      ),
    ) : const Scaffold(body: Text("Loading"));
  }
}
