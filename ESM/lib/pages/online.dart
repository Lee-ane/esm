import 'package:esm/components/buttons.dart';
import 'package:flutter/material.dart';

class Online extends StatefulWidget {
  const Online({super.key});

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  bool atHospital = true;
  String _selectedGender = 'Giới tính';

  void _handleGenderChange(String value) {
    setState(() {
      _selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenWidth * 0.48,
                    decoration: BoxDecoration(
                      color:
                          atHospital ? const Color(0xff4CB848) : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            atHospital = true;
                          });
                        },
                        child: Text(
                          'Đặt lịch khám tại bệnh viện',
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: atHospital
                                  ? Colors.white
                                  : const Color(0xff4CB848),
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.017),
                        )),
                  ),
                  Container(
                    width: screenWidth * 0.48,
                    decoration: BoxDecoration(
                      color:
                          atHospital ? Colors.white : const Color(0xff4CB848),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            atHospital = false;
                          });
                        },
                        child: Text(
                          'Đặt lịch khám tại phòng khám',
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: atHospital
                                  ? const Color(0xff4CB848)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.017),
                        )),
                  )
                ],
              ),
              Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_history),
                  iconSize: screenWidth * 0.3,
                  color: const Color(0xff4CB848),
                ),
              ),
              const TextField(
                decoration: InputDecoration(hintText: 'Họ và tên'),
              ),
              const TextField(
                decoration: InputDecoration(hintText: 'Số điện thoại'),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Địa chỉ',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on,
                      color: Color(0xff4CB484),
                    ),
                  ),
                ),
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Text(
                        _selectedGender,
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                      RadioListTile(
                        title: const Text('Nam'),
                        value: 'Nam',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          _handleGenderChange(value!);
                        },
                      ),
                      RadioListTile(
                        title: const Text('Nữ'),
                        value: 'Nữ',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          _handleGenderChange(value!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const TextField(
                decoration: InputDecoration(hintText: 'Năm sinh'),
              ),
              Divider(
                color: Colors.brown,
                thickness: 4,
                height: screenHeight * 0.1,
              ),
              Text(
                'Thông tin nơi khám và gói khám',
                style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: const Color(0xff4CB484),
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.01),
                      child: const Icon(
                        Icons.home_work,
                        color: Color(0xff4CB484),
                      ),
                    ),
                    Text(
                      'Bệnh viên/Phòng khám gần nhất',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: const Color(0xff4CB484),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chọn nơi khám',
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
              TextField(
                onTap: () {},
                readOnly: true,
                controller: TextEditingController(text: 'Đi đến bản đồ'),
                style: const TextStyle(color: Color(0xff4CB484)),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    const Icon(
                      Icons.medical_services,
                      color: Color(0xff4BC484),
                    ),
                    Text(
                      'Chuyên khoa',
                      style: TextStyle(
                        color: const Color(0xff4BC848),
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              const TextField(
                readOnly: true,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: Icon(Icons.arrow_drop_down)),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    const Icon(
                      Icons.file_present,
                      color: Color(0xff4BC484),
                    ),
                    Text(
                      'Gói khám',
                      style: TextStyle(
                        color: const Color(0xff4BC848),
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              const TextField(
                readOnly: true,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: Icon(Icons.arrow_drop_down)),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: Color(0xff4BC484),
                    ),
                    Text(
                      'Giá',
                      style: TextStyle(
                        color: const Color(0xff4BC848),
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Color(0xff4BC484),
                    ),
                    Text(
                      'Triệu chứng',
                      style: TextStyle(
                        color: const Color(0xff4BC848),
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Triệu chứng',
                  suffixIcon: Icon(Icons.create, color: Color(0xff4BC484)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cases_rounded,
                              color: const Color(0xff4BC848),
                              size: screenWidth * 0.05,
                            ),
                            Text(
                              'Ngày khám',
                              style: TextStyle(
                                  color: const Color(0xff4bc848),
                                  fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                        TextField(
                          controller: TextEditingController(text: '22/08/2023'),
                          readOnly: true,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelText: 'Ngày dự kiến khám'),
                        ),
                        TextField(
                          controller: TextEditingController(text: '11:45'),
                          readOnly: true,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelText: 'Giờ khám'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ContactBtn(
                child: const Text(
                  'Đặt lịch hẹn',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: ContactBtn(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, color: Colors.white),
                      Text(
                        'Hotline: 19002297',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
