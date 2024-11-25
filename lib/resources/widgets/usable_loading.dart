import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';



class UsableLoading extends StatelessWidget {
  final opacity ;
  const UsableLoading({super.key, this.opacity = 0.5});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     // backgroundColor: AppColors.primaryColor.withOpacity(opacity),  // Semi-transparent background
     body: Container(
        // color: AppColors.primaryColor.withOpacity(opacity),  // Semi-transparent background
        child: const Center(
          child: NutsActivityIndicator(
            // activeColor: Colors.indigo,
            // inactiveColor: Colors.blueGrey,
            // tickCount: 24,
            // relativeWidth: 0.4,
            // radius: 60,
            // startRatio: 0.7,
            // animationDuration: Duration(milliseconds: 500),
          ),
          //CircularProgressIndicator(),
        ),
      ),
    );
  }
}
