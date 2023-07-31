import 'package:flutter/material.dart';

typedef OnPressed = void Function(BuildContext);

class DrawerModel {
  DrawerModel({
    required this.title,
    this.icon,
    required this.onPressed,
  });

  String title;
  Icon? icon;
  OnPressed onPressed;
}
