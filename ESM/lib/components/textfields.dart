import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child ?? Container(),
                    );
                  },
                  context: context,
                  initialTime: TimeOfDay.now());
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
