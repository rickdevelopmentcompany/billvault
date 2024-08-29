import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/button.dart';

class SuccessView extends StatelessWidget {
  final String? content;
  const SuccessView({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Gap(),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 24),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: Navigator.of(context).pop,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/cancel.svg'),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Image.asset('assets/images/success.png'),
                const Gap(23),
                Text(
                  'Success!!!',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Gap(10),
                Text(
                  content ?? 'You Withdrawal has been\nsuccessfully ',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 38),
              child: primaryButton(context, title: 'Go to Home', onTap: () {
                Navigator.of(context).pop();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
