import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

String urlHead = 'http://192.168.1.8:8080/api';

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

List<CheckBoxTileListItem> checkBoxTitleNC = [
  CheckBoxTileListItem(
    'Thoái hóa cột sống thắt lưng, gai xơ xương l4,l5, đau căng cơ cstl, viêm rễ thần kinh cstl / gerd, suy tĩnh mạch (mạn) (ngoại biên)',
    false,
  ),
  CheckBoxTileListItem(
    'Thoái hóa cột sống thắt lưng, gai xơ xương l4,l5, đau căng cơ cstl, viêm rễ thần kinh cstl / gerd, suy tĩnh mạch (mạn) (ngoại biên);',
    false,
  ),
  CheckBoxTileListItem(
    'Thoái hóa cột cstl, gai xương thân sống l4,l5, đau căng cơ cột sống hạ calci, suy tĩnh mạch đùi sâu chi dưới 2 bên',
    false,
  ),
  CheckBoxTileListItem(
    'Thoái hóa cstl, gai xương thân sống l4,l5, rễ thần kinh cs, suy tĩnh mạch (mạn) (ngoại biên)',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm dạ dày và tá tràng',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm họng - Amidan đợt cấp',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm họng cấp',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm họng mạn tính đợt cấp',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm họng thanh quản mạn',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm kết mạc MPT',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm mũi họng cấp',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm mũi họng cấp [cảm thường]; Viêm mũi xoang - Viêm họng cấp',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm mũi họng cấp; Viêm mũi dị ứng',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm tủy/R23',
    false,
  ),
  CheckBoxTileListItem(
    'Viêm tủy/R35',
    false,
  ),
];

List<CheckBoxTileListItem> checkBoxTitleDU = [
  CheckBoxTileListItem(
    'Dị ứng',
    false,
  ),
  CheckBoxTileListItem(
    'Ma túy',
    false,
  ),
  CheckBoxTileListItem(
    'Rượu bia',
    false,
  ),
  CheckBoxTileListItem(
    'Thuốc lá',
    false,
  ),
  CheckBoxTileListItem(
    'Thuốc lào',
    false,
  ),
  CheckBoxTileListItem(
    'Khác',
    false,
  ),
];

List<CheckBoxTileListItem> checkBoxTitleKT = [
  CheckBoxTileListItem(
    'Thoát vị đĩa đệm',
    false,
  ),
  CheckBoxTileListItem(
    'Tật khúc xạ',
    false,
  ),
];

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

class ThongTinDatLich {
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

  ThongTinDatLich(
      {required this.loaiDK,
      required this.hoTen,
      required this.sDT,
      required this.diaChi,
      required this.gioiTinh,
      required this.namSinh,
      required this.maPK,
      required this.maCK,
      required this.maGK,
      required this.giaTien,
      required this.trieuChung,
      required this.ngayKham});
}

class ReadData {
  Future<dynamic> fetchUser(String taiKhoan) async {
    String url = '$urlHead/khachhang/$taiKhoan';

    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        return data;
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

  Future<dynamic> fetchPK() async {
    String url = '$urlHead/phongKham';
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
        return log;
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
}

class Submit {
  Future<String> submit(int maKH, int maCK, String diaChi, String loaiDK,
      String tgKham, String trieuChung, int maGK, int maPK) async {
    String url = '$urlHead/PhieuDK';
    String log = '';
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'Makh': maKH,
        'MaCK': maCK,
        'DiaChi': diaChi,
        'loaiDK': loaiDK,
        'TGKham': tgKham,
        'TrieuChung': trieuChung,
        'MaGK': maGK,
        'MaPK': maPK
      }),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        log = decodedResponse["message"];
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
    return log;
  }
}

class MapData {
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(10.7447, 106.6964),
    zoom: 18,
  );

  Future<void> getPermisson() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Unable to get your location');
      }
    }
  }
}
