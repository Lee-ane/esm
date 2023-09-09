// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

String urlHead = 'http://192.168.1.12:8080/api';

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

  Future<dynamic> fetchTTLS(int maKH) async {
    String url = '$urlHead/BenhAn/TinhTrangLucSinh/$maKH';

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

  Future<List<bool>> fetchYeuToNC(int maKH) async {
    String url = '$urlHead/BenhAn/yeutonguycosuckhoe/$maKH';
    List<bool> list = [];
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        list.add(data['ThoaiHoaCotSongThatLung']);
        list.add(data['ThoaiHoaCotCstl']);
        list.add(data['SuyTinhMachChiDuoi']);
        list.add(data['ViemReThanKinhCS']);
        list.add(data['ViemDaDay']);
        list.add(data['ViemAmidan']);
        list.add(data['ViemHongCap']);
        list.add(data['ViemHongManTinh']);
        list.add(data['ViemThanhQuan']);
        list.add(data['ViemKetMacMPT']);
        list.add(data['ViemMuiHongCap']);
        list.add(data['ViemMuiXoang']);
        list.add(data['ViemMuiDiUng']);
        list.add(data['ViemTuyR23']);
        list.add(data['ViemTuyR35']);
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
    return list;
  }

  Future<List<bool>> fetchKT(int maKH) async {
    String url = '$urlHead/BenhAn/KhuyetTat/$maKH';
    List<bool> list = [];
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        list.add(data['ThoatViDiaDem']);
        list.add(data['TatKhucXa']);
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
    return list;
  }

  Future<Map<String, dynamic>> fetchTSB(int maKH) async {
    String url = '$urlHead/BenhAn/TieuSuBenh/$maKH';
    List<bool> list = [];
    String string = '';
    Map<String, dynamic> result = {};
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        list.add(data['DiUng']);
        list.add(data['MaTuy']);
        list.add(data['RuouBia']);
        list.add(data['ThuocLa']);
        list.add(data['ThuocLao']);
        list.add(data['Khac']);
        string = data['ChiTiet'];
        result = {
          'string': string,
          'list': list,
        };
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
    return result;
  }

  Future<dynamic> fetchTSPT(int maKH) async {
    String url = '$urlHead/BenhAn/TienSuPhauThuat/$maKH';
    dynamic data = {};
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        data = decodedResponse['data'];
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
    return data;
  }

  Future<Map<String, dynamic>> fetchTSCha(int maKH) async {
    String url = '$urlHead/TienSuCha/$maKH';
    List<bool> list = [];
    String string = '';
    Map<String, dynamic> result = {};
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        list.add(data['DiUng']);
        list.add(data['MaTuy']);
        list.add(data['RuouBia']);
        list.add(data['ThuocLa']);
        list.add(data['ThuocLao']);
        list.add(data['Khac']);
        string = data['Chitiet'];
        result = {
          'string': string,
          'list': list,
        };
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
    return result;
  }

  Future<Map<String, dynamic>> fetchTSMe(int maKH) async {
    String url = '$urlHead/tieusume/$maKH';
    List<bool> list = [];
    String string = '';
    Map<String, dynamic> result = {};
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        list.add(data['DiUng']);
        list.add(data['MaTuy']);
        list.add(data['RuouBia']);
        list.add(data['ThuocLa']);
        list.add(data['ThuocLao']);
        list.add(data['Khac']);
        string = data['Chitiet'];
        result = {
          'string': string,
          'list': list,
        };
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
    return result;
  }

  Future<Map<String, dynamic>> fetchTSON(int maKH) async {
    String url = '$urlHead/tieusuongnoi/$maKH';
    List<bool> list = [];
    String string = '';
    Map<String, dynamic> result = {};
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        list.add(data['DiUng']);
        list.add(data['MaTuy']);
        list.add(data['RuouBia']);
        list.add(data['ThuocLa']);
        list.add(data['ThuocLao']);
        list.add(data['Khac']);
        string = data['Chitiet'];
        result = {
          'string': string,
          'list': list,
        };
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
    return result;
  }

  Future<Map<String, dynamic>> fetchTSBN(int maKH) async {
    String url = '$urlHead/tieusubanoi/$maKH';
    List<bool> list = [];
    String string = '';
    Map<String, dynamic> result = {};
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        list.add(data['DiUng']);
        list.add(data['MaTuy']);
        list.add(data['RuouBia']);
        list.add(data['ThuocLa']);
        list.add(data['ThuocLao']);
        list.add(data['Khac']);
        string = data['Chitiet'];
        result = {
          'string': string,
          'list': list,
        };
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
    return result;
  }

  Future<Map<String, dynamic>> fetchTSONgoai(int maKH) async {
    String url = '$urlHead/tieusuongngoai/$maKH';
    List<bool> list = [];
    String string = '';
    Map<String, dynamic> result = {};
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        list.add(data['DiUng']);
        list.add(data['MaTuy']);
        list.add(data['RuouBia']);
        list.add(data['ThuocLa']);
        list.add(data['ThuocLao']);
        list.add(data['Khac']);
        string = data['Chitiet'];
        result = {
          'string': string,
          'list': list,
        };
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
    return result;
  }

  Future<Map<String, dynamic>> fetchTSBNgoai(int maKH) async {
    String url = '$urlHead/tieusubangoai/$maKH';
    List<bool> list = [];
    String string = '';
    Map<String, dynamic> result = {};
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var data = decodedResponse['data'];
        list.add(data['DiUng']);
        list.add(data['MaTuy']);
        list.add(data['RuouBia']);
        list.add(data['ThuocLa']);
        list.add(data['ThuocLao']);
        list.add(data['Khac']);
        string = data['Chitiet'];
        result = {
          'string': string,
          'list': list,
        };
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
    return result;
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

  Future<String> traCuu(String CMND) async {
    String url = '$urlHead/BenhAn/$CMND';
    String taiKhoan = '';
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
        taiKhoan = log;
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
    return taiKhoan;
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

  Future<void> submitBADT(
      int maKH,
      int chieuCao,
      int canNang,
      String nhomMau,
      int canNangLS,
      String tinhTrang,
      int ThoaiHoaCotSongThatLung,
      int ThoaiHoaCotCstl,
      int SuyTinhMachChiDuoi,
      int ViemReThanKinhCS,
      int ViemDaDay,
      int ViemAmidan,
      int ViemHongCap,
      int ViemHongManTinh,
      int ViemThanhQuan,
      int ViemKetMacMPT,
      int ViemMuiHongCap,
      int ViemMuiXoang,
      int ViemMuiDiUng,
      int ViemTuyR23,
      int ViemTuyR35,
      int ThoatViDiaDem,
      int TatKhucXa,
      int DiUng,
      int MaTuy,
      int RuouBia,
      int ThuocLa,
      int ThuocLao,
      int Khac,
      String ChiTiet,
      int DiUngC,
      int MaTuyC,
      int RuouBiaC,
      int ThuocLaC,
      int ThuocLaoC,
      int KhacC,
      String ChiTietC,
      int DiUngM,
      int MaTuyM,
      int RuouBiaM,
      int ThuocLaM,
      int ThuocLaoM,
      int KhacM,
      String ChiTietM,
      int DiUngON,
      int MaTuyON,
      int RuouBiaON,
      int ThuocLaON,
      int ThuocLaoON,
      int KhacON,
      String ChiTietON,
      int DiUngBN,
      int MaTuyBN,
      int RuouBiaBN,
      int ThuocLaBN,
      int ThuocLaoBN,
      int KhacBN,
      String ChiTietBN,
      int DiUngONg,
      int MaTuyONg,
      int RuouBiaONg,
      int ThuocLaONg,
      int ThuocLaoONg,
      int KhacONg,
      String ChiTietONg,
      int DiUngBNg,
      int MaTuyBNg,
      int RuouBiaBNg,
      int ThuocLaBNg,
      int ThuocLaoBNg,
      int KhacBNg,
      String ChiTietBNg) async {
    String url1 = '$urlHead/BenhAn/create';
    var headers = {
      'Content-Type': 'application/json',
    };
    final response1 = await http.post(
      Uri.parse(url1),
      body: json.encode({
        'Makh': maKH,
        'NgayTao': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'ChieuCao': chieuCao,
        'CanNang': canNang,
        'NhomMau': nhomMau,
      }),
      headers: headers,
    );
    try {
      if (response1.statusCode == 200) {
        String url2 = '$urlHead/BenhAn/TinhTrangLucSinh';
        var headers = {
          'Content-Type': 'application/json',
        };
        final response2 = await http.post(
          Uri.parse(url2),
          body: json.encode({
            'Makh': maKH,
            'TinhTrang': tinhTrang,
            'CanNang': canNangLS,
          }),
          headers: headers,
        );
        if (response2.statusCode == 200) {
          String url3 = '$urlHead/BenhAn/YeuToNC';
          var headers = {
            'Content-Type': 'application/json',
          };
          final response3 = await http.post(
            Uri.parse(url3),
            body: json.encode({
              'Makh': maKH,
              'ThoaiHoaCotSongThatLung': ThoaiHoaCotSongThatLung,
              'ThoaiHoaCotCstl': ThoaiHoaCotCstl,
              'SuyTinhMachChiDuoi': SuyTinhMachChiDuoi,
              'ViemReThanKinhCS': ViemReThanKinhCS,
              'ViemDaDay': ViemDaDay,
              'ViemAmidan': ViemAmidan,
              'ViemHongCap': ViemHongCap,
              'ViemHongManTinh': ViemHongManTinh,
              'ViemThanhQuan': ViemThanhQuan,
              'ViemKetMacMPT': ViemKetMacMPT,
              'ViemMuiHongCap': ViemMuiHongCap,
              'ViemMuiXoang': ViemMuiXoang,
              'ViemMuiDiUng': ViemMuiDiUng,
              'ViemTuyR23': ViemTuyR23,
              'ViemTuyR35': ViemTuyR35
            }),
            headers: headers,
          );
          if (response3.statusCode == 200) {
            String url4 = '$urlHead/BenhAn/KhuyetTat';
            var headers = {
              'Content-Type': 'application/json',
            };
            final response4 = await http.post(
              Uri.parse(url4),
              body: json.encode({
                'Makh': maKH,
                'ThoatViDiaDem': ThoatViDiaDem,
                'TatKhucXa': TatKhucXa
              }),
              headers: headers,
            );
            if (response4.statusCode == 200) {
              String url5 = '$urlHead/BenhAn/TieuSuBenh';
              var headers = {
                'Content-Type': 'application/json',
              };
              final response5 = await http.post(
                Uri.parse(url5),
                body: json.encode({
                  'Makh': maKH,
                  'DiUng': DiUng,
                  'MaTuy': MaTuy,
                  'RuouBia': RuouBia,
                  'ThuocLa': ThuocLa,
                  'ThuocLao': ThuocLao,
                  'Khac': Khac,
                  'ChiTiet': ChiTiet
                }),
                headers: headers,
              );
              if (response5.statusCode == 200) {
                String url6 = '$urlHead/TienSuCha';
                var headers = {
                  'Content-Type': 'application/json',
                };
                final response6 = await http.post(
                  Uri.parse(url6),
                  body: json.encode({
                    'Makh': maKH,
                    'DiUng': DiUngC,
                    'MaTuy': MaTuyC,
                    'RuouBia': RuouBiaC,
                    'ThuocLa': ThuocLaC,
                    'ThuocLao': ThuocLaoC,
                    'Khac': KhacC,
                    'ChiTiet': ChiTietC
                  }),
                  headers: headers,
                );
                if (response6.statusCode == 200) {
                  String url7 = '$urlHead/tieusume';
                  var headers = {
                    'Content-Type': 'application/json',
                  };
                  final response7 = await http.post(
                    Uri.parse(url7),
                    body: json.encode({
                      'Makh': maKH,
                      'DiUng': DiUngM,
                      'MaTuy': MaTuyM,
                      'RuouBia': RuouBiaM,
                      'ThuocLa': ThuocLaM,
                      'ThuocLao': ThuocLaoM,
                      'Khac': KhacC,
                      'ChiTiet': ChiTietC
                    }),
                    headers: headers,
                  );
                  if (response7.statusCode == 200) {
                    String url8 = '$urlHead/tieusuongnoi';
                    var headers = {
                      'Content-Type': 'application/json',
                    };
                    final response8 = await http.post(
                      Uri.parse(url8),
                      body: json.encode({
                        'Makh': maKH,
                        'DiUng': DiUngON,
                        'MaTuy': MaTuyON,
                        'RuouBia': RuouBiaON,
                        'ThuocLa': ThuocLaON,
                        'ThuocLao': ThuocLaoON,
                        'Khac': KhacON,
                        'ChiTiet': ChiTietON
                      }),
                      headers: headers,
                    );
                    if (response8.statusCode == 200) {
                      String url9 = '$urlHead/tieusubanoi';
                      var headers = {
                        'Content-Type': 'application/json',
                      };
                      final response9 = await http.post(
                        Uri.parse(url9),
                        body: json.encode({
                          'Makh': maKH,
                          'DiUng': DiUngBN,
                          'MaTuy': MaTuyBN,
                          'RuouBia': RuouBiaBN,
                          'ThuocLa': ThuocLaBN,
                          'ThuocLao': ThuocLaoBN,
                          'Khac': KhacBN,
                          'ChiTiet': ChiTietBN
                        }),
                        headers: headers,
                      );
                      if (response9.statusCode == 200) {
                        String url10 = '$urlHead/tieusuongngoai';
                        var headers = {
                          'Content-Type': 'application/json',
                        };
                        final response10 = await http.post(
                          Uri.parse(url10),
                          body: json.encode({
                            'Makh': maKH,
                            'DiUng': DiUngONg,
                            'MaTuy': MaTuyONg,
                            'RuouBia': RuouBiaONg,
                            'ThuocLa': ThuocLaONg,
                            'ThuocLao': ThuocLaoONg,
                            'Khac': KhacONg,
                            'ChiTiet': ChiTietONg
                          }),
                          headers: headers,
                        );
                        if (response10.statusCode == 200) {
                          String url11 = '$urlHead/tieusubangoai';
                          var headers = {
                            'Content-Type': 'application/json',
                          };
                          final response11 = await http.post(
                            Uri.parse(url11),
                            body: json.encode({
                              'Makh': maKH,
                              'DiUng': DiUngBNg,
                              'MaTuy': MaTuyBNg,
                              'RuouBia': RuouBiaBNg,
                              'ThuocLa': ThuocLaBNg,
                              'ThuocLao': ThuocLaoBNg,
                              'Khac': KhacBNg,
                              'ChiTiet': ChiTietBNg
                            }),
                            headers: headers,
                          );
                          if (response11.statusCode == 200) {}
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      } else {
        if (kDebugMode) {
          print(response1.statusCode);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
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
