import 'package:esm/components/buttons.dart';
import 'package:esm/components/style.dart';
import 'package:esm/model/data.dart';
import 'package:esm/model/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
      diaChiController = TextEditingController(),
      cMNDController = TextEditingController(),
      bHYTController = TextEditingController(),
      sDTController = TextEditingController();

  bool gender = true;
  String selected = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    DateTime selectedDate = context.read<DataModel>().ngaySinh;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: screenWidth,
            height: screenHeight,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      'Đăng ký',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.07,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.1),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
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
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: cMNDController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
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
                          readOnly: true,
                          controller: namSinhController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
                            ),
                            labelText: 'Năm sinh',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.grey),
                          ),
                          style: TextStyle(fontSize: screenWidth * 0.035),
                          onTap: () async {
                            DateTime? datetime = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100));
                            datetime ??= DateTime.now();
                            setState(() {
                              namSinhController.text =
                                  DateFormat('dd-MM-yyyy').format(datetime!);
                              selected =
                                  DateFormat('yyyy-MM-dd').format(datetime);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: SizedBox(
                    width: screenWidth,
                    child: TextField(
                      controller: taiKhoanController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 2),
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
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: SizedBox(
                    width: screenWidth,
                    child: TextField(
                      obscureText: true,
                      controller: matKhauController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 2),
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
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 2),
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
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: SizedBox(
                    width: screenWidth,
                    child: TextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: sDTController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 2),
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
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.1,
                    child: TextField(
                      maxLines: 2,
                      controller: diaChiController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        labelText: 'Địa chỉ',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: screenWidth * 0.03, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                RegistryBtn(
                    khachHangInfo: KhachHangInfo(
                  name: nameController.text,
                  gioiTinh: gender ? 'Nữ' : 'Nam',
                  taiKhoan: taiKhoanController.text,
                  matKhau: matKhauController.text,
                  namSinh: selected,
                  diaChi: diaChiController.text,
                  cMND: cMNDController.text,
                  bHYT: bHYTController.text,
                  sDT: sDTController.text,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
