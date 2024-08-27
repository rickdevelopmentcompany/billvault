import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/utils/button.dart';
import 'package:volex/utils/custom_textfield.dart';
import 'package:volex/views/auth_views/otp_verification.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Gap(MediaQuery.of(context).padding.top + 24),
            Row(
              children: [
                InkWell(
                  onTap: Navigator.of(context).pop,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.iconGreyColor,
                  ),
                ),
                const Gap(20),
                Text(
                  'Forgot password',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
            const Gap(35),
            Text(
              'It happens... Please enter your email to reset the password.',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const Gap(30),
            const CustomTextfield(
              label: 'Email Address',
              hintText: 'Enter your email address',
            ),
            const Gap(30),
            primaryButton(context, title: 'Reset Password', onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OTPVerificationView(fromEmail: false,)),
              );
            }),
            const Gap(42)
          ],
        ),
      ),
    );
  }
}
