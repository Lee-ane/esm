// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:esm/components/style.dart';
import 'package:esm/model/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:esm/components/buttons.dart';
import 'package:esm/components/forms.dart';
import 'package:esm/model/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BenhAnDienTu extends StatefulWidget {
  const BenhAnDienTu({super.key});

  @override
  State<BenhAnDienTu> createState() => _BenhAnDienTuState();
}

class _BenhAnDienTuState extends State<BenhAnDienTu> {
  bool editable = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final List<ExpansionTileData> titleData = [
      ExpansionTileData('Thông tin thành viên', Form1(editable: editable)),
      ExpansionTileData('Tình trạng lúc sinh', Form2(editable: editable)),
      ExpansionTileData(
          'Yếu tố nguy cơ đối với sức khỏe cá nhân', const Form3()),
      ExpansionTileData('Khuyết tật', const Form4()),
      ExpansionTileData('Tiền sử bệnh tật, dị ứng', const Form5()),
      ExpansionTileData('Tiền sử phẩu thuật', const Form6()),
      ExpansionTileData('Tiền sử gia đình', const Form7()),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (editable == true) {}
                editable = !editable;
              });
            },
            icon: Icon(
              editable ? Icons.save : Icons.create,
              color: Colors.white,
            ),
          ),
        ],
        leading: const ReturnBtn(),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Bệnh án điện tử',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.location_history,
                  color: primaryColor,
                  size: screenWidth * 0.3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                child: Center(
                  child: Text(
                    'Thông tin thành viên',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
              //
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.68,
                child: ListView(
                  children: titleData.map((data) {
                    return ExpansionChild(data: data);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//ExspansionTile Container
class _ExpansionContainerTile extends StatefulWidget {
  final Widget title;
  final ValueChanged<bool> onExpansionChanged;
  final Widget expandedContent;

  const _ExpansionContainerTile({
    required this.title,
    required this.onExpansionChanged,
    required this.expandedContent,
  });

  @override
  __ExpansionContainerTileState createState() =>
      __ExpansionContainerTileState();
}

class __ExpansionContainerTileState extends State<_ExpansionContainerTile> {
  String urlHead = '';
  bool _expanded = false;
  dynamic data = [];

  Future<void> fetchUser() async {
    String url = '$urlHead/khachhang';
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({'taiKhoan': context.read<DataModel>().taiKhoan}),
      headers: headers,
    );
    try {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        var log = decodedResponse["data"];
        data = log;
        context.read<DataModel>().setSDT(data['SDT']);
        context.read<DataModel>().setNgaySinh(DateTime.parse(data['NamSinh']));
        context.read<DataModel>().setCMND(data['CMND']);
        context.read<DataModel>().setBHYT(data['BHYT']);
        context.read<DataModel>().setDiaChi(data['DiaChi']);
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

  @override
  void initState() {
    super.initState();
    urlHead = context.read<DataModel>().urlHead;
    if (context.read<DataModel>().cMND.isEmpty) {
      fetchUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: screenWidth,
            height: screenHeight * 0.05,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: _expanded
                  ? const BorderRadius.vertical(
                      top: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                  if (_expanded == true &&
                      context.read<DataModel>().cMND.isEmpty) {
                    fetchUser();
                  }
                });
                widget.onExpansionChanged(_expanded);
              },
              child: widget.title,
            ),
          ),
          if (_expanded) widget.expandedContent,
        ],
      ),
    );
  }
}

//ExpansionTile Child
class ExpansionChild extends StatefulWidget {
  final ExpansionTileData data;
  const ExpansionChild({super.key, required this.data});

  @override
  State<ExpansionChild> createState() => _ExpansionChildState();
}

class _ExpansionChildState extends State<ExpansionChild> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return _ExpansionContainerTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.data.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04,
            ),
          ),
          Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.white,
          )
        ],
      ),
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      expandedContent: widget.data.expandedForm,
    );
  }
}
