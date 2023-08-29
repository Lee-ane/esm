import 'package:esm/components/buttons.dart';
import 'package:esm/components/style.dart';
import 'package:esm/model/data.dart';
import 'package:esm/model/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController(),
      sDTController = TextEditingController(),
      diaChiController = TextEditingController(),
      namSinhController = TextEditingController(),
      trieuChungController = TextEditingController(),
      ngayKhamController = TextEditingController(),
      gioKhamController = TextEditingController();

  String _selectedGender = 'Giới tính';

  final List<ListItem> options = [
    ListItem('Đặt lịch khám tại nhà'),
    ListItem('Đặt lịch khám tại công ty'),
    ListItem('Đặt lịch đưa đón KCB tận nơi'),
    ListItem('Đặt lịch khám hậu Covid-19'),
    ListItem('Đặt lịch gọi y tá theo yêu cầu'),
    ListItem('Đặt lịch xét nghiệm tại nhà'),
    ListItem('Đặt lịch chăm sóc mẹ và bé'),
  ];
  int selectedIndex = 0;

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
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.06,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                      child: Container(
                        width: screenWidth * 0.48,
                        decoration: BoxDecoration(
                          color: index == selectedIndex
                              ? primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedIndex = index;
                              print(options[selectedIndex].title);
                            });
                          },
                          child: Text(
                            options[index].title,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: index == selectedIndex
                                  ? Colors.white
                                  : primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: screenHeight * 0.017,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                  child: Icon(
                Icons.location_history,
                size: screenWidth * 0.3,
                color: primaryColor,
              )),
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
                controller: namSinhController,
                readOnly: true,
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
                        Icons.location_on,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Nơi khám',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: primaryColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.01),
                      child: Icon(
                        Icons.map,
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
                    'Chọn nơi khám',
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ],
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
              const TextField(
                readOnly: true,
                decoration:
                    InputDecoration(suffixIcon: Icon(Icons.arrow_drop_down)),
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
              const TextField(
                readOnly: true,
                decoration:
                    InputDecoration(suffixIcon: Icon(Icons.arrow_drop_down)),
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
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Triệu chứng',
                  suffixIcon: Icon(Icons.create, color: primaryColor),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Số bác sĩ',
                  suffixIcon: Icon(Icons.man, color: primaryColor),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Số y tá',
                  suffixIcon: Icon(Icons.woman, color: primaryColor),
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
                              labelText: 'Ngày dự kiến khám'),
                        ),
                        TextField(
                          controller: gioKhamController,
                          readOnly: true,
                          decoration:
                              const InputDecoration(labelText: 'Giờ khám'),
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
