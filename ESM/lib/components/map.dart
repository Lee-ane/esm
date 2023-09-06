// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:async';
import 'package:esm/benh_an_dien_tu.dart';
import 'package:esm/components/style.dart';
import 'package:esm/datlich.dart';
import 'package:esm/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart' as xml;
import 'package:google_maps_routes/google_maps_routes.dart';

class MapBADT extends StatefulWidget {
  const MapBADT({super.key});

  @override
  State<MapBADT> createState() => _MapBADTState();
}

class _MapBADTState extends State<MapBADT> {
  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();

  Set<Marker> markers = {};
  String fullAdress = '';

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.7447, 106.6964),
    zoom: 18,
  );

  Future<void> getPermisson() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Unable to get your location');
      }
    }
  }

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
    getPermisson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: markers,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60, top: 13, left: 10),
              child: TextField(
                controller: searchController,
                onSubmitted: (value) {
                  searchAdress(value);
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  hintText: 'Tìm kiếm địa chỉ',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (searchController.text.isNotEmpty) {
                          searchAdress(searchController.text);
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                height: fullAdress.isNotEmpty ? 50 : 0,
                duration: const Duration(seconds: 1),
                color: primaryColor,
                child: TextButton(
                  onPressed: () {
                    context.read<DataModel>().setDiaChi(fullAdress);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BenhAnDienTu()));
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

class MapDL extends StatefulWidget {
  const MapDL({super.key});

  @override
  State<MapDL> createState() => _MapDLState();
}

class _MapDLState extends State<MapDL> {
  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();

  Set<Marker> markers = {};
  String fullAdress = '';

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.7447, 106.6964),
    zoom: 18,
  );

  Future<void> getPermisson() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Unable to get your location');
      }
    }
  }

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
    getPermisson();
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
              child: TextField(
                controller: searchController,
                onSubmitted: (value) {
                  searchAdress(value);
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  hintText: 'Tìm kiếm địa chỉ',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (searchController.text.isNotEmpty) {
                          searchAdress(searchController.text);
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                height: fullAdress.isNotEmpty ? 50 : 0,
                duration: const Duration(seconds: 1),
                color: primaryColor,
                child: TextButton(
                  onPressed: () {
                    context.read<DataModel>().setDiaChi(fullAdress);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DatLich()));
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

class PhongKhamMap extends StatefulWidget {
  const PhongKhamMap({super.key});

  @override
  State<PhongKhamMap> createState() => _PhongKhamMapState();
}

class _PhongKhamMapState extends State<PhongKhamMap> {
  late GoogleMapController mapController;

  bool isVisible = false;

  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> cN = [];
  List<String> locationName = [];
  List<LatLng> polylineCoordinate = [];
  DistanceCalculator distanceCalculator = DistanceCalculator();
  String googleApiKey = 'AIzaSyDwlo11bBEgWSbLOvFAIyAy1-a1sECNT4I';
  String totalDistance = 'No route';
  int selected = 0;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.7447, 106.6964),
    zoom: 14,
  );

  Future<void> getPermisson() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Unable to get your location');
      }
    }
  }

  void getPolyPoints(LatLng cN) async {
    polylineCoordinate.clear();
    PolylinePoints polylinePoints = PolylinePoints();
    LatLng currentLocation = await getCurrentLocation();

    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(cN.latitude, cN.longitude),
      );
      setState(() {
        isVisible = true;
      });

      if (result.errorMessage != null && result.errorMessage!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('Too much request please try later')),
          ),
        );
      } else if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinate.add(LatLng(point.latitude, point.longitude));
        }
        setState(() {
          addPolyLine();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Center(child: Text('Routing'))),
          );
          totalDistance = distanceCalculator
              .calculateRouteDistance(polylineCoordinate, decimals: 1);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('No route found')),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('Error: $e')),
        ),
      );
    }
  }

  addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: primaryColor,
        width: 6,
        points: polylineCoordinate);
    polylines[id] = polyline;
    setState(() {});
  }

  Future<void> readKmlFile() async {
    try {
      final String kmlContent =
          await rootBundle.loadString('assets/Branches.kml');
      var document = xml.XmlDocument.parse(kmlContent);
      var placemarks = document.findAllElements('Placemark');
      for (var placemark in placemarks) {
        var name = placemark.findElements('name').first;
        var nameString = name.text;
        var points = placemark.findElements('Point').toList();
        var pointsElement = points.first;
        var coordinatesElement =
            pointsElement.findElements('coordinates').single;
        var coordinates = coordinatesElement.text.split(',');
        var lat = double.parse(coordinates[1]);
        var lon = double.parse(coordinates[0]);
        var markerId = MarkerId(nameString);
        var marker = Marker(
            markerId: markerId,
            position: LatLng(lat, lon),
            infoWindow: InfoWindow(
              title: nameString,
            ));
        locationName.add(nameString);
        markers.add(marker);
        cN.add(LatLng(lat, lon));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error reading KML file: $e");
      }
    }
  }

  void centerMapOnPoint(LatLng point) async {
    LatLng currentLocation = await getCurrentLocation();
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        currentLocation.latitude < point.latitude
            ? currentLocation.latitude
            : point.latitude,
        currentLocation.longitude < point.longitude
            ? currentLocation.longitude
            : point.longitude,
      ),
      northeast: LatLng(
        currentLocation.latitude > point.latitude
            ? currentLocation.latitude
            : point.latitude,
        currentLocation.longitude > point.longitude
            ? currentLocation.longitude
            : point.longitude,
      ),
    );

    CameraUpdate cameraUpdate =
        CameraUpdate.newLatLngBounds(bounds, 80); // 100 is padding
    mapController.animateCamera(cameraUpdate);
  }

  Future<LatLng> getCurrentLocation() async {
    LatLng? currentLocation;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation = LatLng(position.latitude, position.longitude);
    return currentLocation;
  }

  @override
  void initState() {
    super.initState();
    getPermisson();
    readKmlFile();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
              polylines: Set<Polyline>.of(polylines.values),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Scaffold(
                              body: AnimatedContainer(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const BackButton(),
                                    SizedBox(
                                      width: screenWidth,
                                      height: screenHeight * 0.5,
                                      child: ListView.builder(
                                        itemCount: locationName.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: screenHeight * 0.05,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  getPolyPoints(cN[index]);
                                                  Navigator.pop(context);
                                                  centerMapOnPoint(cN[index]);
                                                  selected = index;
                                                },
                                                child: Text(
                                                  locationName[index],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      'Danh sách',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            const BackButton(),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.05,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Text(
                    totalDistance,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Visibility(
                  visible: isVisible,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<DataModel>()
                            .setNoiKham(locationName[selected]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DatLich()));
                      },
                      child: Text(
                        'Chọn nơi khám',
                        style: TextStyle(
                            color: Colors.white, fontSize: screenWidth * 0.04),
                      ),
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
