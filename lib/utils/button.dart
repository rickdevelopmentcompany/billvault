import 'package:flutter/material.dart';
import 'package:volex/utils/app_colors.dart';

Widget primaryButton(
  BuildContext context, {
  required String title,
  Function()? onTap,
  Color? color,
  bool isOutlined = false,
}) =>
    InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          border: isOutlined
              ? Border.all(
                  color: color ?? AppColors.blackColor,
                )
              : null,
          color:
              isOutlined ? Colors.transparent : color ?? AppColors.blackColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color:
                    isOutlined ? color ?? AppColors.primaryColor : Colors.white,
              ),
        ),
      ),
    );
