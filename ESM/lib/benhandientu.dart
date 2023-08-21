import 'package:esm/components/buttons.dart';
import 'package:flutter/material.dart';

class BenhAnDienTu extends StatefulWidget {
  const BenhAnDienTu({super.key});

  @override
  State<BenhAnDienTu> createState() => _BenhAnDienTuState();
}

class _BenhAnDienTuState extends State<BenhAnDienTu> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.create,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xff4BC484),
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
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.location_history,
                    color: const Color(0xff4BC848),
                    size: screenWidth * 0.3,
                  ),
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
              InfoBtn(text: 'Thông tin thành viên', onPressed: () {}),
              InfoBtn(text: 'Tình trạng lúc sinh', onPressed: () {}),
              InfoBtn(
                text: 'Yếu tố nguy co đối với sức khỏe cá nhân',
                onPressed: () {},
              ),
              InfoBtn(
                text: 'Khuyết tật',
                onPressed: () {},
              ),
              InfoBtn(
                text: 'Tiền sử bệnh tật, dị ứng',
                onPressed: () {},
              ),
              InfoBtn(
                text: 'Tiền sử phẩu thuật',
                onPressed: () {},
              ),
              InfoBtn(
                text: 'Tiền sử gia đình',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
