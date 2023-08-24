// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController(),
      taiKhoanController = TextEditingController(),
      matKhauController = TextEditingController(),
      namSinhController = TextEditingController(),
      cMNDController = TextEditingController(),
      bHYTController = TextEditingController(),
      sDTController = TextEditingController();
  bool gender = true;

  Future<void> register() async {
    final String name = nameController.text;
    final String taiKhoan = taiKhoanController.text;
    final String matKhau = matKhauController.text;
    final String namSinh = namSinhController.text;
    final String cMND = cMNDController.text;
    final String bHYT = bHYTController.text;
    final String sDT = sDTController.text;
    String url = 'http://192.168.1.10:4333/khachhang/create';
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'HoTen': name,
        'GioiTinh': gender ? 'Nữ' : 'Nam',
        'TaiKhoan': taiKhoan,
        'MatKhau': matKhau,
        'NamSinh': namSinh,
        'CMND': cMND,
        'BHYT': bHYT,
        'SDT': sDT
      }),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var log = decodedResponse["Data"];
        print(log);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(
                child: Text(
                    'Cant connect to the server right now. Please try again later'))));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            color: Colors.white,
            width: screenWidth,
            height: screenHeight,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: screenWidth * 0.08,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4BC848), width: 2),
                            ),
                            labelText: 'Họ tên',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giới tính',
                              style: TextStyle(fontSize: screenWidth * 0.03),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  gender = !gender;
                                });
                              },
                              icon: Icon(
                                gender ? Icons.female : Icons.male,
                                color: gender ? Colors.pink : Colors.blue,
                                size: screenWidth * 0.08,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: cMNDController,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4BC848), width: 2),
                            ),
                            labelText: 'CMND',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.2,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: namSinhController,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4BC848), width: 2),
                            ),
                            labelText: 'Năm sinh',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  child: SizedBox(
                    width: screenWidth,
                    child: TextField(
                      controller: taiKhoanController,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff4BC848), width: 2),
                        ),
                        labelText: 'Tài khoản',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: screenWidth * 0.03, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  child: SizedBox(
                    width: screenWidth,
                    child: TextField(
                      controller: matKhauController,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff4BC848), width: 2),
                        ),
                        labelText: 'Mật khẩu',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: screenWidth * 0.03, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: SizedBox(
                    width: screenWidth,
                    child: TextField(
                      controller: bHYTController,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff4BC848), width: 2),
                        ),
                        labelText: 'Bảo hiểm y tế',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: screenWidth * 0.03, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  child: SizedBox(
                    width: screenWidth,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: sDTController,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff4BC848), width: 2),
                        ),
                        labelText: 'Số điện thoại',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: screenWidth * 0.03, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                  child: Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff4BC848),
                          Color(0xff56cfe1),
                        ],
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          register();
                        });
                      },
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                            color: Colors.white, fontSize: screenWidth * 0.05),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
