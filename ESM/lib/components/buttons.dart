// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:esm/components/dlmap.dart';
import 'package:esm/components/style.dart';
import 'package:esm/dashboard.dart';
import 'package:esm/model/data.dart';
import 'package:esm/model/models.dart';
import 'package:esm/pages/auth/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ContactBtn extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  const ContactBtn({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(onPressed: onPressed, child: child),
    );
  }
}

class ReturnBtn extends StatelessWidget {
  const ReturnBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashBoard()));
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ));
  }
}

class SaveTienSuBtn extends StatefulWidget {
  final void Function()? onPressed;
  const SaveTienSuBtn({super.key, required this.onPressed});

  @override
  State<SaveTienSuBtn> createState() => _SaveTienSuBtnState();
}

class _SaveTienSuBtnState extends State<SaveTienSuBtn> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: widget.onPressed,
        child: const Text(
          'Lưu',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class RegistryBtn extends StatefulWidget {
  final KhachHangInfo khachHangInfo;
  const RegistryBtn({super.key, required this.khachHangInfo});

  @override
  State<RegistryBtn> createState() => _RegistryBtnState();
}

class _RegistryBtnState extends State<RegistryBtn> {
  String urlHead = '';

  Future<void> register() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    String url = '$urlHead/khachhang/create';
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'HoTen': widget.khachHangInfo.name,
        'GioiTinh': widget.khachHangInfo.gioiTinh,
        'TaiKhoan': widget.khachHangInfo.taiKhoan,
        'MatKhau': widget.khachHangInfo.matKhau,
        'NamSinh': widget.khachHangInfo.namSinh,
        'DiaChi': widget.khachHangInfo.diaChi,
        'CMND': widget.khachHangInfo.cMND,
        'BHYT': widget.khachHangInfo.bHYT,
        'SDT': widget.khachHangInfo.sDT
      }),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        context.read<DataModel>().setTaiKhoan(widget.khachHangInfo.taiKhoan);
        context.read<DataModel>().setMatKhau(widget.khachHangInfo.matKhau);
        scaffoldMessenger.showSnackBar(const SnackBar(
            content: Center(child: Text('Đăng ký tài khoản thành công'))));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } else {
        scaffoldMessenger.showSnackBar(const SnackBar(
            content: Center(child: Text('Đăng ký không thành công'))));
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
    urlHead = context.read<DataModel>().urlHead;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor,
              const Color(0xff56cfe1),
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
            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.05),
          ),
        ),
      ),
    );
  }
}

class MapIconBtn extends StatelessWidget {
  const MapIconBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MapDL()));
      },
      icon: Icon(
        Icons.location_on,
        color: primaryColor,
      ),
    );
  }
}
