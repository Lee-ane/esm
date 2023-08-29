import 'package:flutter/material.dart';

class ListItem {
  final String title;

  ListItem(this.title);
}

class ExpansionTileData {
  final String title;
  final Widget expandedForm;

  ExpansionTileData(this.title, this.expandedForm);
}

class CheckBoxTileListItem {
  final String title;
  late final bool checked;

  CheckBoxTileListItem(this.title, this.checked);
}

class Options {
  final IconData icon;
  final String title;
  final void Function()? onPressed;

  Options(this.icon, this.title, this.onPressed);
}

class KhachHangInfo {
  final String name;
  final String gioiTinh;
  final String taiKhoan;
  final String matKhau;
  final String namSinh;
  final String diaChi;
  final String cMND;
  final String bHYT;
  final String sDT;
  KhachHangInfo(
      {required this.name,
      required this.gioiTinh,
      required this.taiKhoan,
      required this.matKhau,
      required this.namSinh,
      required this.diaChi,
      required this.cMND,
      required this.bHYT,
      required this.sDT});
}

class ThongTinDatLich{
  final String loaiDK;
  final String hoTen;
  final int sDT;
  final String diaChi;
  final String gioiTinh;
  final DateTime namSinh;
  final int maPK;
  final int maCK;
  final int maGK;
  final int giaTien;
  final String trieuChung;
  final DateTime ngayKham;

  ThongTinDatLich({required this.loaiDK, required this.hoTen, required this.sDT, required this.diaChi, required this.gioiTinh, required this.namSinh, required this.maPK, required this.maCK, required this.maGK, required this.giaTien, required this.trieuChung, required this.ngayKham});
}