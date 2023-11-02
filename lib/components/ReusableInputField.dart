import 'package:flutter/material.dart';

class ReusableInputField extends StatelessWidget {

  ReusableInputField({this.labelText, this.obscure,this.onChange,this.controlText});

  String? labelText;
  bool? obscure;
  Function(String)? onChange;
  TextEditingController? controlText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: TextField(
        controller: controlText,
        onChanged: onChange,
        keyboardType: TextInputType.emailAddress,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
