import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:new_mac_test/components/register_store_modal.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng initialLocation = const LatLng(37.422131, -122.084801);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  Future<void> addCustomIcon() async {
    final http.Response response =
        await http.get(Uri.parse("https://placehold.co/200x.png"));
    if (response.statusCode == 200) {
      setState(() {
        markerIcon = BitmapDescriptor.fromBytes(response.bodyBytes);
      });
    } else {
      throw Exception('Failed to load marker icon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialLocation,
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("marker1"),
              position: const LatLng(37.422131, -122.084801),
              draggable: true,
              icon: markerIcon,
            ),
            Marker(
              markerId: const MarkerId("marker2"),
              position: const LatLng(37.415768808487435, -122.08440050482749),
              icon: markerIcon,
            ),
          },
        ),
        // InfoDraggrableScrollableSheet(
        //     id: '88d7e63e-6cb6-44e8-b46c-58a4c8d937e1')
        RegisterStoreModal()
      ]),
    );
  }
}
