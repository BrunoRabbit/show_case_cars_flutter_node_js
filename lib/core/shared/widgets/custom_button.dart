import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.shape,
    this.padding,
    this.style,
    this.color,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final OutlinedBorder? shape;
  final EdgeInsets? padding;
  final TextStyle? style;
  final Color? color; 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: padding ??
                  const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
              backgroundColor:color?? Colors.black,
              shape: shape ??
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
            ),
            onPressed: onPressed,
            child: Text(
              title,
              style: style ?? const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
