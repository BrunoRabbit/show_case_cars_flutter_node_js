import 'package:flutter/services.dart';

class NumberDotInputFormatter extends FilteringTextInputFormatter {
  NumberDotInputFormatter() : super.allow(RegExp(r'^(\d+\.?\d*)$'));
}