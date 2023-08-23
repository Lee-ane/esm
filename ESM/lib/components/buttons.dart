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

class ReturnBtn extends StatelessWidget {
  const ReturnBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ));
  }
}
