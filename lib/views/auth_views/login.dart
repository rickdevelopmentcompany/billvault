import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/utils/button.dart';
import 'package:volex/utils/custom_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(MediaQuery.of(context).padding.top + 14),
            Text(
              'Login with email',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                  ),
            ),
            const Gap(8),
            Text(
              'Please enter email and password to login into your account',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.textGreyColor,
                  ),
              textAlign: TextAlign.center,
            ),
            const Gap(30),
            const CustomTextfield(
              label: 'Email Address',
              hintText: 'Enter your email address',
            ),
            const Gap(15),
            const CustomTextfield(
              label: 'Password',
              hintText: '0',
              obscureText: true,
            ),
            const Gap(15),
            primaryButton(context, title: 'Login'),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.blackColor,
                      ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Create account',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
