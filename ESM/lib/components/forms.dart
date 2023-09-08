// ignore_for_file: use_build_context_synchronously

import 'package:esm/components/style.dart';
import 'package:flutter/material.dart';

class AnimatedTile extends StatelessWidget {
  final bool expanded;
  final void Function()? onTap;
  final String text;
  const AnimatedTile(
      {super.key,
      required this.expanded,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.02),
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          curve: Curves.easeInOut,
          width: screenWidth,
          height: screenHeight * 0.05,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: expanded
                ? const BorderRadius.vertical(top: Radius.circular(10))
                : const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.038),
              ),
              Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedContent extends StatelessWidget {
  final bool expanded;
  final Widget child;
  final double heightRatio;
  const AnimatedContent(
      {super.key,
      required this.expanded,
      required this.heightRatio,
      required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      padding: const EdgeInsets.all(10),
      width: expanded ? screenWidth : 0,
      height: expanded ? screenHeight * heightRatio : 0,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          border: expanded ? Border.all(color: primaryColor) : null,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(10))),
      child: Visibility(
        visible: expanded,
        child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(), child: child),
      ),
    );
  }
}

class ParentTile extends StatelessWidget {
  final bool expanded;
  final void Function()? onTap;
  final String text;
  const ParentTile(
      {super.key,
      required this.expanded,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.02),
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          curve: Curves.easeInOut,
          width: screenWidth,
          height: screenHeight * 0.05,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: expanded ? primaryColor : const Color(0xff1A6E30),
            borderRadius: expanded
                ? const BorderRadius.vertical(top: Radius.circular(10))
                : const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04),
              ),
              Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
