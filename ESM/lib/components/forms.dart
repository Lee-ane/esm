// ignore_for_file: use_build_context_synchronously

import 'package:esm/components/style.dart';
import 'package:esm/components/textfields.dart';
import 'package:esm/model/data.dart';
import 'package:esm/model/models.dart';
import 'package:esm/pages/them_tien_su_phau_thuat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:esm/components/map.dart';

class Form1 extends StatefulWidget {
  final bool editable;
  const Form1({super.key, required this.editable});

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  TextEditingController nameController = TextEditingController(),
      namSinhController = TextEditingController(),
      canNangController = TextEditingController(),
      nhomMauController = TextEditingController(),
      diaChiController = TextEditingController(),
      chieuCaotroller = TextEditingController(),
      cMNDController = TextEditingController(),
      bHYTController = TextEditingController(),
      sDTController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = context.read<DataModel>().hoTen;
    sDTController.text = context.read<DataModel>().sdt;
    namSinhController.text =
        DateFormat('dd-MM-yyyy').format(context.read<DataModel>().ngaySinh);
    cMNDController.text = context.read<DataModel>().cMND;
    bHYTController.text = context.read<DataModel>().bHYT;
    diaChiController.text = context.read<DataModel>().diaChi;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff4BC848),
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FormTF(
              controller: nameController,
              label: 'Họ tên',
              editable: widget.editable,
              onChanged: (value) {
                context.read<DataModel>().setHoTen(value);
              },
            ),
            FormTF(
              controller: sDTController,
              label: 'Số điện thoại',
              editable: widget.editable,
              onChanged: (value) {
                context.read<DataModel>().setSDT(value);
              },
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: TextFormField(
                controller: namSinhController,
                readOnly: true,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Ngày sinh',
                  hintText: 'Ngày sinh',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: () async {
                  if (widget.editable) {
                    DateTime? datetime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                    datetime ??= DateTime.now();
                    namSinhController.text =
                        DateFormat('dd-MM-yyyy').format(datetime);
                    context.read<DataModel>().setNgaySinh(DateTime.parse(
                        DateFormat('yyyy-MM-dd').format(datetime)));
                  }
                },
              ),
            ),
            FormTF(
              controller: cMNDController,
              label: 'Số CMND',
              editable: widget.editable,
              onChanged: (value) {
                context.read<DataModel>().setCMND(value);
              },
            ),
            FormTF(
              controller: bHYTController,
              label: 'Số BHYT',
              editable: widget.editable,
              onChanged: (value) {
                context.read<DataModel>().setBHYT(value);
              },
            ),
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: TextFormField(
                controller: diaChiController,
                readOnly: true,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Địa chỉ',
                  hintText: 'Địa chỉ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: () {
                  if (widget.editable) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Map()));
                  }
                },
              ),
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: TextFormField(
                        controller: diaChiController,
                        keyboardType: TextInputType.number,
                        readOnly: widget.editable,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Chiều cao(Cm)',
                          hintText: 'Chiều cao(Cm)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          context
                              .read<DataModel>()
                              .setChieuCao(int.parse(value));
                          print(context.read<DataModel>().chieuCao);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: TextFormField(
                        controller: diaChiController,
                        keyboardType: TextInputType.number,
                        readOnly: widget.editable,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Cân nặng(Kg)',
                          hintText: 'Cân nặng(Kg)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          context
                              .read<DataModel>()
                              .setCanNang(int.parse(value));
                          print(context.read<DataModel>().canNang);
                        },
                      ),
                    ),
                    FormTF(
                      controller: nhomMauController,
                      label: 'Nhóm máu',
                      editable: widget.editable,
                      onChanged: (value) {
                        setState(() {
                          context.read<DataModel>().setNhomMau(value);
                          print(context.read<DataModel>().nhomMau);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Form2 extends StatefulWidget {
  final bool editable;
  const Form2({super.key, required this.editable});

  @override
  State<Form2> createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff4BC848),
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
              child: TextFormField(
                keyboardType: TextInputType.number,
                readOnly: !widget.editable,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Cân nặng(Kg)',
                  hintText: 'Cân nặng(Kg)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  context.read<DataModel>().setCanNangKS(int.parse(value));
                  print(context.read<DataModel>().canNangKS);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenHeight * 0.01),
              child: TextField(
                maxLines: 5,
                readOnly: !widget.editable,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Tình trạng',
                  hintText: 'Tình trạng',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  context.read<DataModel>().setTinhTrang(value);
                  print(context.read<DataModel>().tinhTrang);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Form3 extends StatefulWidget {
  const Form3({super.key});

  @override
  State<Form3> createState() => _Form3State();
}

class _Form3State extends State<Form3> {
  List<bool> _checkboxValues = [];
  final List<CheckBoxTileListItem> checkBoxTitle = [
    CheckBoxTileListItem(
      'Thoái hóa cột sống thắt lưng, gai xơ xương l4,l5, đau căng cơ cstl, viêm rễ thần kinh cstl / gerd, suy tĩnh mạch (mạn) (ngoại biên)',
      false,
    ),
    CheckBoxTileListItem(
      'Thoái hóa cột sống thắt lưng, gai xơ xương l4,l5, đau căng cơ cstl, viêm rễ thần kinh cstl / gerd, suy tĩnh mạch (mạn) (ngoại biên);',
      false,
    ),
    CheckBoxTileListItem(
      'Thoái hóa cột cstl, gai xương thân sống l4,l5, đau căng cơ cột sống hạ calci, suy tĩnh mạch đùi sâu chi dưới 2 bên',
      false,
    ),
    CheckBoxTileListItem(
      'Thoái hóa cstl, gai xương thân sống l4,l5, rễ thần kinh cs, suy tĩnh mạch (mạn) (ngoại biên)',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm dạ dày và tá tràng',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm họng - Amidan đợt cấp',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm họng cấp',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm họng mạn tính đợt cấp',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm họng thanh quản mạn',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm kết mạc MPT',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm mũi họng cấp',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm mũi họng cấp [cảm thường]; Viêm mũi xoang - Viêm họng cấp',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm mũi họng cấp; Viêm mũi dị ứng',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm tủy/R23',
      false,
    ),
    CheckBoxTileListItem(
      'Viêm tủy/R35',
      false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkboxValues = checkBoxTitle.map((item) => item.checked).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 1.35,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff4BC848),
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: checkBoxTitle.length,
        itemBuilder: ((context, index) {
          return CheckboxListTile(
            title: Text(checkBoxTitle[index].title),
            value: _checkboxValues[index],
            onChanged: (newValue) {
              setState(
                () {
                  _checkboxValues[index] = newValue!;
                  print(_checkboxValues);
                },
              );
            },
          );
        }),
      ),
    );
  }
}

class Form4 extends StatefulWidget {
  const Form4({super.key});

  @override
  State<Form4> createState() => _Form4State();
}

class _Form4State extends State<Form4> {
  List<bool> _checkboxValues = [];
  final List<CheckBoxTileListItem> checkBoxTitle = [
    CheckBoxTileListItem(
      'Thoát vị đĩa đệm',
      false,
    ),
    CheckBoxTileListItem(
      'Tật khúc xạ',
      false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkboxValues = checkBoxTitle.map((item) => item.checked).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.15,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff4BC848),
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: ListView.builder(
        itemCount: checkBoxTitle.length,
        itemBuilder: ((context, index) {
          return CheckboxListTile(
            title: Text(checkBoxTitle[index].title),
            value: _checkboxValues[index],
            onChanged: (newValue) {
              setState(
                () {
                  _checkboxValues[index] = newValue!;
                  print(_checkboxValues);
                },
              );
            },
          );
        }),
      ),
    );
  }
}

class Form5 extends StatefulWidget {
  const Form5({super.key});

  @override
  State<Form5> createState() => _Form5State();
}

class _Form5State extends State<Form5> {
  List<bool> _checkboxValues = [];
  final List<CheckBoxTileListItem> checkBoxTitle = [
    CheckBoxTileListItem(
      'Dị ứng',
      false,
    ),
    CheckBoxTileListItem(
      'Ma túy',
      false,
    ),
    CheckBoxTileListItem(
      'Rượu bia',
      false,
    ),
    CheckBoxTileListItem(
      'Thuốc lá',
      false,
    ),
    CheckBoxTileListItem(
      'Thuốc lào',
      false,
    ),
    CheckBoxTileListItem(
      'Khác',
      false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkboxValues = checkBoxTitle.map((item) => item.checked).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.68,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff4BC848),
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.43,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: checkBoxTitle.length,
              itemBuilder: ((context, index) {
                return CheckboxListTile(
                  title: Text(checkBoxTitle[index].title),
                  value: _checkboxValues[index],
                  onChanged: (newValue) {
                    setState(
                      () {
                        _checkboxValues[index] = newValue!;
                        print(_checkboxValues);
                      },
                    );
                  },
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.01),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Chi tiết',
                hintText: 'Chi tiết',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Form6 extends StatefulWidget {
  const Form6({super.key});

  @override
  State<Form6> createState() => _Form6State();
}

class _Form6State extends State<Form6> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff4BC848),
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cắt ruột thừa',
              style: TextStyle(
                color: const Color(0xff4BC848),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
              ),
            ),
            Text(
              'Ngày thực hiện: 2023-02-10 18:27',
              style: description,
            ),
            Text(
              'Thời gian gây mê: 2023-02-10 18:27',
              style: description,
            ),
            Text(
              'Thời gian bắt đầu: 2023-02-10 18:27',
              style: description,
            ),
            Text(
              'Thời gian kết thúc: 2023-02-10 18:27',
              style: description,
            ),
            const Divider(),
            SizedBox(
              height: screenHeight * 0.05,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ThemTienSuPT()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.add), Text('Thêm')],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Form7 extends StatefulWidget {
  const Form7({super.key});

  @override
  State<Form7> createState() => _Form7State();
}

class _Form7State extends State<Form7> {
  List<ExpansionTileData> titleData = [
    ExpansionTileData('Cha', const Form5()),
    ExpansionTileData('Mẹ', const Form5()),
    ExpansionTileData('Ông nội', const Form5()),
    ExpansionTileData('Bà nội', const Form5()),
    ExpansionTileData('Ông ngoại', const Form5()),
    ExpansionTileData('Bà ngoại', const Form5()),
  ];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.5,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff4BC848),
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: ListView(
          children: titleData.map((data) {
            return ParentExpansion(data: data);
          }).toList(),
        ),
      ),
    );
  }
}

