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
