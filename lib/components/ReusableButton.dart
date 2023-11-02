import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  ReusableButton({this.text, this.colorBtnBg,this.onPressed});

  final String? text;
  final Color? colorBtnBg;
  Function()? onPressed; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed:onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text.toString(),
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colorBtnBg),
          elevation: MaterialStateProperty.all(10),
        ),
      ),
    );
  }
}
