// ignore_for_file: non_constant_identifier_names

import 'package:esm/components/forms.dart';
import 'package:esm/components/style.dart';
import 'package:esm/model/data.dart';
import 'package:esm/model/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TraCuu extends StatefulWidget {
  const TraCuu({super.key});

  @override
  State<TraCuu> createState() => TraCuuState();
}

class TraCuuState extends State<TraCuu> {
  List<bool> checkboxValuesNC = [];
  List<bool> checkboxValuesKT = [];
  List<bool> checkboxValuesDU = [];
  List<bool> checkboxValuesCha = [];
  List<bool> checkboxValuesMe = [];
  List<bool> checkboxValuesONoi = [];
  List<bool> checkboxValuesBNoi = [];
  List<bool> checkboxValuesONgoai = [];
  List<bool> checkboxValuesBNgoai = [];
  int count = 0;
  List<bool> expanded = List.generate(13, (index) => false);
  void toggleItem(int index) {
    setState(() {
      for (int i = 0; i < expanded.length; i++) {
        if (expanded[i] == true) {
          count++;
          if (count > 1) {
            if (i == index) {
              expanded[i] = true;
            } else {
              expanded[i] = false;
            }
            count = 1;
          }
        }
      }
    });
  }

  String CanNangKS = '';
  String TinhTrang = '';
  dynamic user = {};
  dynamic dataTTLS = {};
  List<bool> dataYT = [];
  List<bool> dataKT = [];
  Map<String, dynamic> dataTSB = {};
  dynamic dataTSPT = [];
  Map<String, dynamic> dataTSCha = {};
  Map<String, dynamic> dataTSMe = {};
  Map<String, dynamic> dataTSONoi = {};
  Map<String, dynamic> dataTSBNoi = {};
  Map<String, dynamic> dataTSONgoai = {};
  Map<String, dynamic> dataTSBNgoai = {};

