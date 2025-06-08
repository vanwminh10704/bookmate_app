import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.prefixIcon,
    this.labelText,
    this.hintText,
    this.textInputAction,
    this.onChanged,
    this.isRequired = false, // Thêm thuộc tính này
  });

  final TextEditingController? controller;
  final Icon? prefixIcon;
  final String? labelText;
  final String? hintText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final bool isRequired; // Thêm thuộc tính này

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(minWidth: 40.0),
      ),
      textInputAction: textInputAction,
      validator: isRequired
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập $labelText';
              }
              return null;
            }
          : null,
    );
  }
}
