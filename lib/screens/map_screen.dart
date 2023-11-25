import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:new_mac_test/components/register_store_modal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_mac_test/api/location.dart';
import 'package:new_mac_test/components/info_draggrable_scrollable_sheet.dart';
import 'package:new_mac_test/components/widget_to_map_icon.dart';
import 'package:permission_handler/permission_handler.dart';
import '../api/media.dart';
import '../models/media.dart';
import '../utilities/triangle_clipper.dart';
import 'package:new_mac_test/models/location.dart';

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
  Map<String, BitmapDescriptor> markerIcons = {};
  late GoogleMapController gMapController;
  late LatLng middlePointOfScreenOnMap;
  String pickedMarker = "";
  var store;
  List<Location> _stores = [];
  late LatLngBounds _visibleRegion;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> loadInitialPoints(List<Location> stores) async {
    for (int i = 0; i < stores.length; i++) {
      List<Media> media = await getMediaByStore(stores[i].storeId.toString());
      markerList.add(
        Marker(
          draggable: true,
          markerId: MarkerId(stores[i].storeId.toString()),
          position: LatLng(stores[i].latitude!.toDouble(), stores[i].longitude!.toDouble()),
          icon: await getCustomIcon(stores[i].storeId.toString(), "https://chjzbaxswixtqvtytkyz.supabase.co/storage/v1/object/public/" + media[1].ref!, LatLng(stores[i].latitude!.toDouble(), stores[i].longitude!.toDouble())),
          onTap: () {
            setState(() {
              pickedMarker = markerIds[i];
            });
          },
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
          child: SizedBox(
            width: 15,
            height: 15,
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

  void _getStoresVisibleRegion() async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      LatLngBounds bounds = await gMapController.getVisibleRegion();
      setState(() {
        _visibleRegion = bounds;
      });
      LatLng northeast = bounds.northeast;
      LatLng southwest = bounds.southwest;

      _stores = await getVisibleLocations(
        southwest.longitude,
        southwest.latitude,
        northeast.longitude,
        northeast.latitude,
      );

      loadInitialPoints(_stores);
      print(_stores);
    });
  }

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
                    icon: await getCustomIcon("d5f1f059-1e19-4c70-8ca0-163aa6448179", "https://placehold.co/200x.png", middlePointOfScreenOnMap),
                    onTap: () {
                      print("Marker tapped: ${("d5f1f059-1e19-4c70-8ca0-163aa6448179")}");
                      setState(() {
                        pickedMarker = ("d5f1f059-1e19-4c70-8ca0-163aa6448179");
                      });
                    },
                  ),
                );
                setState(() {});
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: Stack(
              children: [
                GoogleMap(
              onCameraMove: (CameraPosition cameraPosition) => {
                middlePointOfScreenOnMap = cameraPosition.target,
                _getStoresVisibleRegion(),
              },
              onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      gMapController = controller;
                      _getStoresVisibleRegion();
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: initialLocation,
                    zoom: 14,
                  ),
                  markers: markerList.toSet(),
                  onTap: (LatLng latLng) {
                    setState(() {
                      pickedMarker = "";
                    });
                  },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
                InfoDraggrableScrollableSheet(id: pickedMarker)
              ],
            ),
          )
        : const Scaffold(body: Text("Loading"));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
