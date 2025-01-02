import 'package:flutter/material.dart';

class CustomPageTemplate extends StatelessWidget {
  final Widget title;
  final Widget content;
  final Widget button;

  const CustomPageTemplate({
    super.key,
    required this.title,
    required this.content,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            children: [
              title, 
              Expanded(child: content), 
              button, 
            ],
          ),
        ),
      ),
    );
  }
}
