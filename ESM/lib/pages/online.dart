import 'package:esm/components/buttons.dart';
import 'package:esm/components/textfields.dart';
import 'package:esm/dashboard.dart';
import 'package:xml/xml.dart' as xml;
import 'package:esm/components/style.dart';
import 'package:esm/model/data.dart';
import 'package:esm/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Online extends StatefulWidget {
  const Online({super.key});

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  bool atHospital = true;
  String _selectedGender = 'Giới tính';
  String selectedGK = '';
  List<String> goiKhamList = [];
  List<String> chuyenKhoaList = [];
  String noiKham = 'Chọn nơi khám';
  String selectedCK = '';
  int indexGK = 1;
  int indexCK = 1;

  bool isVisible = false;

  Set<Polyline> polyLines = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> cN = [];
  List<String> locationName = [];
  List<LatLng> polylineCoordinate = [];
  DistanceCalculator distanceCalculator = DistanceCalculator();
  String googleApiKey = 'AIzaSyDwlo11bBEgWSbLOvFAIyAy1-a1sECNT4I';
  String totalDistance = 'No route';
  int selected = 0;

  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();

  Set<Marker> markers = {};
  String fullAdress = '';

  final CameraPosition _kGooglePlex = MapData().kGooglePlex;

  TextEditingController nameController = TextEditingController(),
      sDTController = TextEditingController(),
      diaChiController = TextEditingController(),
      namSinhController = TextEditingController(),
      trieuChungController = TextEditingController(),
      ngayKhamController = TextEditingController(),
      gioKhamController = TextEditingController();

  void _handleGenderChange(String value) {
    setState(() {
      _selectedGender = value;
    });
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

      if (result.errorMessage != null && result.errorMessage!.isNotEmpty) {
        setState(() {
          totalDistance = 'Quota';
        });
      } else if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinate.add(LatLng(point.latitude, point.longitude));
        }
        setState(() {
          addPolyLine();
          totalDistance = distanceCalculator
              .calculateRouteDistance(polylineCoordinate, decimals: 1);
        });
      }
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text('Error: $e')),
          ),
        );
      });
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
      locationName.clear();
      for (var placemark in placemarks) {
        var name = placemark.findElements('name').first;
        var nameString = name.innerText;
        var points = placemark.findElements('Point').toList();
        var pointsElement = points.first;
        var coordinatesElement =
            pointsElement.findElements('coordinates').single;
        var coordinates = coordinatesElement.innerText.split(',');
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

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 80);
    mapController.animateCamera(cameraUpdate);
  }

  Future<LatLng> getCurrentLocation() async {
    LatLng? currentLocation;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation = LatLng(position.latitude, position.longitude);
    return currentLocation;
  }

  void setDiaChi() async {
    fullAdress = '';
    MapData().getPermisson();
    showDialog(
        context: context,
        builder: ((context) {
          return Material(
            child: Expanded(
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
                    padding:
                        const EdgeInsets.only(right: 60, top: 13, left: 10),
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
                          diaChiController.text = fullAdress;
                          Navigator.pop(context);
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
        }));
  }

  void setPhongKham() async {
    fullAdress = '';
    readKmlFile();
    MapData().getPermisson();
    showDialog(
        context: context,
        builder: ((context) {
          return Material(
            child: Expanded(
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
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const BackButton(),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.45,
                                            child: ListView.builder(
                                              itemCount: locationName.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        getPolyPoints(
                                                            cN[index]);
                                                        Navigator.pop(context);
                                                        centerMapOnPoint(
                                                            cN[index]);
                                                        selected = index;
                                                        setState(() {
                                                          isVisible = true;
                                                        });
                                                      },
                                                      child: Text(
                                                        locationName[index],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04,
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
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.05,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Text(
                          totalDistance,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (isVisible) {
                              noiKham = locationName[selected];
                              Navigator.pop(context);
                              setState(() {});
                            }
                          },
                          child: Text(
                            'Đặt làm nơi khám',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  @override
  void initState() {
    super.initState();
    nameController.text = context.read<DataModel>().hoTen;
    sDTController.text = context.read<DataModel>().sdt;
    diaChiController.text = context.read<DataModel>().diaChi;
    _selectedGender = context.read<DataModel>().gioiTinh;
    namSinhController.text =
        DateFormat('dd-MM-yyyy').format(context.read<DataModel>().ngaySinh);
    ngayKhamController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    gioKhamController.text =
        '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
    goiKhamList = context.read<DataModel>().goiKham;
    selectedGK = goiKhamList[0];
    chuyenKhoaList = context.read<DataModel>().chuyenKhoa;
    selectedCK = chuyenKhoaList[0];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenWidth * 0.48,
                      decoration: BoxDecoration(
                        color: atHospital ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              atHospital = true;
                              if (kDebugMode) {
                                print(atHospital);
                              }
                            });
                          },
                          child: Text(
                            'Đặt lịch khám tại bệnh viện',
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: atHospital ? Colors.white : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.017),
                          )),
                    ),
                    Container(
                      width: screenWidth * 0.48,
                      decoration: BoxDecoration(
                        color: atHospital ? Colors.white : primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              atHospital = false;
                              if (kDebugMode) {
                                print(atHospital);
                              }
                            });
                          },
                          child: Text(
                            'Đặt lịch khám tại phòng khám',
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: atHospital ? primaryColor : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.017,
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Center(
                child: Icon(
                  Icons.location_history,
                  size: screenWidth * 0.3,
                  color: primaryColor,
                ),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Họ và tên'),
              ),
              TextField(
                controller: sDTController,
                decoration: const InputDecoration(hintText: 'Số điện thoại'),
              ),
              TextField(
                readOnly: true,
                controller: diaChiController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Địa chỉ',
                  suffixIcon: MapIconBtn(
                    onPressed: () {
                      setDiaChi();
                    },
                  ),
                ),
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Text(
                        _selectedGender,
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                      RadioListTile(
                        title: Text(
                          'Nam',
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        ),
                        value: 'Nam',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          _handleGenderChange(value!);
                        },
                      ),
                      RadioListTile(
                        title: Text(
                          'Nữ',
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        ),
                        value: 'Nữ',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          _handleGenderChange(value!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              TextField(
                readOnly: true,
                controller: namSinhController,
                decoration: const InputDecoration(hintText: 'Năm sinh'),
                onTap: () async {
                  DateTime? datetime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  datetime ??= DateTime.now();
                  setState(() {
                    namSinhController.text =
                        DateFormat('dd-MM-yyyy').format(datetime!);
                  });
                },
              ),
              Divider(
                color: Colors.brown,
                thickness: 4,
                height: screenHeight * 0.1,
              ),
              Text(
                'Thông tin nơi khám và gói khám',
                style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.01),
                      child: Icon(
                        Icons.home_work,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Bệnh viên/Phòng khám gần nhất',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    noiKham,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                ],
              ),
              TextField(
                onTap: () {
                  setPhongKham();
                },
                readOnly: true,
                controller: TextEditingController(text: 'Đi đến bản đồ'),
                style: TextStyle(color: primaryColor),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    Icon(
                      Icons.medical_services,
                      color: primaryColor,
                    ),
                    Text(
                      'Chuyên khoa',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              DropdownButtonFormField(
                value: selectedCK,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                items: chuyenKhoaList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCK = value!;
                    indexCK =
                        context.read<DataModel>().chuyenKhoa.indexOf(value) + 1;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    Icon(
                      Icons.file_present,
                      color: primaryColor,
                    ),
                    Text(
                      'Gói khám',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              DropdownButtonFormField(
                value: selectedGK,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                items:
                    goiKhamList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedGK = value!;
                    indexGK =
                        context.read<DataModel>().goiKham.indexOf(value) + 1;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: primaryColor,
                    ),
                    Text(
                      'Giá',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.1),
                      child: Text(
                        NumberFormat.currency(symbol: 'đ', locale: 'vi_VN')
                            .format(context.read<DataModel>().giaGoi[context
                                .read<DataModel>()
                                .goiKham
                                .indexOf(selectedGK)]),
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                    Text(
                      'Triệu chứng',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: trieuChungController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Triệu chứng',
                  suffixIcon: Icon(Icons.create, color: primaryColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cases_rounded,
                              color: primaryColor,
                              size: screenWidth * 0.05,
                            ),
                            Text(
                              'Ngày khám',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                        DateTF(
                            controller: ngayKhamController,
                            title: 'Ngày khám bệnh'),
                        TimeTF(
                            controller: gioKhamController, title: 'Giờ khám'),
                      ],
                    ),
                  ],
                ),
              ),
              ContactBtn(
                child: const Text(
                  'Đặt lịch hẹn',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  List<int> timeComponents =
                      gioKhamController.text.split(':').map(int.parse).toList();
                  int hours = timeComponents[0];
                  int minutes = timeComponents[1];
                  DateTime date = DateFormat('dd-MM-yyyy')
                      .parse(ngayKhamController.text, true);
                  DateTime combine =
                      DateTime(date.year, date.month, date.day, hours, minutes);
                  String message = await Submit().submit(
                      context.read<DataModel>().makh,
                      indexCK,
                      diaChiController.text,
                      atHospital
                          ? 'Đặt lịch khám tại bệnh viện'
                          : 'Đặt lịch khám tại phòng khám',
                      combine.toString(),
                      trieuChungController.text,
                      indexGK,
                      context.read<DataModel>().noiKham.indexOf(noiKham) + 1);
                  if (message.isNotEmpty) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Center(child: Text(message))));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashBoard()));
                    });
                  } else {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Center(child: Text('Vui lòng thử lại sau'))));
                    });
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: ContactBtn(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, color: Colors.white),
                      Text(
                        'Hotline: 19002297',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
