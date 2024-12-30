import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;
  final Color foregroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double widthFactor;
  final double fontSize;
  final dynamic iconAlignment;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.foregroundColor = Colors.black,
    this.borderColor = Colors.green,
    this.borderWidth = 2.5,
    this.borderRadius = 50.0,
    this.widthFactor = 0.7,
    this.fontSize = 18.0,
    this.iconAlignment = IconAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          side: BorderSide(color: borderColor, width: borderWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, size: 24),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
