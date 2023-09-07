// ignore_for_file: use_build_context_synchronously

import 'package:esm/components/buttons.dart';
import 'package:esm/components/style.dart';
import 'package:esm/model/data.dart';
import 'package:esm/model/models.dart';
import 'package:esm/pages/home.dart';
import 'package:esm/pages/online.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatLich extends StatefulWidget {
  const DatLich({super.key});

  @override
  State<DatLich> createState() => _DatLichState();
}

class _DatLichState extends State<DatLich> {
  dynamic data = [];

  @override
  void initState() async {
    super.initState();
    if (data.isEmpty) {
      data = await ReadData().fetchUser(context.read<DataModel>().taiKhoan);
      context.read<DataModel>().setSDT(data['SDT']);
      context.read<DataModel>().setGioiTinh(data['GioiTinh']);
      context.read<DataModel>().setNgaySinh(DateTime.parse(data['NamSinh']));
      context.read<DataModel>().setCMND(data['CMND']);
      context.read<DataModel>().setBHYT(data['BHYT']);
      context.read<DataModel>().setDiaChi(data['DiaChi']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              toolbarHeight: screenHeight * 0.05,
              backgroundColor: primaryColor,
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Đặt lịch khám online'),
                  Tab(text: 'Đặt lịch khám tại nhà'),
                ],
              ),
              title: const Text('Đặt lịch'),
              centerTitle: true,
              leading: const ReturnBtn()),
          body: data.isEmpty
              ? Center(child: CircularProgressIndicator(color: primaryColor))
              : const TabBarView(
                  children: [Online(), Home()],
                ),
        ),
      ),
    );
  }
}
