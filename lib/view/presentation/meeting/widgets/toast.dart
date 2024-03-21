import 'package:flutter/material.dart';

import '../theme/AppColors.dart';

void showSnackBarMessage(
    {required String message,
    Widget? icon,
    Color messageColor = Colors.white,
    required BuildContext context}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Appcolors.primaryColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Row(
        children: [
          if (icon != null) icon,
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                  color: Appcolors.fontcolor,
                fontSize: 14,
                fontWeight: FontWeight.w500,

              ),
              overflow: TextOverflow.fade,
            ),
          )
        ],
      )));
}
