import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/button.dart';
import '../../widgets/custom_textfield.dart';


class ChangePinView extends StatelessWidget {
  const ChangePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Gap(MediaQuery.of(context).padding.top + 24),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: Navigator.of(context).pop,
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back),
                      const Gap(24),
                      Text(
                        'Change Pin',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
                const Gap(34),
                const CustomTextfield(
                  hintText: 'Old PIN',
                  obscureText: true,
                ),
                const Gap(4),
                const CustomTextfield(
                  hintText: 'New PIN',
                  obscureText: true,
                ),
                const Gap(4),
                const CustomTextfield(
                  hintText: 'Confirm PIN',
                  obscureText: true,
                ),
                const Gap(45),
                primaryButton(
                  context,
                  title: 'Save',
                  onTap: Navigator.of(context).pop,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
