import 'package:flutter/material.dart';

class FaceDisplay extends StatelessWidget {
  final Icon icon;

  const FaceDisplay({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: icon,
    );
  }
}