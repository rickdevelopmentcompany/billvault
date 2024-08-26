import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/utils/button.dart';
import 'package:volex/utils/custom_textfield.dart';
import 'package:volex/views/auth_views/login.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

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
              'Create an account',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                  ),
            ),
            const Gap(8),
            Text(
              'Be sure to provide correct defails.',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: AppColors.textGreyColor,
                  ),
            ),
            const Gap(30),
            const CustomTextfield(
              label: 'Username',
              hintText: 'Enter your username',
            ),
            const Gap(15),
            const CustomTextfield(
              label: 'Select Country',
              hintText: 'Nigeria',
            ),
            const Gap(15),
            const CustomTextfield(
              label: 'Email Address',
              hintText: 'Enter your email address',
            ),
            const Gap(15),
            const CustomTextfield(
              label: 'Phone Number',
              hintText: 'Nigeria',
            ),
            const Gap(15),
            const CustomTextfield(
              label: 'Password',
              hintText: '0',
              obscureText: true,
            ),
            const Gap(15),
            primaryButton(context, title: 'Create Account'),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Have an account? ',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.blackColor,
                      ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const LoginView(),
                    ));
                  },
                  child: Text(
                    'Login now',
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
