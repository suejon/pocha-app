// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// class CustomMarker extends StatefulWidget {
//   final MarkerId markerId;
//   final LatLng position;
//   final String imageUrl;
//
//   const CustomMarker({
//     Key? key,
//     required this.markerId,
//     required this.position,
//     required this.imageUrl,
//   }) : super(key: key);
//
//   @override
//   _CustomMarkerState createState() => _CustomMarkerState();
// }
//
// class _CustomMarkerState extends State<CustomMarker> {
//   late BitmapDescriptor markerIcon;
//
//   @override
//   void initState() {
//     addCustomIcon();
//     super.initState();
//   }
//
//   Future<void> addCustomIcon() async {
//     final http.Response response = await http.get(Uri.parse(widget.imageUrl));
//     if (response.statusCode == 200) {
//       setState(() {
//         markerIcon = BitmapDescriptor.fromBytes(response.bodyBytes);
//       });
//     } else {
//       throw Exception('Failed to load marker icon');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Marker(
//       markerId: widget.markerId,
//       position: widget.position,
//       draggable: true,
//       icon: markerIcon,
//     );)
//   }
// }