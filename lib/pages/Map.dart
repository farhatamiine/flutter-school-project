import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _currentAddress;
  Position _currentPosition;
  Completer<GoogleMapController> _controller = Completer();
  final _zoom = 15.0;
  final Set<Marker> _markers = Set();
  static LatLng _center = const LatLng(33.5849121, -7.6346089);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  MapType _defaultMapType = MapType.normal;
  void _changeMapType() {
    setState(() {
      _defaultMapType =
          _defaultMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  Future<void> _goToEmsi() async {
    double lat = 33.5849121;
    double long = -7.6346089;
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('Emsi Centre'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'Emsi Centre', snippet: 'Click to navigate')),
      );
    });
  }

  void _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _center = LatLng(position.latitude, position.longitude);
        final snackBar = SnackBar(
          content: Text(
              "${_currentPosition.accuracy}, ${_currentPosition.latitude}, ${_currentPosition.longitude}"),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        print("${place.locality}, ${place.postalCode}, ${place.country}");
        final snackBar = SnackBar(
          content:
              Text("${place.locality}, ${place.postalCode}, ${place.country}"),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Using Google Map"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: _defaultMapType,
            myLocationEnabled: true,
            markers: _markers,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 30.0),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: SpeedDial(
                animatedIcon: AnimatedIcons.menu_home,
                animatedIconTheme: IconThemeData(size: 22.0),
                closeManually: false,
                overlayColor: Colors.black54,
                overlayOpacity: 0.5,
                curve: Curves.bounceIn,
                children: [
                  SpeedDialChild(
                    onTap: _changeMapType,
                    label: 'Change Style',
                    backgroundColor: Color(0xff082361),
                    child: const Icon(
                      FontAwesomeIcons.palette,
                    ),
                  ),
                  SpeedDialChild(
                    label: 'Current Location',
                    backgroundColor: Color(0xff082361),
                    onTap: _getCurrentLocation,
                    child: const Icon(FontAwesomeIcons.artstation),
                  ),
                  SpeedDialChild(
                    child: Icon(FontAwesomeIcons.mapPin),
                    backgroundColor: Color(0xff082361),
                    label: 'Move to EMSI',
                    onTap: _goToEmsi,
                  ),
                  SpeedDialChild(
                    child: Icon(FontAwesomeIcons.idBadge),
                    backgroundColor: Color(0xff082361),
                    label: 'Get Name',
                    onTap: _getAddressFromLatLng,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
