import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController(),
      namSinhController = TextEditingController(),
      cMNDController = TextEditingController(),
      bHYTController = TextEditingController(),
      sDTController = TextEditingController();
  bool gender = true;

  Future<void> register() async {}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            color: Colors.white,
            width: screenWidth,
            height: screenHeight,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: screenWidth * 0.08,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4BC848), width: 2),
                            ),
                            labelText: 'Họ tên',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giới tính',
                              style: TextStyle(fontSize: screenWidth * 0.03),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  gender = !gender;
                                });
                              },
                              icon: Icon(
                                gender ? Icons.female : Icons.male,
                                color: gender ? Colors.pink : Colors.blue,
                                size: screenWidth * 0.08,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4BC848), width: 2),
                            ),
                            labelText: 'CMND',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.2,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff4BC848), width: 2),
                            ),
                            labelText: 'Năm sinh',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                  child: SizedBox(
                    width: screenWidth,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff4BC848), width: 2),
                        ),
                        labelText: 'Bảo hiểm y tế',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: screenWidth * 0.03, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                  child: SizedBox(
                    width: screenWidth,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: nameController,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff4BC848), width: 2),
                        ),
                        labelText: 'Số điện thoại',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                            fontSize: screenWidth * 0.03, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff4BC848),
                          Color(0xff56cfe1),
                        ],
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                            color: Colors.white, fontSize: screenWidth * 0.05),
                      ),
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
