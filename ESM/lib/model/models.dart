import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  String urlHead = 'http://192.168.1.21:8080/api';
  String getUrlHead() => urlHead;

  //clear data
  void clearData() {
    editable = false;
    hoTen = '';
    taiKhoan = '';
    matKhau = '';
    sdt = '';
    ngaySinh = DateTime.now();
    cMND = '';
    bHYT = '';
    diaChi = '';
    notifyListeners();
  }

  //toggle
  bool editable = false;
  void toggle(bool edit) {
    editable = edit;
    notifyListeners();
  }

  //HoTen
  String hoTen = '';
  void setHoTen(String name) {
    hoTen = name;
    notifyListeners();
  }

  //Username
  String taiKhoan = '';
  void setTaiKhoan(String username) {
    taiKhoan = username;
    notifyListeners();
  }

  //Password
  String matKhau = '';
  void setMatKhau(String pass) {
    matKhau = pass;
    notifyListeners();
  }

  //Sdt
  String sdt = '';
  void setSDT(String phone) {
    sdt = phone;
    notifyListeners();
  }

  //NgaySinh
  DateTime ngaySinh = DateTime.now();
  void setNgaySinh(DateTime date) {
    ngaySinh = date;
    notifyListeners();
  }

  //CMND
  String cMND = '';
  void setCMND(String cmnd) {
    cMND = cmnd;
    notifyListeners();
  }

  //BHYT
  String bHYT = '';
  void setBHYT(String bhyt) {
    bHYT = bhyt;
    notifyListeners();
  }

  //DiaChi
  String diaChi = '';
  void setDiaChi(String diachi) {
    diaChi = diachi;
    notifyListeners();
  }
}
