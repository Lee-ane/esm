import 'package:esm/components/buttons.dart';
import 'package:esm/components/map.dart';
import 'package:esm/components/style.dart';
import 'package:esm/model/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Online extends StatefulWidget {
  const Online({super.key});

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  bool atHospital = true;
  String _selectedGender = 'Giới tính';
  String selectedGK = '';
  List<String> goiKhamList = [];
  List<String> chuyenKhoaList = [];
  String noiKham = 'Chọn nơi khám';
  String selectedCK = '';
  int index = 0;

  TextEditingController nameController = TextEditingController(),
      sDTController = TextEditingController(),
      diaChiController = TextEditingController(),
      namSinhController = TextEditingController(),
      trieuChungController = TextEditingController(),
      ngayKhamController = TextEditingController(),
      gioKhamController = TextEditingController();

  void _handleGenderChange(String value) {
    setState(() {
      _selectedGender = value;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.text = context.read<DataModel>().hoTen;
    sDTController.text = context.read<DataModel>().sdt;
    diaChiController.text = context.read<DataModel>().diaChi;
    _selectedGender = context.read<DataModel>().gioiTinh;
    namSinhController.text =
        DateFormat('dd-MM-yyyy').format(context.read<DataModel>().ngaySinh);
    ngayKhamController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    gioKhamController.text =
        '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
    goiKhamList = context.read<DataModel>().goiKham;
    selectedGK = goiKhamList[0];
    chuyenKhoaList = context.read<DataModel>().chuyenKhoa;
    selectedCK = chuyenKhoaList[0];
    noiKham = context.read<DataModel>().noiKham;
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenWidth * 0.48,
                      decoration: BoxDecoration(
                        color: atHospital ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              atHospital = true;
                              print(atHospital);
                            });
                          },
                          child: Text(
                            'Đặt lịch khám tại bệnh viện',
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: atHospital ? Colors.white : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.017),
                          )),
                    ),
                    Container(
                      width: screenWidth * 0.48,
                      decoration: BoxDecoration(
                        color: atHospital ? Colors.white : primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              atHospital = false;
                              print(atHospital);
                            });
                          },
                          child: Text(
                            'Đặt lịch khám tại phòng khám',
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: atHospital ? primaryColor : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.017,
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Center(
                child: Icon(
                  Icons.location_history,
                  size: screenWidth * 0.3,
                  color: primaryColor,
                ),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Họ và tên'),
              ),
              TextField(
                controller: sDTController,
                decoration: const InputDecoration(hintText: 'Số điện thoại'),
              ),
              TextField(
                readOnly: true,
                controller: diaChiController,
                maxLines: 2,
                decoration: const InputDecoration(
                    hintText: 'Địa chỉ', suffixIcon: MapIconBtn()),
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
              TextField(
                readOnly: true,
                controller: namSinhController,
                decoration: const InputDecoration(hintText: 'Năm sinh'),
                onTap: () async {
                  DateTime? datetime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  datetime ??= DateTime.now();
                  setState(() {
                    namSinhController.text =
                        DateFormat('dd-MM-yyyy').format(datetime!);
                  });
                },
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
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.01),
                      child: Icon(
                        Icons.home_work,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Bệnh viên/Phòng khám gần nhất',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    noiKham,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                ],
              ),
              TextField(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhongKhamMap()));
                },
                readOnly: true,
                controller: TextEditingController(text: 'Đi đến bản đồ'),
                style: TextStyle(color: primaryColor),
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
                    Icon(
                      Icons.medical_services,
                      color: primaryColor,
                    ),
                    Text(
                      'Chuyên khoa',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              DropdownButtonFormField(
                value: selectedCK,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                items: chuyenKhoaList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCK = value!;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    Icon(
                      Icons.file_present,
                      color: primaryColor,
                    ),
                    Text(
                      'Gói khám',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              DropdownButtonFormField(
                value: selectedGK,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                items:
                    goiKhamList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedGK = value!;
                    index = context.read<DataModel>().goiKham.indexOf(value);
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: primaryColor,
                    ),
                    Text(
                      'Giá',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.1),
                      child: Text(
                        NumberFormat.currency(symbol: 'đ', locale: 'vi_VN')
                            .format(context.read<DataModel>().giaGoi[index]),
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.025),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                    Text(
                      'Triệu chứng',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: trieuChungController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Triệu chứng',
                  suffixIcon: Icon(Icons.create, color: primaryColor),
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
                              color: primaryColor,
                              size: screenWidth * 0.05,
                            ),
                            Text(
                              'Ngày khám',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                        TextField(
                          controller: ngayKhamController,
                          readOnly: true,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelText: 'Ngày dự kiến khám'),
                        ),
                        TextField(
                          controller: gioKhamController,
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
