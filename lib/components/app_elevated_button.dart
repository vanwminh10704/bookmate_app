import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.onPressed,
   this.height = 52.0,
    this.color = const Color(0xFFBDC65B), // là object nên phải có code
    this.borderColor = const Color(0xFFBDC65B) ,
  required this.text, // 
     this.textColor = Colors.black,
     this.borderRadius = const BorderRadius.all(Radius.circular(20.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 30.0),
  });

  final Function()? onPressed;
  final double height;
  final Color color;
  final Color borderColor;
  final String text;
  final Color textColor;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
      height: height,
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: borderRadius
      ),
      child: Text(
        text,
        style: TextStyle(
      color: textColor,
      fontSize: 25.0,
      fontWeight: FontWeight.w500
        ),
      ),
      ),
    );
  }
}
