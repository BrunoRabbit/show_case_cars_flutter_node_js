
import 'package:flutter/material.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';

class DividerWithTitle extends StatelessWidget {
  const DividerWithTitle({
    this.title,
    super.key,
  });
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: AppColors.primaryColor,
              thickness: 2,
              indent: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title ?? 'ou',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const Expanded(
            child: Divider(
              color: AppColors.primaryColor,
              thickness: 2,
              endIndent: 30,
            ),
          ),
        ],
      ),
    );
  }
}
