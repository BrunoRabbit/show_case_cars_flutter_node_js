import 'package:flutter/material.dart';
import 'package:showcase_cars_flutter_node_js/core/themes/app_colors.dart';

class SnackBarUtils {
  static SnackBar showSuccessSnackBar(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
            ),
          ),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  static SnackBar showErrorSnackBar(Exception message) {
    return SnackBar(
      content: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.error,
              color: AppColors.errorColor,
            ),
          ),
          Expanded(
            child: Text(
              message.toString(),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
