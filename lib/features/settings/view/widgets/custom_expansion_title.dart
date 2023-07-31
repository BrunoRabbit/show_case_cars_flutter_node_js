// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class CustomExpansionTitle extends StatelessWidget {
  CustomExpansionTitle({
    Key? key,
    required this.title,
    required this.iconColor,
    required this.subTitle,
    required this.body,
    this.button,
    this.subtitleAlign,
    this.onExpansionChanged,
  }) : super(key: key);

  final String title;
  final Color iconColor;
  final String subTitle;
  final Widget body;
  Widget? button;
  Alignment? subtitleAlign = Alignment.center;
  void Function(bool)? onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
      child: ExpansionTile(
        iconColor: iconColor,
        collapsedIconColor: iconColor,
        onExpansionChanged: onExpansionChanged,
        title: Text(
          title,
          style: TextStyle(
            color: iconColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        children: [
          Padding(
            padding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: subtitleAlign ?? Alignment.centerLeft,
                  child: Text(
                    subTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                body,
                button ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
