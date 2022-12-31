import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'conts.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  const MyElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: googleFonts(20, Colors.purple.shade800, FontWeight.w700),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade200),
    );
  }
}
