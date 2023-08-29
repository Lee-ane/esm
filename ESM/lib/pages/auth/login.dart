// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:esm/components/style.dart';
import 'package:esm/dashboard.dart';
import 'package:esm/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  String urlHead = '';

  Future<void> login() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String username = usernameController.text;
    String password = passwordController.text;
    String url = '$urlHead/login';
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'taiKhoan': username,
        'matKhau': password,
      }),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var log = decodedResponse["data"];
        var name = log["name"];
        var username = log["username"];
        context.read<DataModel>().setHoTen(name);
        context.read<DataModel>().setTaiKhoan(username);
        scaffoldMessenger.showSnackBar(
            SnackBar(content: Center(child: Text('Xin chào, $name'))));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashBoard()));
      } else if (response.statusCode == 401) {
        scaffoldMessenger.showSnackBar(const SnackBar(
            content: Center(child: Text('Tài khoản không đúng'))));
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
    if (context.read<DataModel>().taiKhoan.isNotEmpty) {
      usernameController.text = context.read<DataModel>().taiKhoan;
      passwordController.text = context.read<DataModel>().matKhau;
    }
    if (usernameController.text.isNotEmpty) {
      Future.delayed(const Duration(seconds: 3), () {
        login();
      });
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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Image.asset('assets/esm.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2),
                      ),
                      labelText: 'Tên đăng nhập',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                          fontSize: screenWidth * 0.03, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 2),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            size: screenWidth * 0.05,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          }),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Mật khẩu',
                      hintStyle: TextStyle(
                          fontSize: screenWidth * 0.03, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1),
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
                        login();
                      },
                      child: Text(
                        'Đăng nhập',
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
