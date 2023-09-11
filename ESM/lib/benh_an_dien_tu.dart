// ignore_for_file: use_build_context_synchronously

import 'package:esm/components/buttons.dart';
import 'package:esm/components/forms.dart';
import 'package:esm/components/style.dart';
import 'package:esm/components/textfields.dart';
import 'package:esm/dashboard.dart';
import 'package:esm/model/data.dart';
import 'package:esm/model/models.dart';
import 'package:esm/pages/them_tien_su_phau_thuat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BenhAnDienTu extends StatefulWidget {
  const BenhAnDienTu({super.key});

  @override
  State<BenhAnDienTu> createState() => _BenhAnDienTuState();
}

class _BenhAnDienTuState extends State<BenhAnDienTu> {
  bool editable = false;
  TextEditingController nameController = TextEditingController(),
      namSinhController = TextEditingController(),
      canNangController = TextEditingController(),
      nhomMauController = TextEditingController(),
      diaChiController = TextEditingController(),
      chieuCaotroller = TextEditingController(),
      cMNDController = TextEditingController(),
      bHYTController = TextEditingController(),
      sDTController = TextEditingController(),
      canNangKSController = TextEditingController(),
      tinhTrangKSController = TextEditingController(),
      chiTietDUController = TextEditingController(),
      chiTietChaController = TextEditingController(),
      chiTietMeController = TextEditingController(),
      chiTietONoiController = TextEditingController(),
      chiTietBNoiController = TextEditingController(),
      chiTietONgoaiController = TextEditingController(),
      chiTietBNgoaiController = TextEditingController();
  List<bool> expanded = List.generate(13, (index) => false);
  List<bool> _checkboxValuesNC = [];
  List<bool> _checkboxValuesKT = [];
  List<bool> _checkboxValuesDU = [];
  List<bool> _checkboxValuesCha = [];
  List<bool> _checkboxValuesMe = [];
  List<bool> _checkboxValuesONoi = [];
  List<bool> _checkboxValuesBNoi = [];
  List<bool> _checkboxValuesONgoai = [];
  List<bool> _checkboxValuesBNgoai = [];
  int count = 0;

  dynamic data = [];
  dynamic dataTTLS = [];
  List<bool> dataYT = [];
  List<bool> dataKT = [];
  Map<String, dynamic> dataTSB = {};
  dynamic dataTSPT = [];
  Map<String, dynamic> dataTSCha = {};
  Map<String, dynamic> dataTSMe = {};
  Map<String, dynamic> dataTSONoi = {};
  Map<String, dynamic> dataTSBNoi = {};
  Map<String, dynamic> dataTSONgoai = {};
  Map<String, dynamic> dataTSBNgoai = {};

  late GoogleMapController mapController;
  TextEditingController searchController = TextEditingController();

  Set<Marker> markers = {};
  String fullAdress = '';

  final CameraPosition _kGooglePlex = MapData().kGooglePlex;

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
                          setState(() {});
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

