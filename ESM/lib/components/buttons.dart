import 'package:flutter/material.dart';

class ContactBtn extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  const ContactBtn({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: const Color(0xff4BC848),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(onPressed: () {}, child: child),
    );
  }
}

class InfoBtn extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const InfoBtn({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Container(
        width: screenWidth,
        height: screenHeight * 0.05,
        decoration: BoxDecoration(
          color: const Color(0xff4BC848),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
