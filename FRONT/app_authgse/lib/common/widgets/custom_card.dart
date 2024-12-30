import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const CustomCardWidget({
    super.key,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.icon = Icons.warning,
    this.iconColor = Colors.black54,
    required this.text,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              child: Center(
                child: Icon(icon, color: iconColor),
              ),
            ),
            const SizedBox(width: 10), // Espaciado entre icono y texto.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: textStyle ??
                        TextStyle(fontSize: 18, color: textColor),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