  void fetchData() async {
    user = await ReadData().fetchUser(context.read<DataModel>().taiKhoan);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    checkboxValuesNC = checkBoxTitleNC.map((item) => item.checked).toList();
    checkboxValuesKT = checkBoxTitleKT.map((item) => item.checked).toList();
    checkboxValuesDU = checkBoxTitleDU.map((item) => item.checked).toList();
    checkboxValuesCha = checkBoxTitleDU.map((item) => item.checked).toList();
    checkboxValuesMe = checkBoxTitleDU.map((item) => item.checked).toList();
    checkboxValuesONoi = checkBoxTitleDU.map((item) => item.checked).toList();
    checkboxValuesBNoi = checkBoxTitleDU.map((item) => item.checked).toList();
    checkboxValuesONgoai = checkBoxTitleDU.map((item) => item.checked).toList();
    checkboxValuesBNgoai = checkBoxTitleDU.map((item) => item.checked).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          width: screenWidth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                    alignment: Alignment.bottomLeft, child: BackButton()),
                //-----Thông tin thành viên-----//
                AnimatedTile(
                    expanded: expanded[0],
                    onTap: () async {
                      expanded[0] = !expanded[0];
                      toggleItem(0);
                    },
                    text: 'Thông tin thành viên'),
                AnimatedContent(
                  heightRatio: 0.2,
                  expanded: expanded[0],
                  child: SizedBox(
                    height: screenHeight * 0.18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            'Họ tên: ${user.isNotEmpty ? user['HoTen'] : null}'),
                        Text(
                            'Năm sinh: ${user.isNotEmpty ? DateFormat('dd-MM-yyyy').format(DateTime.parse(user['NamSinh'])) : null}'),
                        Text(
                            'Chiều cao(cm): ${user.isNotEmpty ? user['ChieuCao'] : null}'),
                        Text(
                            'Cân nặng(kg): ${user.isNotEmpty ? user['CanNang'] : null}'),
                        Text(
                            'Nhóm máu: ${user.isNotEmpty ? user['NhomMau'] : null}'),
                      ],
                    ),
                  ),
                ),
                //-----Tình trạng lúc sinh-----//
                AnimatedTile(
                    expanded: expanded[1],
                    onTap: () async {
                      expanded[1] = !expanded[1];
                      toggleItem(1);
                      if (dataTTLS.isEmpty) {
                        dataTTLS = await ReadData()
                            .fetchTTLS(context.read<DataModel>().makh);
                        if (dataTTLS != null) {
                          CanNangKS = dataTTLS['CanNang'].toString();
                          TinhTrang = dataTTLS['TinhTrang'];
                        }
                      }
                      setState(() {});
                    },
                    text: 'Tình trạng lúc sinh'),
                AnimatedContent(
                  heightRatio: 0.3,
                  expanded: expanded[1],
                  child: SizedBox(
                    height: screenHeight * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cân nặng(kg): $CanNangKS'),
                        const Text('Tình trạng khi sinh:'),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: screenWidth,
                          height: screenHeight * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: Text(TinhTrang, maxLines: 3),
                        ),
                      ],
                    ),
                  ),
                ),
                //-----Yếu tố nguy cơ đối với sức khỏe cá nhân-----//
                AnimatedTile(
                    expanded: expanded[2],
                    onTap: () async {
                      expanded[2] = !expanded[2];
                      toggleItem(2);
                      if (dataYT.isEmpty) {
                        dataYT = await ReadData()
                            .fetchYeuToNC(context.read<DataModel>().makh);
                        checkboxValuesNC = dataYT;
                      }
                      setState(() {});
                    },
                    text: 'Yếu tố nguy cơ đối với sức khỏe cá nhân'),
                AnimatedContent(
                  heightRatio: 2,
                  expanded: expanded[2],
                  child: SizedBox(
                    height: screenHeight * 2,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: checkBoxTitleNC.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          alignment: Alignment.center,
                          height: screenHeight * 0.13,
                          child: CheckboxListTile(
                            activeColor: primaryColor,
                            title: Text(
                              checkBoxTitleNC[index].title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.035),
                            ),
                            value: checkboxValuesNC[index],
                            onChanged: (value) {
                              null;
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                //-----Khuyết tật-----//
                AnimatedTile(
                    expanded: expanded[3],
                    onTap: () async {
                      expanded[3] = !expanded[3];
                      toggleItem(3);
                      if (dataKT.isEmpty) {
                        dataKT = await ReadData()
                            .fetchKT(context.read<DataModel>().makh);
                        checkboxValuesKT = dataKT;
                      }
                      setState(() {});
                    },
                    text: 'Khuyết tật'),
                AnimatedContent(
                  heightRatio: 0.2,
                  expanded: expanded[3],
                  child: SizedBox(
                    height: screenHeight * 0.2,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: checkBoxTitleKT.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          alignment: Alignment.center,
                          height: screenHeight * 0.08,
                          child: CheckboxListTile(
                            activeColor: primaryColor,
                            title: Expanded(
                                child: Text(
                              checkBoxTitleKT[index].title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.035),
                            )),
                            value: checkboxValuesKT[index],
                            onChanged: (value) {
                              null;
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                //-----Tiền sử bệnh tật, dị ứng-----//
                AnimatedTile(
                    expanded: expanded[4],
                    onTap: () async {
                      expanded[4] = !expanded[4];
                      toggleItem(4);
                      if (dataTSB.isEmpty) {
                        dataTSB = await ReadData()
                            .fetchTSB(context.read<DataModel>().makh);
                        checkboxValuesDU = dataTSB['list'];
                      }
                      setState(() {});
                    },
                    text: 'Tiền sử bệnh tật, dị ứng'),
                AnimatedContent(
                  heightRatio: 0.83,
                  expanded: expanded[4],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.6,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: checkBoxTitleDU.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              alignment: Alignment.center,
                              height: screenHeight * 0.1,
                              child: CheckboxListTile(
                                activeColor: primaryColor,
                                title: Expanded(
                                  child: Text(
                                    checkBoxTitleDU[index].title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                value: checkboxValuesDU[index],
                                onChanged: (value) {
                                  null;
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                      const Text('Chi tiết:'),
                      Container(
                        height: screenHeight * 0.15,
                        width: screenWidth,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('${dataTSB['string']}'),
                      ),
                    ],
                  ),
                ),
                //-----Tiền sử phẩu thuật-----//
                AnimatedTile(
                    expanded: expanded[5],
                    onTap: () async {
                      expanded[5] = !expanded[5];
                      toggleItem(5);
                      dataTSPT = await ReadData()
                          .fetchTSPT(context.read<DataModel>().makh);
                      setState(() {});
                    },
                    text: 'Tiền sử phẫu thuật'),
                AnimatedContent(
                  heightRatio: 0.35,
                  expanded: expanded[5],
                  child: Container(
                    color: Colors.grey[50],
                    height: screenHeight * 0.33,
                    child: ListView.builder(
                        itemCount: dataTSPT.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: SizedBox(
                              height: screenHeight * 0.15,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '${dataTSPT[index]['TenPhauThuat']}',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth * 0.04,
                                          ),
                                        ),
                                        Text(
                                            'Ngày thực hiện: ${DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(dataTSPT[index]['NgayThucHien']))}',
                                            style: description),
                                        Text(
                                            'Thời gian gây mê: ${DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(dataTSPT[index]['ThoiGianGayMe']))}',
                                            style: description),
                                        Text(
                                            'Thời gian bắt đầu: ${DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(dataTSPT[index]['ThoiGianBatDau']))}',
                                            style: description),
                                        Text(
                                            'Thời gian kết thúc: ${DateFormat('dd-MM-yyyy hh:mm').format(DateTime.parse(dataTSPT[index]['ThoiGianKetThuc']))}',
                                            style: description),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                //-----Tiền sử gia đình-----//
                AnimatedTile(
                  expanded: expanded[6],
                  onTap: () {
                    expanded[6] = !expanded[6];
                    toggleItem(6);
                  },
                  text: 'Tiền sử gia đình',
                ),
                Visibility(
                  visible: expanded[6],
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ParentTile(
                          expanded: expanded[7],
                          onTap: () async {
                            expanded[7] = !expanded[7];
                            if (dataTSCha.isEmpty) {
                              dataTSCha = await ReadData()
                                  .fetchTSCha(context.read<DataModel>().makh);
                              checkboxValuesCha = dataTSCha['list'];
                            }
                            setState(() {});
                          },
                          text: 'Cha',
                        ),
                        AnimatedContent(
                          heightRatio: 0.83,
                          expanded: expanded[7],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.6,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: checkBoxTitleDU.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      height: screenHeight * 0.1,
                                      child: CheckboxListTile(
                                        activeColor: primaryColor,
                                        title: Expanded(
                                          child: Text(
                                            checkBoxTitleDU[index].title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenWidth * 0.035),
                                          ),
                                        ),
                                        value: checkboxValuesCha[index],
                                        onChanged: (value) {
                                          null;
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const Text('Chi tiết:'),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.15,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('${dataTSCha['string']}'),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[8],
                          onTap: () async {
                            expanded[8] = !expanded[8];
                            if (dataTSMe.isEmpty) {
                              dataTSMe = await ReadData()
                                  .fetchTSMe(context.read<DataModel>().makh);
                              checkboxValuesMe = dataTSMe['list'];
                            }
                            setState(() {});
                          },
                          text: 'Mẹ',
                        ),
                        AnimatedContent(
                          heightRatio: 0.83,
                          expanded: expanded[8],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.6,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: checkBoxTitleDU.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      height: screenHeight * 0.1,
                                      child: CheckboxListTile(
                                        activeColor: primaryColor,
                                        title: Expanded(
                                          child: Text(
                                            checkBoxTitleDU[index].title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenWidth * 0.035),
                                          ),
                                        ),
                                        value: checkboxValuesMe[index],
                                        onChanged: (value) {
                                          null;
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const Text('Chi tiết:'),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.15,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('${dataTSMe['string']}'),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[9],
                          onTap: () async {
                            expanded[9] = !expanded[9];
                            if (dataTSONoi.isEmpty) {
                              dataTSONoi = await ReadData()
                                  .fetchTSON(context.read<DataModel>().makh);
                              checkboxValuesONoi = dataTSONoi['list'];
                            }
                            setState(() {});
                          },
                          text: 'Ông nội',
                        ),
                        AnimatedContent(
                          heightRatio: 0.83,
                          expanded: expanded[9],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.6,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: checkBoxTitleDU.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      height: screenHeight * 0.1,
                                      child: CheckboxListTile(
                                        activeColor: primaryColor,
                                        title: Expanded(
                                          child: Text(
                                            checkBoxTitleDU[index].title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenWidth * 0.035),
                                          ),
                                        ),
                                        value: checkboxValuesONoi[index],
                                        onChanged: (value) {
                                          null;
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const Text('Chi tiết:'),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.15,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('${dataTSONoi['string']}'),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[10],
                          onTap: () async {
                            expanded[10] = !expanded[10];
                            if (dataTSBNoi.isEmpty) {
                              dataTSBNoi = await ReadData()
                                  .fetchTSBN(context.read<DataModel>().makh);
                              checkboxValuesBNoi = dataTSBNoi['list'];
                            }
                            setState(() {});
                          },
                          text: 'Bà nội',
                        ),
                        AnimatedContent(
                          heightRatio: 0.83,
                          expanded: expanded[10],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.6,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: checkBoxTitleDU.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      height: screenHeight * 0.1,
                                      child: CheckboxListTile(
                                        activeColor: primaryColor,
                                        title: Expanded(
                                          child: Text(
                                            checkBoxTitleDU[index].title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenWidth * 0.035),
                                          ),
                                        ),
                                        value: checkboxValuesBNoi[index],
                                        onChanged: (value) {
                                          null;
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const Text('Chi tiết:'),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.15,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('${dataTSBNoi['string']}'),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[11],
                          onTap: () async {
                            expanded[11] = !expanded[11];
                            if (dataTSONgoai.isEmpty) {
                              dataTSONgoai = await ReadData().fetchTSONgoai(
                                  context.read<DataModel>().makh);
                              checkboxValuesONgoai = dataTSONgoai['list'];
                            }
                            setState(() {});
                          },
                          text: 'Ông ngoại',
                        ),
                        AnimatedContent(
                          heightRatio: 0.83,
                          expanded: expanded[11],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.6,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: checkBoxTitleDU.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      height: screenHeight * 0.1,
                                      child: CheckboxListTile(
                                        activeColor: primaryColor,
                                        title: Expanded(
                                          child: Text(
                                            checkBoxTitleDU[index].title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenWidth * 0.035),
                                          ),
                                        ),
                                        value: checkboxValuesONgoai[index],
                                        onChanged: (value) {
                                          null;
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const Text('Chi tiết:'),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.15,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('${dataTSONgoai['string']}'),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[12],
                          onTap: () async {
                            expanded[12] = !expanded[12];
                            if (dataTSBNgoai.isEmpty) {
                              dataTSBNgoai = await ReadData().fetchTSBNgoai(
                                  context.read<DataModel>().makh);
                              checkboxValuesBNgoai = dataTSBNgoai['list'];
                            }
                            setState(() {});
                          },
                          text: 'Bà ngoại',
                        ),
                        AnimatedContent(
                          heightRatio: 0.83,
                          expanded: expanded[12],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.6,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: checkBoxTitleDU.length,
                                  itemBuilder: ((context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      height: screenHeight * 0.1,
                                      child: CheckboxListTile(
                                        activeColor: primaryColor,
                                        title: Expanded(
                                          child: Text(
                                            checkBoxTitleDU[index].title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenWidth * 0.035),
                                          ),
                                        ),
                                        value: checkboxValuesBNgoai[index],
                                        onChanged: (value) {
                                          null;
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const Text('Chi tiết:'),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.15,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('${dataTSBNgoai['string']}'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
