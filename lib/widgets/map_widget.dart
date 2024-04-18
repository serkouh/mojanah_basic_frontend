import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:mo_jannah/theme/app_colors.dart';
import 'package:mo_jannah/utils/constants/sizes.dart';
import 'package:http/http.dart' as http;

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late String _mapStyleString;
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _mapChosenLocation =
      const LatLng(35.76727, -5.79975); // Morocco, Tanger
  ValueNotifier<bool> mapBeingDragged = ValueNotifier(false);

  @override
  void initState() {
    rootBundle.loadString('assets/data/map_styles.json').then((string) {
      _mapStyleString = string;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // map
          GoogleMap(
            padding: const EdgeInsets.only(
              bottom: MAP_PADDING,
            ),
            zoomControlsEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(35.76727, -5.79975), // Morocco, Tanger
              zoom: 17.0,
            ),
            compassEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _controller.future.then((value) {
                value.setMapStyle(_mapStyleString);
              });
            },
            onCameraMoveStarted: () {
              mapBeingDragged.value = true;
            },
            onCameraIdle: () async {
              mapBeingDragged.value = false;
              await fetchAddressFromCoordinates();
            },
            // get map center
            onCameraMove: (CameraPosition position) {
              setState(() {
                _mapChosenLocation = position.target;
              });
            },
            // markers: {
            //   Marker(
            //     markerId: const MarkerId('1'),
            //     position: _mapChosenLocation,
            //   ),
            // },
          ),
          // positioned pin and dot
          fakeMarker(),
        ],
      ),
    );
  }

  Future<void> fetchAddressFromCoordinates() async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${_mapChosenLocation.latitude},${_mapChosenLocation.longitude}&key=AIzaSyDrDqT6d7C4XuQkwmGX4mnet29nw1fEJ7k',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final address = data['results'][0]['formatted_address'];
      print(address);
    }
  }

  // this function is not yet implemented and is just if you want to get the nearest location
  // ex: street closest to the center of the map
  Future<void> fetchAndSetNearestLocation() async {
    final GoogleMapController controller = await _controller.future;
    final LatLngBounds visibleRegion = await controller.getVisibleRegion();

    final LatLng center = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) /
          2,
    );

    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${center.latitude},${center.longitude}&destination=${center.latitude},${center.longitude}&key=AIzaSyDrDqT6d7C4XuQkwmGX4mnet29nw1fEJ7k',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final points = data['routes'][0]['overview_polyline']['points'];

      final result = PolylinePoints().decodePolyline(points);
      // final nearestLocation = result.first;
    }
  }

  ValueListenableBuilder<bool> fakeMarker() {
    return ValueListenableBuilder<bool>(
      valueListenable: mapBeingDragged,
      builder: (BuildContext context, bool value, Widget? child) {
        return Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(
                  0, value ? -MAP_PADDING - 20 : -MAP_PADDING - 8, 0),
              child: Center(
                child: Image.asset(
                  'assets/images/icons/pin.png',
                  height: 54.0,
                ),
              ),
            ),
            // dot
            Transform.translate(
              offset: const Offset(0, -MAP_PADDING / 2),
              child: Center(
                child: AnimatedOpacity(
                  opacity: value ? 1.0 : 0.0,
                  duration: const Duration(
                    milliseconds: 100,
                  ),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreenDark.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
