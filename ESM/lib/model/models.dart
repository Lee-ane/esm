import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  String urlHead = 'http://192.168.1.11:8080/api';

  //clear data
  void clearData() {
    hoTen = '';
    taiKhoan = '';
    matKhau = '';
    gioiTinh = '';
    sdt = '';
    ngaySinh = DateTime.now();
    cMND = '';
    bHYT = '';
    diaChi = '';
    goiKham = [];
    giaGoi = [];
    chuyenKhoa = [];
    noiKham = [];
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

  //GioiTinh
  String gioiTinh = '';
  void setGioiTinh(String gender) {
    gioiTinh = gender;
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

  //goiKham
  List<String> goiKham = [];
  void setGoiKham(List<String> list) {
    goiKham = list;
    notifyListeners();
  }

  //GiaGoiKham
  List<int> giaGoi = [];
  void setGiaGoi(List<int> list) {
    giaGoi = list;
    notifyListeners();
  }

  //chuyenKhoa
  List<String> chuyenKhoa = [];
  void setChuyenKhoa(List<String> list) {
    chuyenKhoa = list;
    notifyListeners();
  }

  //noiKham
  List<String> noiKham = [];
  void setNoiKham(List<String> list) {
    noiKham = list;
    notifyListeners();
  }
}
