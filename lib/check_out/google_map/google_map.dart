import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CostomGoogleMap extends StatefulWidget {
  const CostomGoogleMap({super.key});

  @override
  State<CostomGoogleMap> createState() => _CostomGoogleMapState();
}

class _CostomGoogleMapState extends State<CostomGoogleMap> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  // LatLng sourceLocation = LatLng(37.33429383, 78.2000);

  late GoogleMapController controller;
  // late Location _location;
  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylinePoints result =  await polylinePoints.getRouteBetweenCoordinates(
  //     google_api_key,
  //     PointLatLng(
  //       sourceLocation.latitude,
  //       sourceLocation.longitude,
  //     ),
  //     PointLatLng(
  //       _initialcameraposition.latitude,
  //       _initialcameraposition.longitude,
  //     ),
  //   ) as PolylinePoints;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Location"),
      ),
      body: Container(
        height: 100.h,
        width: 100.h,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialcameraposition,
              ),
              mapType: MapType.normal,
              onMapCreated: (da) {},
              myLocationEnabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
