import 'package:flutter/material.dart';

class FormTF extends StatelessWidget {
  final bool editable;
  final String label;
  const FormTF({super.key, required this.label, required this.editable});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: TextFormField(
        readOnly: !editable,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class TienSuPTFT extends StatelessWidget {
  final String title;
  const TienSuPTFT({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenWidth * 0.6,
          child: TextField(
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: title,
                hintText: '23/08/2023'),
          ),
        ),
        SizedBox(
          width: screenWidth * 0.3,
          child: const TextField(
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Giờ',
                hintText: '08:56'),
          ),
        ),
      ],
    );
  }
}
