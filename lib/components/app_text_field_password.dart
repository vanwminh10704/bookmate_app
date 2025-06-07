import 'package:flutter/material.dart';

class AppTextFieldPassword extends StatefulWidget {
  const AppTextFieldPassword({
    super.key,
    this.controller,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.textInputAction,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final Icon? prefixIcon;
  final String? labelText;
  final String? hintText;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;

  @override
  State<AppTextFieldPassword> createState() => _AppTextFieldPasswordState();
}

class _AppTextFieldPasswordState extends State<AppTextFieldPassword> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: const BoxConstraints(minWidth: 40.0),
        suffixIcon: GestureDetector(
          onTap: () {
            showPassword = !showPassword;
            setState(() {});
          },
          child: showPassword == true
              ? Icon(Icons.remove_red_eye, color: Colors.green)
              : const Icon(Icons.remove_red_eye_outlined,
                  color: Color(0xFFBDC65B)),
        ),
      ),
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
    );
  }
}
