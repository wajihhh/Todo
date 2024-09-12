import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final double textFont;
  final fontWeight;
  final String text;
  final Function()? onTap;
  final double height;
  const CustomButton({
    super.key,
    this.height = 10,
    this.fontWeight,
    this.width = 250.0,
    this.textFont = 16,
    this.backgroundColor = const Color(0xFF6B46F6),
    this.textColor = Colors.white,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: backgroundColor, // Background color
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(111, 89, 243, 0.18),
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: textFont,
                color: textColor,
                fontWeight: fontWeight
            ),
            // textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
