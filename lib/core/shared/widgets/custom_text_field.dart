// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';

class CustomTextField extends StatelessWidget {
 const CustomTextField({
    Key? key,
    this.label,
    required this.icon,
    this.hintText = 'Ex: Leandro da Silva...',
    this.isObscureText,
    this.inputFormatters,
    required this.controller,
  }) : super(key: key);

  final String? label;
  final IconData icon;
  final String? hintText;
  final bool? isObscureText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText ?? false,
        inputFormatters: inputFormatters,
        validator: (text) {
          if (text!.isEmpty) {
            return 'Este campo não pode ser vazio';
          }
          return null;
        },
        
        decoration: InputDecoration(
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.errorColor,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.errorColor,
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black45,
              width: 2,
            ),
          ),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: AppColors.primaryColor,
          ),
          hintStyle: const TextStyle(
            color: Colors.black45,
          ),
          suffixIconColor: AppColors.primaryColor,
          suffixIcon: Icon(icon),
          labelText: label,
          floatingLabelBehavior: label == ""
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.always,
          hintText: hintText,
        ),
      ),
    );
  }
}
