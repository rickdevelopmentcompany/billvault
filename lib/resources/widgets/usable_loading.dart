import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_colors.dart';

class UsableLoading extends StatelessWidget {
  const UsableLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),  // Semi-transparent background
      child: Center(
        child: LoadingAnimationWidget.beat(
          color: AppColors.primaryColor,
          size: 100,
        ),
      ),
    );
  }
}
