import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/helper/color.dart';

class MyCustomTextField extends StatelessWidget {
  final hintText;
  final controller;
  MyCustomTextField({this.controller, this.hintText = ''});
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      style: TextStyle(color: AppColor.titleTextColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.backgroundTextFieldColor,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColor.hintTextColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.borderTextFieldColorEnable,
            width: 2.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.borderTextFieldColorFocus,
            width: 2.5,
          ),
        ),
      ),
    );
  }
}

class MyCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  MyCustomButton({
    this.onPressed,
    this.text = "",
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.white,
    this.textColor = const Color(0xffABC9C4),
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
