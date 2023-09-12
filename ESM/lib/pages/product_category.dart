import 'package:esm/components/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class DanhMucSanPham extends StatefulWidget {
  const DanhMucSanPham({super.key});

  @override
  State<DanhMucSanPham> createState() => _DanhMucSanPhamState();
}

class _DanhMucSanPhamState extends State<DanhMucSanPham> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: const BackButton(),
        title: Text(
          'Danh sách sản phẩm',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search), onPressed: () {}),
                      hintText: 'Nhập từ khóa'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.025, top: screenHeight * 0.01),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Ngành sản phẩm',
                    style: TextStyle(
                        color: Colors.grey[500], fontSize: screenWidth * 0.035),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.07,
                width: screenWidth,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.33,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0.1, 0.8),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          '$index',
                          style: TextStyle(color: Colors.green[600]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: isExpanded ? screenHeight * 0.325 : 0,
                width: screenWidth,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Nhóm sản phẩm',
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Ngành bạn chọn chưa có loại dịch vụ',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.033,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.013),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sản phẩm gần đây',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.043,
                                ),
                              ),
                              Checkbox(value: false, onChanged: (value) {})
                            ],
                          ),
                        ),
                        Table(
                          children: [
                            TableRow(children: [
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'Tỉnh',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: 'Chọn Tỉnh',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.043,
                                    ),
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down)),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    labelText: 'Quận/Huyện',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: 'Chọn Quận/Huyện',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.043,
                                    ),
                                    suffixIcon:
                                        const Icon(Icons.arrow_drop_down)),
                              ),
                            ])
                          ],
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Phường/Xã',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: 'Chọn Phường/Xã',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: screenWidth * 0.043,
                              ),
                              suffixIcon: const Icon(Icons.arrow_drop_down)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                icon: Icon(isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(right: screenWidth * 0.04),
                    width: screenWidth * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Xếp theo giá',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.arrowDownShortWide,
                          color: Colors.green,
                          size: screenWidth * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0.1, 0.2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade200,
                                highlightColor: Colors.white,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(5))),
                                  height: screenHeight * 0.1,
                                ),
                              ),
                              Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.white,
                                  child: Text('Title $index')),
                              const Divider(),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.white,
                                child: Text(
                                  'Price $index',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.white,
                                  child: Text('Adress $index')),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
