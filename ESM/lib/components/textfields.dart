import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormTF extends StatelessWidget {
  final String label;
  final bool editable;
  final TextInputType? inputType;
  final TextEditingController controller;

  const FormTF(
      {super.key,
      required this.label,
      required this.controller,
      required this.inputType,
      required this.editable});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: SizedBox(
        height: screenHeight * 0.06,
        child: TextFormField(
          keyboardType: inputType,
          readOnly: !editable,
          controller: controller,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: label,
            labelStyle: TextStyle(fontSize: screenHeight * 0.025),
            hintText: label,
            hintStyle: TextStyle(fontSize: screenHeight * 0.015),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: TextStyle(fontSize: screenHeight * 0.02),
        ),
      ),
    );
  }
}

class DateTF extends StatelessWidget {
  final TextEditingController controller;
  const DateTF({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelText: 'Ngày dự kiến khám'),
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now());
        newDate ??= DateTime.now();
        controller.text = DateFormat('dd-MM-yyyy').format(newDate);
      },
    );
  }
}

class TimeTF extends StatelessWidget {
  final TextEditingController controller;
  const TimeTF({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelText: 'Giờ khám'),
      onTap: () async {
        TimeOfDay? newTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        newTime ??= TimeOfDay.now();
        controller.text = '${newTime.hour}:${newTime.minute}';
      },
    );
  }
}

class TienSuPTFT extends StatefulWidget {
  final String title;
  const TienSuPTFT({super.key, required this.title});

  @override
  State<TienSuPTFT> createState() => _TienSuPTFTState();
}

class _TienSuPTFTState extends State<TienSuPTFT> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController(),
      timeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
    timeController.text = DateFormat('hh:mm').format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenWidth * 0.6,
          child: TextField(
            readOnly: true,
            controller: dateController,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: widget.title),
            onTap: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100));
              newDate ??= DateTime.now();
              setState(() {
                dateController.text = DateFormat('dd-MM-yyyy').format(newDate!);
              });
            },
          ),
        ),
        SizedBox(
          width: screenWidth * 0.3,
          child: TextField(
            readOnly: true,
            controller: timeController,
            decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Giờ'),
            onTap: () async {
              TimeOfDay? newTime = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              newTime ??= TimeOfDay.now();
              setState(() {
                timeController.text = '${newTime!.hour}:${newTime.minute}';
              });
            },
          ),
        ),
      ],
    );
  }
}
