import 'package:app_authgse/common/widgets/custom_outline_button.dart';
import 'package:flutter/material.dart';

class TakePhotoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TakePhotoButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: CustomOutlinedButton(
            onPressed: onPressed, label: 'Tomar foto', icon: Icons.camera_alt));
  }
}
