import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/button.dart';

class VirtualDollarCard extends StatelessWidget {
  const VirtualDollarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(MediaQuery.of(context).padding.top + 24),
            Text(
              'Virtual Dollar Card',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
            ),
            const Gap(38),
            Container(
              // height: 200,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/card_bg.png'),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/svgs/volex.svg'),
                      Image.asset('assets/images/visa.png'),
                    ],
                  ),
                  const Gap(39),
                  Text(
                    '**** **** ****  2345',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/card_part.png'),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card holder name',
                            style:
                                Theme.of(context).textTheme.labelLarge?.copyWith(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                          ),
                          const Gap(10),
                          Text(
                            'Norman Manzoor',
                            style:
                                Theme.of(context).textTheme.labelLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry date',
                            style:
                                Theme.of(context).textTheme.labelLarge?.copyWith(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                          ),
                          const Gap(10),
                          Text(
                            '02/30',
                            style:
                                Theme.of(context).textTheme.labelLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(18),
            Text(
              'Volex Virtual card',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
            ),
            const Gap(11),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svgs/budget.svg'),
                    const Gap(25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Budget Effectively',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                        ),
                        const Gap(8),
                        Text(
                          'Limit spending by only using the\namount uploaded to your card',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svgs/phone.svg'),
                    const Gap(25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Digital Native',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                        ),
                        const Gap(8),
                        Text(
                          'A digital card for your digital life',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svgs/dollar.svg'),
                    const Gap(25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Creating Fee',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                        ),
                        const Gap(8),
                        Text(
                          'USD 3.00 fee to create a USD card,\nNGN 1,000.00 fee to create a NGN\n card ',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Gap(34),
            primaryButton(context, title: 'Proceed'),
            const Gap(24),

          ],
        ),
      ),
    );
  }
}
