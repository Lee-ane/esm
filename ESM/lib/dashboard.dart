import 'dart:convert';

import 'package:esm/benh_an_dien_tu.dart';
import 'package:esm/components/drawer.dart';
import 'package:esm/components/style.dart';
import 'package:esm/datlich.dart';
import 'package:esm/model/data.dart';
import 'package:esm/model/models.dart';
import 'package:esm/pages/tracuu_badt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  TextEditingController maController = TextEditingController();
  dynamic data = [];
  List<String> namelist = [];
  List<int> pricelist = [];
  List<String> chuyenKhoa = [];
  List<String> phongKhamlist = [];
  bool isChecking = false;

  Future<void> fetchPK() async {
    String url = '${context.read<DataModel>().urlHead}/phongKham';
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var log = decodedResponse["data"];
        data = log;
        for (int i = 0; i < data.length; i++) {
          phongKhamlist.add(data[i]['TenPhongKham']);
        }
        setState(() {
          context.read<DataModel>().setNoiKham(phongKhamlist);
        });
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> fetchGK() async {
    String url = '${context.read<DataModel>().urlHead}/goiKham';
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var log = decodedResponse["data"];
        data = log;
        for (int i = 0; i < data.length; i++) {
          namelist.add(data[i]['TenGoiKham']);
          pricelist.add(data[i]['Gia']);
        }
        setState(() {
          context.read<DataModel>().setGoiKham(namelist);
          context.read<DataModel>().setGiaGoi(pricelist);
        });
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> fetchCK() async {
    String url = '${context.read<DataModel>().urlHead}/ChuyenKhoa';
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var log = decodedResponse["data"];
        for (int i = 0; i < log.length; i++) {
          chuyenKhoa.add(log[i]['tenChuyenKhoa']);
        }
        setState(() {
          context.read<DataModel>().setChuyenKhoa(chuyenKhoa);
        });
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
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
    fetchGK();
    fetchCK();
    fetchPK();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final List<Options> options = [
      Options(Icons.calendar_month, 'Đặt lịch khám', () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const DatLich()));
      }),
      Options(Icons.book, 'Bệnh án điện tử', () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BenhAnDienTu()));
      }),
      Options(Icons.search, 'Tra cứu bệnh án điện tử', () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return AnimatedContainer(
                height: screenHeight * 0.73,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.07,
                      color: primaryColor,
                      alignment: Alignment.center,
                      child: const Text(
                        'Tra cứu bệnh án điện tử',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.28,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.apartment,
                              color: primaryColor,
                              size: screenWidth * 0.1,
                            ),
                            const Text(
                              'Tra cứu Bệnh án điện tử/CCCD/BHYT cần tra cứu',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 10),
                              child: SingleChildScrollView(
                                child: TextField(
                                  controller: maController,
                                  decoration: InputDecoration(
                                    hintText: 'Mã bệnh án/CCCD/BHYT',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  String taiKhoan = await ReadData()
                                      .traCuu(maController.text);
                                  if (taiKhoan.isNotEmpty) {
                                    setState(() {
                                      context
                                          .read<DataModel>()
                                          .setTaiKhoan(taiKhoan);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const TraCuu())));
                                    });
                                  }
                                },
                                child: const Text(
                                  'Tra cứu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    ];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
          backgroundColor: primaryColor,
        ),
        //Drawer
        drawer:
            const Drawer(surfaceTintColor: Colors.white, child: DrawerCtn()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.18,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.01),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          width: screenWidth * 0.35,
                          child: Text('$index'),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: screenHeight * 0.15,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.01),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          width: screenWidth * 0.35,
                          child: TextButton(
                            onPressed: options[index].onPressed,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  options[index].icon,
                                  color: primaryColor,
                                  size: screenWidth * 0.1,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.28,
                                  child: Text(
                                    options[index].title,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Container(
                  color: Colors.white,
                  width: screenWidth,
                  height: screenHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sản phẩm',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      Text(
                        'Xem thêm',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.23,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.01),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          width: screenWidth * 0.31,
                          child: Text('$index'),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Container(
                  color: Colors.white,
                  width: screenWidth,
                  height: screenHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bác sĩ tiêu biểu',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      Text(
                        'Xem thêm',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Container(
                  color: Colors.white,
                  width: screenWidth,
                  height: screenHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thông tin y khoa',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      Text(
                        'Xem thêm',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                height: screenHeight * 0.5,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.01),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          width: screenWidth * 0.31,
                          child: Text('$index'),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
