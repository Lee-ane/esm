import 'package:esm/components/buttons.dart';
import 'package:esm/components/textfields.dart';
import 'package:flutter/material.dart';

class ThemTienSuPT extends StatefulWidget {
  const ThemTienSuPT({super.key});

  @override
  State<ThemTienSuPT> createState() => _ThemTienSuPTState();
}

class _ThemTienSuPTState extends State<ThemTienSuPT> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const ReturnBtn(),
        backgroundColor: const Color(0xff4BC484),
        centerTitle: true,
        title: const Text(
          'Thêm tiền sử phẫu thuật',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              const Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Tên phẫu thuật',
                        hintText: 'Tên phẫu thuật'),
                  ),
                  TienSuPTFT(title: 'Ngày thực hiện'),
                  TienSuPTFT(title: 'Thời gian gây mê'),
                  TienSuPTFT(title: 'Thời gian bắt đầu'),
                  TienSuPTFT(title: 'Thời gian kết thúc'),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: const Color(0xff4BC848),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Lưu',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
