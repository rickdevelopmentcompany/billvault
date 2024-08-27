import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/utils/button.dart';
import 'package:volex/views/auth_views/login.dart';
import 'package:volex/views/auth_views/reset_password.dart';

class OTPVerificationView extends StatelessWidget {
  final bool fromEmail;
  const OTPVerificationView({super.key, this.fromEmail = true});

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
                  'Email verification',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
            const Gap(20),
            Text(
              'Please enter the code',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(7),
            Text(
              'We sent email to tomashuk.dima.1992@gmail.com',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(30),
            SvgPicture.asset('assets/svgs/mail.svg'),
            const Gap(24),
            Pinput(
              length: 6,
              onCompleted: (val) {},
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn\'t get a mail? ',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                ),
                Text(
                  'Send again',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                ),
              ],
            ),
            const Spacer(),
            primaryButton(
              context,
              title: 'Confirm',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      fromEmail ? const LoginView() : const ResetPasswordView(),
                ));
              },
            ),
            const Gap(42)
          ],
        ),
      ),
    );
  }
}