class _ParentExpansionTile extends StatefulWidget {
  final Widget title;
  final ValueChanged<bool> onExpansionChanged;
  final Widget expandedContent;

  const _ParentExpansionTile({
    required this.title,
    required this.onExpansionChanged,
    required this.expandedContent,
  });

  @override
  __ParentExpansionTileState createState() => __ParentExpansionTileState();
}

class __ParentExpansionTileState extends State<_ParentExpansionTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: screenWidth,
            height: screenHeight * 0.05,
            decoration: BoxDecoration(
              color:
                  _expanded ? const Color(0xff4BC848) : const Color(0xff1A6E30),
              borderRadius: _expanded
                  ? const BorderRadius.vertical(
                      top: Radius.circular(10),
                    )
                  : BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
                widget.onExpansionChanged(_expanded);
              },
              child: widget.title,
            ),
          ),
          if (_expanded) widget.expandedContent,
        ],
      ),
    );
  }
}

class ParentExpansion extends StatefulWidget {
  final ExpansionTileData data;
  const ParentExpansion({super.key, required this.data});

  @override
  State<ParentExpansion> createState() => _ParentExpansionState();
}

class _ParentExpansionState extends State<ParentExpansion> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return _ParentExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.data.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04,
            ),
          ),
          Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.white,
          )
        ],
      ),
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      expandedContent: widget.data.expandedForm,
    );
  }
}
