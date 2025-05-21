import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final String hint;
  final TextEditingController txtController;
  final bool isSecured;

  const InputBox({
    super.key,
    required this.hint,
    required this.txtController,
    required this.isSecured,
  });

  @override
  Widget build(BuildContext contect) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        obscureText: isSecured,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
        controller: txtController,
      ),
    );
  }
}
