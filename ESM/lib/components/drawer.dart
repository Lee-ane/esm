import 'package:esm/benh_an_dien_tu.dart';
import 'package:esm/components/style.dart';
import 'package:esm/datlich.dart';
import 'package:esm/model/models.dart';
import 'package:esm/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerCtn extends StatelessWidget {
  const DrawerCtn({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Image.asset(
          'assets/esm.jpg',
          height: screenHeight * 0.3,
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.menu_book,
            color: primaryColor,
          ),
          title: Text(
            'Đặt lịch',
            style: TextStyle(
              color: primaryColor,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DatLich()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.phone_android,
            color: primaryColor,
          ),
          title: Text(
            'Bệnh án điện tử',
            style: TextStyle(
              color: primaryColor,
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BenhAnDienTu()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.search,
            color: primaryColor,
          ),
          title: Text(
            'Tra cứu bệnh án điện tử',
            style: TextStyle(
              color: primaryColor,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            context.read<DataModel>().clearData();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Welcome()));
          },
          leading: Icon(
            Icons.logout,
            color: primaryColor,
          ),
          title: Text(
            'Đăng xuất',
            style: TextStyle(color: primaryColor),
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CÔNG TY CỔ PHẨN HEALTHCARE SOLUTION VIET NAM',
                style: TextStyle(
                  color: Color(0xff023e8a),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                  'Địa chỉ: 232/7 Võ Văn Kiệt, Phường Cầu Ông Lãnh, Quận 1, Thành Phố Hồ Chí Minh'),
              Text('Liên hệ: 0917 632 112'),
              Text('Email: info@hsv.com.vn'),
            ],
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/icon.jpg', width: screenWidth * 0.3),
            Image.asset('assets/confirm.png', width: screenWidth * 0.3),
          ],
        ),
      ],
    );
  }
}
