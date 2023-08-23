import 'package:esm/components/buttons.dart';
import 'package:esm/components/forms.dart';
import 'package:esm/model/data.dart';
import 'package:flutter/material.dart';

class BenhAnDienTu extends StatefulWidget {
  const BenhAnDienTu({super.key});

  @override
  State<BenhAnDienTu> createState() => _BenhAnDienTuState();
}

class _BenhAnDienTuState extends State<BenhAnDienTu> {
  final List<ExpansionTileData> titleData = [
    ExpansionTileData('Thông tin thành viên', const Form1()),
    ExpansionTileData('Tình trạng lúc sinh', const Form2()),
    ExpansionTileData('Yếu tố nguy cơ đối với sức khỏe cá nhân', const Form3()),
    ExpansionTileData('Khuyết tật', const Form4()),
    ExpansionTileData('Tiền sử bệnh tật, dị ứng', const Form5()),
    ExpansionTileData('Tiền sử phẩu thuật', const Form6()),
    ExpansionTileData('Tiền sử gia đình', const Form7()),
  ];

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
        leading: const ReturnBtn(),
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
              //
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.65,
                child: ListView(
                  children: titleData.map((data) {
                    return ExpansionChild(data: data);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//ExspansionTile Container
class _ExpansionContainerTile extends StatefulWidget {
  final Widget title;
  final ValueChanged<bool> onExpansionChanged;
  final Widget expandedContent;

  const _ExpansionContainerTile({
    required this.title,
    required this.onExpansionChanged,
    required this.expandedContent,
  });

  @override
  __ExpansionContainerTileState createState() =>
      __ExpansionContainerTileState();
}

class __ExpansionContainerTileState extends State<_ExpansionContainerTile> {
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
          Container(
            width: screenWidth,
            height: screenHeight * 0.05,
            decoration: BoxDecoration(
              color: const Color(0xff4BC848),
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

//ExpansionTile Child
class ExpansionChild extends StatefulWidget {
  final ExpansionTileData data;
  const ExpansionChild({super.key, required this.data});

  @override
  State<ExpansionChild> createState() => _ExpansionChildState();
}

class _ExpansionChildState extends State<ExpansionChild> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return _ExpansionContainerTile(
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
