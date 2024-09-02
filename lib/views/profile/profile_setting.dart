import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/button.dart';
import 'package:volex/utils/custom_textfield.dart';

class ProfileSettingView extends StatelessWidget {
  const ProfileSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Gap(MediaQuery.of(context).padding.top + 24),
            InkWell(
              onTap: Navigator.of(context).pop,
              splashColor: Colors.transparent,
              child: Row(
                children: [
                  const Icon(Icons.arrow_back),
                  const Gap(24),
                  Text(
                    'Profile Setting',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
            const Gap(38),
            CircleAvatar(
              radius: 50,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x70000000),
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Edit',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            const Gap(20),
            Text(
              'Aleander22',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
            ),
            const Gap(30),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                const CustomTextfield(
                  hintText: 'Full Name',
                ),
                CustomTextfield(
                  ctrl: TextEditingController(text: '+234 902929299'),
                  trailingSvg: 'check',
                ),
                CustomTextfield(
                  ctrl: TextEditingController(text: 'tonikross@gmail.com'),
                  trailingSvg: 'check',
                ),
                const CustomTextfield(
                  hintText: 'Date of birth',
                ),
                const CustomTextfield(
                  hintText: 'Male',
                  trailingSvg: 'dropdown',
                  readOnly: true,
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: primaryButton(
                    context,
                    title: 'Cancel',
                    isOutlined: true,
                    onTap: Navigator.of(context).pop,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: primaryButton(
                    context,
                    title: 'Save',
                    onTap: Navigator.of(context).pop,
                  ),
                ),
              ],
            ),
            Gap(MediaQuery.of(context).padding.bottom + 36),
          ],
        ),
      ),
    );
  }
}
