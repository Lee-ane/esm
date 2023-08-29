import 'package:esm/components/buttons.dart';
import 'package:esm/components/style.dart';
import 'package:esm/pages/home.dart';
import 'package:esm/pages/online.dart';
import 'package:flutter/material.dart';

class DatLich extends StatefulWidget {
  const DatLich({super.key});

  @override
  State<DatLich> createState() => _DatLichState();
}

class _DatLichState extends State<DatLich> {
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
          body: const TabBarView(
            children: [Online(), Home()],
          ),
        ),
      ),
    );
  }
}
