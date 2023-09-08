import 'package:esm/benh_an_dien_tu.dart';
import 'package:esm/components/buttons.dart';
import 'package:esm/components/style.dart';
import 'package:esm/components/textfields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThemTienSuPT extends StatefulWidget {
  const ThemTienSuPT({super.key});

  @override
  State<ThemTienSuPT> createState() => _ThemTienSuPTState();
}

class _ThemTienSuPTState extends State<ThemTienSuPT> {
  TextEditingController tenController = TextEditingController(),
      ngayTHController = TextEditingController(),
      gioTHController = TextEditingController(),
      ngayGMController = TextEditingController(),
      gioGMController = TextEditingController(),
      ngayBDController = TextEditingController(),
      gioBDController = TextEditingController(),
      ngayKTController = TextEditingController(),
      gioKTController = TextEditingController();

  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String time = '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';

  @override
  void initState() {
    super.initState();
    ngayTHController.text = date;
    gioTHController.text = time;
    ngayGMController.text = date;
    gioGMController.text = time;
    ngayBDController.text = date;
    gioBDController.text = time;
    ngayKTController.text = date;
    gioKTController.text = time;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: primaryColor,
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
              Column(
                children: [
                  TextField(
                    controller: tenController,
                    decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Tên phẫu thuật',
                        hintText: 'Tên phẫu thuật'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: DateTF(
                            controller: ngayTHController,
                            title: 'Ngày thực hiện'),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child:
                            TimeTF(controller: gioTHController, title: 'Giờ'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: DateTF(
                            controller: ngayGMController, title: 'Ngày gây mê'),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child:
                            TimeTF(controller: gioGMController, title: 'Giờ'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: DateTF(
                            controller: ngayBDController,
                            title: 'Ngày bắt đầu'),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child:
                            TimeTF(controller: gioBDController, title: 'Giờ'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: DateTF(
                            controller: ngayKTController,
                            title: 'Ngày kết thúc'),
                      ),
                      SizedBox(
                        width: screenWidth * 0.3,
                        child:
                            TimeTF(controller: gioKTController, title: 'Giờ'),
                      ),
                    ],
                  ),
                ],
              ),
              //Nút lưu
              Align(
                alignment: Alignment.bottomCenter,
                child: SaveTienSuBtn(onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BenhAnDienTu()));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