  void toggleItem(int index) {
    setState(() {
      for (int i = 0; i < expanded.length; i++) {
        if (expanded[i] == true) {
          count++;
          if (count > 1) {
            if (i == index) {
              expanded[i] = true;
            } else {
              expanded[i] = false;
            }
            count = 1;
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkboxValuesNC = checkBoxTitleNC.map((item) => item.checked).toList();
    _checkboxValuesKT = checkBoxTitleKT.map((item) => item.checked).toList();
    _checkboxValuesDU = checkBoxTitleDU.map((item) => item.checked).toList();
    _checkboxValuesCha = checkBoxTitleDU.map((item) => item.checked).toList();
    _checkboxValuesMe = checkBoxTitleDU.map((item) => item.checked).toList();
    _checkboxValuesONoi = checkBoxTitleDU.map((item) => item.checked).toList();
    _checkboxValuesBNoi = checkBoxTitleDU.map((item) => item.checked).toList();
    _checkboxValuesONgoai =
        checkBoxTitleDU.map((item) => item.checked).toList();
    _checkboxValuesBNgoai =
        checkBoxTitleDU.map((item) => item.checked).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (editable == true) {
                  Submit().submitBADT(
                      context.read<DataModel>().makh,
                      int.parse(chieuCaotroller.text),
                      int.parse(canNangController.text),
                      nhomMauController.text,
                      int.parse(canNangKSController.text),
                      tinhTrangKSController.text,
                      _checkboxValuesNC[0] ? 1 : 0,
                      _checkboxValuesNC[1] ? 1 : 0,
                      _checkboxValuesNC[2] ? 1 : 0,
                      _checkboxValuesNC[3] ? 1 : 0,
                      _checkboxValuesNC[4] ? 1 : 0,
                      _checkboxValuesNC[5] ? 1 : 0,
                      _checkboxValuesNC[6] ? 1 : 0,
                      _checkboxValuesNC[7] ? 1 : 0,
                      _checkboxValuesNC[8] ? 1 : 0,
                      _checkboxValuesNC[9] ? 1 : 0,
                      _checkboxValuesNC[10] ? 1 : 0,
                      _checkboxValuesNC[11] ? 1 : 0,
                      _checkboxValuesNC[12] ? 1 : 0,
                      _checkboxValuesNC[13] ? 1 : 0,
                      _checkboxValuesNC[14] ? 1 : 0,
                      _checkboxValuesKT[0] ? 1 : 0,
                      _checkboxValuesKT[1] ? 1 : 0,
                      _checkboxValuesDU[0] ? 1 : 0,
                      _checkboxValuesDU[1] ? 1 : 0,
                      _checkboxValuesDU[2] ? 1 : 0,
                      _checkboxValuesDU[3] ? 1 : 0,
                      _checkboxValuesDU[4] ? 1 : 0,
                      _checkboxValuesDU[5] ? 1 : 0,
                      chiTietDUController.text,
                      _checkboxValuesCha[0] ? 1 : 0,
                      _checkboxValuesCha[1] ? 1 : 0,
                      _checkboxValuesCha[2] ? 1 : 0,
                      _checkboxValuesCha[3] ? 1 : 0,
                      _checkboxValuesCha[4] ? 1 : 0,
                      _checkboxValuesCha[5] ? 1 : 0,
                      chiTietChaController.text,
                      _checkboxValuesMe[0] ? 1 : 0,
                      _checkboxValuesMe[1] ? 1 : 0,
                      _checkboxValuesMe[2] ? 1 : 0,
                      _checkboxValuesMe[3] ? 1 : 0,
                      _checkboxValuesMe[4] ? 1 : 0,
                      _checkboxValuesMe[5] ? 1 : 0,
                      chiTietMeController.text,
                      _checkboxValuesONoi[0] ? 1 : 0,
                      _checkboxValuesONoi[1] ? 1 : 0,
                      _checkboxValuesONoi[2] ? 1 : 0,
                      _checkboxValuesONoi[3] ? 1 : 0,
                      _checkboxValuesONoi[4] ? 1 : 0,
                      _checkboxValuesONoi[5] ? 1 : 0,
                      chiTietONoiController.text,
                      _checkboxValuesBNoi[0] ? 1 : 0,
                      _checkboxValuesBNoi[1] ? 1 : 0,
                      _checkboxValuesBNoi[2] ? 1 : 0,
                      _checkboxValuesBNoi[3] ? 1 : 0,
                      _checkboxValuesBNoi[4] ? 1 : 0,
                      _checkboxValuesBNoi[5] ? 1 : 0,
                      chiTietBNoiController.text,
                      _checkboxValuesONgoai[0] ? 1 : 0,
                      _checkboxValuesONgoai[1] ? 1 : 0,
                      _checkboxValuesONgoai[2] ? 1 : 0,
                      _checkboxValuesONgoai[3] ? 1 : 0,
                      _checkboxValuesONgoai[4] ? 1 : 0,
                      _checkboxValuesONgoai[5] ? 1 : 0,
                      chiTietONgoaiController.text,
                      _checkboxValuesBNgoai[0] ? 1 : 0,
                      _checkboxValuesBNgoai[1] ? 1 : 0,
                      _checkboxValuesBNgoai[2] ? 1 : 0,
                      _checkboxValuesBNgoai[3] ? 1 : 0,
                      _checkboxValuesBNgoai[4] ? 1 : 0,
                      _checkboxValuesBNgoai[5] ? 1 : 0,
                      chiTietBNgoaiController.text);
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Center(
                      child: Text('Cập nhật bệnh án thành công'),
                    )));
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const DashBoard())));
                }
                editable = !editable;
              });
            },
            icon: Icon(
              editable ? Icons.save : Icons.create,
              color: Colors.white,
            ),
          ),
        ],
        leading: const ReturnBtn(),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Bệnh án điện tử',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02, vertical: screenHeight * 0.03),
          child: Column(
            children: [
              Icon(Icons.location_history,
                  color: primaryColor, size: screenWidth * 0.3),
              Text(
                'Thông tin thành viên',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
              //-----Thông tin thành viên-----//
              AnimatedTile(
                  expanded: expanded[0],
                  onTap: () async {
                    expanded[0] = !expanded[0];
                    toggleItem(0);
                    if (data.isEmpty) {
                      data = await ReadData()
                          .fetchUser(context.read<DataModel>().taiKhoan);
                      nameController.text = data['HoTen'];
                      sDTController.text = data['SDT'];
                      namSinhController.text = DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(data['NamSinh']));
                      cMNDController.text = data['CMND'];
                      bHYTController.text = data['BHYT'];
                      diaChiController.text = data['DiaChi'];
                      if (data['ChieuCao'] != null) {
                        canNangController.text = data['ChieuCao'].toString();
                        chieuCaotroller.text = data['CanNang'].toString();
                        nhomMauController.text = data['NhomMau'];
                      }
                    }
                    setState(() {});
                  },
                  text: 'Thông tin thành viên'),
              AnimatedContent(
                heightRatio: 0.61,
                expanded: expanded[0],
                child: Column(
                  children: [
                    FormTF(
                      label: 'Họ tên',
                      controller: nameController,
                      inputType: TextInputType.name,
                      editable: editable,
                    ),
                    FormTF(
                      label: 'Số điện thoại',
                      controller: sDTController,
                      inputType: TextInputType.phone,
                      editable: editable,
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: SizedBox(
                        height: screenHeight * 0.06,
                        child: TextField(
                          controller: namSinhController,
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Ngày sinh',
                            labelStyle:
                                TextStyle(fontSize: screenHeight * 0.025),
                            hintText: 'Ngày sinh',
                            hintStyle:
                                TextStyle(fontSize: screenHeight * 0.015),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(fontSize: screenHeight * 0.02),
                          onTap: () async {
                            if (editable) {
                              DateTime? datetime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now());
                              datetime ??= DateTime.now();
                              namSinhController.text =
                                  DateFormat('dd-MM-yyyy').format(datetime);
                            }
                          },
                        ),
                      ),
                    ),
                    FormTF(
                      label: 'Số CMND',
                      controller: cMNDController,
                      inputType: TextInputType.number,
                      editable: editable,
                    ),
                    FormTF(
                      label: 'Số BHYT',
                      controller: bHYTController,
                      inputType: TextInputType.visiblePassword,
                      editable: editable,
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: SizedBox(
                        height: screenHeight * 0.08,
                        child: TextFormField(
                          controller: diaChiController,
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Địa chỉ',
                            labelStyle:
                                TextStyle(fontSize: screenHeight * 0.025),
                            hintText: 'Địa chỉ',
                            hintStyle:
                                TextStyle(fontSize: screenHeight * 0.015),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(fontSize: screenHeight * 0.02),
                          onTap: () {
                            if (editable) {
                              setDiaChi();
                            }
                          },
                        ),
                      ),
                    ),
                    Table(
                      children: [
                        TableRow(
                          children: [
                            FormTF(
                              label: 'Chiều cao(Cm)',
                              controller: chieuCaotroller,
                              inputType: TextInputType.number,
                              editable: editable,
                            ),
                            FormTF(
                              label: 'Cân nặng(kg)',
                              controller: canNangController,
                              inputType: TextInputType.number,
                              editable: editable,
                            ),
                            FormTF(
                              inputType: TextInputType.text,
                              controller: nhomMauController,
                              label: 'Nhóm máu',
                              editable: editable,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //-----Tình trạng lúc sinh-----//
              AnimatedTile(
                  expanded: expanded[1],
                  onTap: () async {
                    expanded[1] = !expanded[1];
                    toggleItem(1);
                    if (dataTTLS.isEmpty) {
                      dataTTLS = await ReadData()
                          .fetchTTLS(context.read<DataModel>().makh);
                      if (dataTTLS != null) {
                        canNangKSController.text =
                            dataTTLS['CanNang'].toString();
                        tinhTrangKSController.text = dataTTLS['TinhTrang'];
                      }
                    }
                    setState(() {});
                  },
                  text: 'Tình trạng lúc sinh'),
              AnimatedContent(
                heightRatio: 0.32,
                expanded: expanded[1],
                child: Column(
                  children: [
                    FormTF(
                      label: 'Cân nặng(Kg)',
                      controller: canNangKSController,
                      inputType: TextInputType.name,
                      editable: editable,
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: TextField(
                        controller: tinhTrangKSController,
                        readOnly: !editable,
                        maxLines: 5,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Tình trạng',
                          labelStyle: TextStyle(fontSize: screenHeight * 0.025),
                          hintText: 'Tình trạng',
                          hintStyle: TextStyle(fontSize: screenHeight * 0.015),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //-----Yếu tố nguy cơ đối với sức khỏe cá nhân-----//
              AnimatedTile(
                  expanded: expanded[2],
                  onTap: () async {
                    expanded[2] = !expanded[2];
                    toggleItem(2);
                    if (dataYT.isEmpty) {
                      dataYT = await ReadData()
                          .fetchYeuToNC(context.read<DataModel>().makh);
                      _checkboxValuesNC = dataYT;
                    }
                    setState(() {});
                  },
                  text: 'Yếu tố nguy cơ đối với sức khỏe cá nhân'),
              AnimatedContent(
                heightRatio: 2,
                expanded: expanded[2],
                child: SizedBox(
                  height: screenHeight * 2,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: checkBoxTitleNC.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.13,
                        child: CheckboxListTile(
                          activeColor: primaryColor,
                          title: Text(checkBoxTitleNC[index].title),
                          value: _checkboxValuesNC[index],
                          onChanged: (newValue) {
                            setState(
                              () {
                                if (editable) {
                                  _checkboxValuesNC[index] = newValue!;
                                }
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
              //-----Khuyết tật-----//
              AnimatedTile(
                  expanded: expanded[3],
                  onTap: () async {
                    expanded[3] = !expanded[3];
                    toggleItem(3);
                    if (dataKT.isEmpty) {
                      dataKT = await ReadData()
                          .fetchKT(context.read<DataModel>().makh);
                      _checkboxValuesKT = dataKT;
                    }
                    setState(() {});
                  },
                  text: 'Khuyết tật'),
              AnimatedContent(
                heightRatio: 0.2,
                expanded: expanded[3],
                child: SizedBox(
                  height: screenHeight * 0.2,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: checkBoxTitleKT.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.08,
                        child: CheckboxListTile(
                          activeColor: primaryColor,
                          title: Expanded(
                              child: Text(checkBoxTitleKT[index].title)),
                          value: _checkboxValuesKT[index],
                          onChanged: (newValue) {
                            setState(
                              () {
                                if (editable) {
                                  _checkboxValuesKT[index] = newValue!;
                                }
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
              //-----Tiền sử bệnh tật, dị ứng-----//
              AnimatedTile(
                  expanded: expanded[4],
                  onTap: () async {
                    expanded[4] = !expanded[4];
                    toggleItem(4);
                    if (dataTSB.isEmpty) {
                      dataTSB = await ReadData()
                          .fetchTSB(context.read<DataModel>().makh);
                      _checkboxValuesDU = dataTSB['list'];
                      chiTietDUController.text = dataTSB['string'];
                    }
                    setState(() {});
                  },
                  text: 'Tiền sử bệnh tật, dị ứng'),
              AnimatedContent(
                heightRatio: 0.83,
                expanded: expanded[4],
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.6,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: checkBoxTitleDU.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            alignment: Alignment.center,
                            height: screenHeight * 0.1,
                            child: CheckboxListTile(
                              activeColor: primaryColor,
                              title: Expanded(
                                  child: Text(checkBoxTitleDU[index].title)),
                              value: _checkboxValuesDU[index],
                              onChanged: (newValue) {
                                setState(
                                  () {
                                    if (editable) {
                                      _checkboxValuesDU[index] = newValue!;
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.2,
                      child: TextField(
                        controller: chiTietDUController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Chi tiết',
                          labelStyle: TextStyle(fontSize: screenHeight * 0.025),
                          hintText: 'Chi tiết',
                          hintStyle: TextStyle(fontSize: screenHeight * 0.015),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(fontSize: screenHeight * 0.02),
                      ),
                    ),
                  ],
                ),
              ),
              //-----Tiền sử phẩu thuật-----//
              AnimatedTile(
                  expanded: expanded[5],
                  onTap: () async {
                    expanded[5] = !expanded[5];
                    toggleItem(5);
                    dataTSPT = await ReadData()
                        .fetchTSPT(context.read<DataModel>().makh);
                    setState(() {});
                  },
                  text: 'Tiền sử phẫu thuật'),
              AnimatedContent(
                heightRatio: 0.42,
                expanded: expanded[5],
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey[50],
                      height: screenHeight * 0.33,
                      child: ListView.builder(
                          itemCount: dataTSPT.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                height: screenHeight * 0.15,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${dataTSPT[index]['TenPhauThuat']}',
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenWidth * 0.04,
                                            ),
                                          ),
                                          Text(
                                              'Ngày thực hiện: ${DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(dataTSPT[index]['NgayThucHien']))}',
                                              style: description),
                                          Text(
                                              'Thời gian gây mê: ${DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(dataTSPT[index]['ThoiGianGayMe']))}',
                                              style: description),
                                          Text(
                                              'Thời gian bắt đầu: ${DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(dataTSPT[index]['ThoiGianBatDau']))}',
                                              style: description),
                                          Text(
                                              'Thời gian kết thúc: ${DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(dataTSPT[index]['ThoiGianKetThuc']))}',
                                              style: description),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        if (editable) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ThemTienSuPT()));
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Color(0xff023e8a)),
                          SizedBox(width: 10),
                          Text(
                            'Thêm',
                            style: TextStyle(
                                color: Color(0xff023e8a), fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //-----Tiền sử gia đình-----//
              AnimatedTile(
                expanded: expanded[6],
                onTap: () {
                  expanded[6] = !expanded[6];
                  toggleItem(6);
                },
                text: 'Tiền sử gia đình',
              ),
              Visibility(
                visible: expanded[6],
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      ParentTile(
                        expanded: expanded[7],
                        onTap: () async {
                          expanded[7] = !expanded[7];
                          if (dataTSCha.isEmpty) {
                            dataTSCha = await ReadData()
                                .fetchTSCha(context.read<DataModel>().makh);
                            _checkboxValuesCha = dataTSCha['list'];
                            chiTietChaController.text = dataTSCha['string'];
                          }
                          setState(() {});
                        },
                        text: 'Cha',
                      ),
                      AnimatedContent(
                        heightRatio: 0.83,
                        expanded: expanded[7],
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: checkBoxTitleDU.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    height: screenHeight * 0.1,
                                    child: CheckboxListTile(
                                      activeColor: primaryColor,
                                      title: Expanded(
                                          child: Text(
                                              checkBoxTitleDU[index].title)),
                                      value: _checkboxValuesCha[index],
                                      onChanged: (newValue) {
                                        setState(
                                          () {
                                            if (editable) {
                                              _checkboxValuesCha[index] =
                                                  newValue!;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.2,
                              child: TextField(
                                controller: chiTietChaController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Chi tiết',
                                  labelStyle:
                                      TextStyle(fontSize: screenHeight * 0.025),
                                  hintText: 'Chi tiết',
                                  hintStyle:
                                      TextStyle(fontSize: screenHeight * 0.015),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ParentTile(
                        expanded: expanded[8],
                        onTap: () async {
                          expanded[8] = !expanded[8];
                          if (dataTSMe.isEmpty) {
                            dataTSMe = await ReadData()
                                .fetchTSMe(context.read<DataModel>().makh);
                            _checkboxValuesMe = dataTSMe['list'];
                            chiTietMeController.text = dataTSMe['string'];
                          }
                          setState(() {});
                        },
                        text: 'Mẹ',
                      ),
                      AnimatedContent(
                        heightRatio: 0.83,
                        expanded: expanded[8],
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: checkBoxTitleDU.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    height: screenHeight * 0.1,
                                    child: CheckboxListTile(
                                      activeColor: primaryColor,
                                      title: Expanded(
                                          child: Text(
                                              checkBoxTitleDU[index].title)),
                                      value: _checkboxValuesMe[index],
                                      onChanged: (newValue) {
                                        setState(
                                          () {
                                            if (editable) {
                                              _checkboxValuesMe[index] =
                                                  newValue!;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.2,
                              child: TextField(
                                controller: chiTietMeController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Chi tiết',
                                  labelStyle:
                                      TextStyle(fontSize: screenHeight * 0.025),
                                  hintText: 'Chi tiết',
                                  hintStyle:
                                      TextStyle(fontSize: screenHeight * 0.015),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ParentTile(
                        expanded: expanded[9],
                        onTap: () async {
                          expanded[9] = !expanded[9];
                          if (dataTSONoi.isEmpty) {
                            dataTSONoi = await ReadData()
                                .fetchTSON(context.read<DataModel>().makh);
                            _checkboxValuesONoi = dataTSONoi['list'];
                            chiTietONoiController.text = dataTSONoi['string'];
                          }
                          setState(() {});
                        },
                        text: 'Ông nội',
                      ),
                      AnimatedContent(
                        heightRatio: 0.83,
                        expanded: expanded[9],
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: checkBoxTitleDU.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    height: screenHeight * 0.1,
                                    child: CheckboxListTile(
                                      activeColor: primaryColor,
                                      title: Expanded(
                                          child: Text(
                                              checkBoxTitleDU[index].title)),
                                      value: _checkboxValuesONoi[index],
                                      onChanged: (newValue) {
                                        setState(
                                          () {
                                            if (editable) {
                                              _checkboxValuesONoi[index] =
                                                  newValue!;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.2,
                              child: TextField(
                                controller: chiTietONoiController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Chi tiết',
                                  labelStyle:
                                      TextStyle(fontSize: screenHeight * 0.025),
                                  hintText: 'Chi tiết',
                                  hintStyle:
                                      TextStyle(fontSize: screenHeight * 0.015),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ParentTile(
                        expanded: expanded[10],
                        onTap: () async {
                          expanded[10] = !expanded[10];
                          if (dataTSBNoi.isEmpty) {
                            dataTSBNoi = await ReadData()
                                .fetchTSBN(context.read<DataModel>().makh);
                            _checkboxValuesBNoi = dataTSBNoi['list'];
                            chiTietBNoiController.text = dataTSBNoi['string'];
                          }
                          setState(() {});
                        },
                        text: 'Bà nội',
                      ),
                      AnimatedContent(
                        heightRatio: 0.83,
                        expanded: expanded[10],
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: checkBoxTitleDU.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    height: screenHeight * 0.1,
                                    child: CheckboxListTile(
                                      activeColor: primaryColor,
                                      title: Expanded(
                                          child: Text(
                                              checkBoxTitleDU[index].title)),
                                      value: _checkboxValuesBNoi[index],
                                      onChanged: (newValue) {
                                        setState(
                                          () {
                                            if (editable) {
                                              _checkboxValuesBNoi[index] =
                                                  newValue!;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.2,
                              child: TextField(
                                controller: chiTietBNoiController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Chi tiết',
                                  labelStyle:
                                      TextStyle(fontSize: screenHeight * 0.025),
                                  hintText: 'Chi tiết',
                                  hintStyle:
                                      TextStyle(fontSize: screenHeight * 0.015),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ParentTile(
                        expanded: expanded[11],
                        onTap: () async {
                          expanded[11] = !expanded[11];
                          if (dataTSONgoai.isEmpty) {
                            dataTSONgoai = await ReadData()
                                .fetchTSONgoai(context.read<DataModel>().makh);
                            _checkboxValuesONgoai = dataTSONgoai['list'];
                            chiTietONgoaiController.text =
                                dataTSONgoai['string'];
                          }
                          setState(() {});
                        },
                        text: 'Ông ngoại',
                      ),
                      AnimatedContent(
                        heightRatio: 0.83,
                        expanded: expanded[11],
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: checkBoxTitleDU.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    height: screenHeight * 0.1,
                                    child: CheckboxListTile(
                                      activeColor: primaryColor,
                                      title: Expanded(
                                          child: Text(
                                              checkBoxTitleDU[index].title)),
                                      value: _checkboxValuesONgoai[index],
                                      onChanged: (newValue) {
                                        setState(
                                          () {
                                            if (editable) {
                                              _checkboxValuesONgoai[index] =
                                                  newValue!;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.2,
                              child: TextField(
                                controller: chiTietONgoaiController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Chi tiết',
                                  labelStyle:
                                      TextStyle(fontSize: screenHeight * 0.025),
                                  hintText: 'Chi tiết',
                                  hintStyle:
                                      TextStyle(fontSize: screenHeight * 0.015),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ParentTile(
                        expanded: expanded[12],
                        onTap: () async {
                          expanded[12] = !expanded[12];
                          if (dataTSBNgoai.isEmpty) {
                            dataTSBNgoai = await ReadData()
                                .fetchTSBNgoai(context.read<DataModel>().makh);
                            _checkboxValuesBNgoai = dataTSBNgoai['list'];
                            chiTietBNgoaiController.text =
                                dataTSBNgoai['string'];
                          }
                          setState(() {});
                        },
                        text: 'Bà ngoại',
                      ),
                      AnimatedContent(
                        heightRatio: 0.83,
                        expanded: expanded[12],
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.6,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: checkBoxTitleDU.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    height: screenHeight * 0.1,
                                    child: CheckboxListTile(
                                      activeColor: primaryColor,
                                      title: Expanded(
                                          child: Text(
                                              checkBoxTitleDU[index].title)),
                                      value: _checkboxValuesBNgoai[index],
                                      onChanged: (newValue) {
                                        setState(
                                          () {
                                            if (editable) {
                                              _checkboxValuesBNgoai[index] =
                                                  newValue!;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.2,
                              child: TextField(
                                controller: chiTietBNgoaiController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Chi tiết',
                                  labelStyle:
                                      TextStyle(fontSize: screenHeight * 0.025),
                                  hintText: 'Chi tiết',
                                  hintStyle:
                                      TextStyle(fontSize: screenHeight * 0.015),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
