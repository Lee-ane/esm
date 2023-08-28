import 'dart:async';
import 'package:esm/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();

  Set<Marker> markers = {};
  String fullAdress = '';

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.7447, 106.6964),
    zoom: 18,
  );

  Future<void> searchAdress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        List<Placemark> placemarks = await placemarkFromCoordinates(
            location.latitude, location.longitude);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          setState(() {
            fullAdress =
                "${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}";
          });
          mapController.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(location.latitude, location.longitude), 15.0));
        }
        Marker searchedMarker = Marker(
            markerId: const MarkerId('searched'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(title: fullAdress));
        setState(() {
          markers.removeWhere(
              (element) => element.markerId == const MarkerId('searched'));
          markers.add(searchedMarker);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              compassEnabled: true,
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: markers,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60, top: 13, left: 10),
              child: SizedBox(
                height: 38,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm địa chỉ',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (searchController.text.isNotEmpty) {
                            searchAdress(searchController.text);
                            print(fullAdress);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Center(
                                        child: Text(
                                            'Vui lòng điền địa chỉ cần tìm'))));
                          }
                        });
                      },
                      icon: const Icon(Icons.search),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                height: fullAdress.isNotEmpty ? 50 : 0,
                duration: const Duration(seconds: 1),
                color: const Color(0xff4BC848),
                child: TextButton(
                  onPressed: () {
                    context.read<DataModel>().setDiaChi(fullAdress);
                  },
                  child: const Text(
                    'Đặt làm địa chỉ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
