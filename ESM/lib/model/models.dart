import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  String urlHead = 'http://192.168.1.9:8080/api';
  String getUrlHead() => urlHead;

  //username
  String taiKhoan = '';
  void setTaiKhoan(String username) {
    taiKhoan = username;
    notifyListeners();
  }

  String getTaiKhoan() => taiKhoan;

  //Password
  String matKhau = '';
  void setMatKhau(String pass) {
    matKhau = pass;
  }

  String getMatKhau() => matKhau;
}
