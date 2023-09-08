import 'package:esm/components/forms.dart';
import 'package:esm/components/style.dart';
import 'package:esm/model/data.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
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
          padding: EdgeInsets.all(screenWidth * 0.05),
          height: screenHeight,
          width: screenWidth,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //-----Thông tin thành viên-----//
                AnimatedTile(
                    expanded: expanded[0],
                    onTap: () async {
                      expanded[0] = !expanded[0];
                      toggleItem(0);
                    },
                    text: 'Thông tin thành viên'),
                AnimatedContent(
                  heightRatio: 0.6,
                  expanded: expanded[0],
                  child: SizedBox(
                    height: screenHeight * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Họ tên'),
                        const Text('Số điện thoại'),
                        const Text('Năm sinh'),
                        const Text('Số CMND'),
                        const Text('Số BHYT'),
                        const Text('Địa chỉ'),
                        Table(
                          children: const [
                            TableRow(
                              children: [
                                Text('Chiều cao(cm):'),
                                Text('Cân nặng(kg):'),
                                Text('Nhóm máu:'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //-----Tình trạng lúc sinh-----//
                AnimatedTile(
                    expanded: expanded[1],
                    onTap: () {
                      expanded[1] = !expanded[1];
                      toggleItem(1);
                    },
                    text: 'Tình trạng lúc sinh'),
                AnimatedContent(
                  heightRatio: 0.3,
                  expanded: expanded[1],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cân nặng(kg):'),
                      Text('Tình trạng khi sinh:'),
                    ],
                  ),
                ),
                //-----Yếu tố nguy cơ đối với sức khỏe cá nhân-----//
                AnimatedTile(
                    expanded: expanded[2],
                    onTap: () {
                      expanded[2] = !expanded[2];
                      toggleItem(2);
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
                            title: Text(
                              checkBoxTitleNC[index].title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.035),
                            ),
                            value: checkboxValuesNC[index],
                            onChanged: null,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                //-----Khuyết tật-----//
                AnimatedTile(
                    expanded: expanded[3],
                    onTap: () {
                      expanded[3] = !expanded[3];
                      toggleItem(3);
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
                            title: Expanded(
                                child: Text(
                              checkBoxTitleKT[index].title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.035),
                            )),
                            value: checkboxValuesKT[index],
                            onChanged: null,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                //-----Tiền sử bệnh tật, dị ứng-----//
                AnimatedTile(
                    expanded: expanded[4],
                    onTap: () {
                      expanded[4] = !expanded[4];
                      toggleItem(4);
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
                                title: Expanded(
                                  child: Text(
                                    checkBoxTitleDU[index].title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                value: checkboxValuesDU[index],
                                onChanged: null,
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.2,
                        child: const Text('Chi tiết:'),
                      ),
                    ],
                  ),
                ),
                //-----Tiền sử phẩu thuật-----//
                AnimatedTile(
                    expanded: expanded[5],
                    onTap: () {
                      expanded[5] = !expanded[5];
                      toggleItem(5);
                    },
                    text: 'Tiền sử phẫu thuật'),
                AnimatedContent(
                  heightRatio: 0.35,
                  expanded: expanded[5],
                  child: Container(
                    color: Colors.grey[50],
                    height: screenHeight * 0.33,
                    child: ListView.builder(
                        itemCount: 5,
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
                                          'Title $index',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenWidth * 0.04,
                                          ),
                                        ),
                                        Text('Ngày thực hiện: 2023-02-10 18:27',
                                            style: description),
                                        Text(
                                            'Thời gian gây mê: 2023-02-10 18:27',
                                            style: description),
                                        Text(
                                            'Thời gian bắt đầu: 2023-02-10 18:27',
                                            style: description),
                                        Text(
                                            'Thời gian kết thúc: 2023-02-10 18:27',
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
                          onTap: () {
                            expanded[7] = !expanded[7];
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
                                        title: Text(
                                          checkBoxTitleDU[index].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenWidth * 0.035),
                                        ),
                                        value: checkboxValuesCha[index],
                                        onChanged: null,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.2,
                                child: const Text('Chi tiết:'),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[8],
                          onTap: () {
                            expanded[8] = !expanded[8];
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
                                        title: Text(
                                          checkBoxTitleDU[index].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenWidth * 0.035),
                                        ),
                                        value: checkboxValuesMe[index],
                                        onChanged: null,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.2,
                                child: SizedBox(
                                  height: screenHeight * 0.2,
                                  child: const Text('Chi tiết:'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[9],
                          onTap: () {
                            expanded[9] = !expanded[9];
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
                                        title: Text(
                                          checkBoxTitleDU[index].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenWidth * 0.035),
                                        ),
                                        value: checkboxValuesONoi[index],
                                        onChanged: null,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.2,
                                child: SizedBox(
                                  height: screenHeight * 0.2,
                                  child: const Text('Chi tiết:'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[10],
                          onTap: () {
                            expanded[10] = !expanded[10];
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
                                        title: Text(
                                          checkBoxTitleDU[index].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenWidth * 0.035),
                                        ),
                                        value: checkboxValuesBNoi[index],
                                        onChanged: null,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.2,
                                child: SizedBox(
                                  height: screenHeight * 0.2,
                                  child: const Text('Chi tiết:'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[11],
                          onTap: () {
                            expanded[11] = !expanded[11];
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
                                        title: Text(
                                          checkBoxTitleDU[index].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenWidth * 0.035),
                                        ),
                                        value: checkboxValuesONgoai[index],
                                        onChanged: null,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.2,
                                child: SizedBox(
                                  height: screenHeight * 0.2,
                                  child: const Text('Chi tiết:'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ParentTile(
                          expanded: expanded[12],
                          onTap: () {
                            expanded[12] = !expanded[12];
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
                                        title: Text(
                                          checkBoxTitleDU[index].title,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: screenWidth * 0.035),
                                        ),
                                        value: checkboxValuesBNgoai[index],
                                        onChanged: null,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.2,
                                child: SizedBox(
                                  height: screenHeight * 0.2,
                                  child: const Text('Chi tiết:'),
                                ),
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
