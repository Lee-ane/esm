import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  String urlHead = 'http://192.168.1.10:8080/api';

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
    canNang = 0;
    chieuCao = 0;
    nhomMau = '';
    canNangKS = 0;
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

  //CanNang
  int canNang = 0;
  void setCanNang(int weight) {
    canNang = weight;
    notifyListeners();
  }

  //ChieuCao
  int chieuCao = 0;
  void setChieuCao(int height) {
    chieuCao = height;
    notifyListeners();
  }

  //NhomMau
  String nhomMau = '';
  void setNhomMau(String bloodtype) {
    nhomMau = bloodtype;
    notifyListeners();
  }

  //CanNangKhiSinh
  int canNangKS = 0;
  void setCanNangKS(int kg) {
    canNangKS = kg;
    notifyListeners();
  }

  //TinhTrang
  String tinhTrang = '';
  void setTinhTrang(String note) {
    tinhTrang = note;
    notifyListeners();
  }
}
