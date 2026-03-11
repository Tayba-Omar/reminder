import 'package:flutter/material.dart';
import '../Design/Color.dart';

class Textformfiled extends StatefulWidget {
  final String lbl;
  final String? hint;
  final IconData? preIcon;
  final IconData? suffIcon;
  final TextEditingController? controller;
  final Color? textColor;

  Textformfiled({
    required this.lbl,
    this.hint,
    this.preIcon,
    this.suffIcon,
    required this.controller,
    this.textColor,
  });

  @override
  State<Textformfiled> createState() => _TextformfiledState();
}

class _TextformfiledState extends State<Textformfiled> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final Color activeTextColor = widget.textColor ?? txtMainColor;

    return Container(
      width: 311,
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(
          color: activeTextColor,
          fontSize: screenWidth * 0.045,
        ),
        decoration: InputDecoration(
          label: Text(
            widget.lbl,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              color: activeTextColor,
            ),
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(color: activeTextColor.withOpacity(0.5)),
          prefixIcon: widget.preIcon != null
              ? Icon(widget.preIcon, color: activeTextColor, size: screenWidth * 0.06)
              : null,
          suffixIcon: widget.suffIcon != null
              ? Icon(widget.suffIcon, color: activeTextColor, size: screenWidth * 0.06)
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: activeTextColor,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: txtColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
