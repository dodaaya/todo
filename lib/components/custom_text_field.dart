import 'package:flutter/material.dart';

class CustomTxtFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  String? Function(String?) valiadtor;
  TextInputType keyboardType;
  bool isPassword;

  CustomTxtFormField(
      {required this.label,
      this.keyboardType = TextInputType.text,
      required this.controller,
      required this.valiadtor,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(
            label,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 3, color: Theme.of(context).primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 3, color: Theme.of(context).primaryColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 3, color: Theme.of(context).primaryColor)),
        ),
        keyboardType: keyboardType,
        controller: controller,
        validator: valiadtor,
        obscureText: isPassword,
      ),
    );
  }
}
