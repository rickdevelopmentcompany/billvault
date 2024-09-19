import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/button.dart';

class BuyCoinView extends StatefulWidget {
  const BuyCoinView({super.key});

  @override
  State<BuyCoinView> createState() => BuyCoinViewState();
}

class BuyCoinViewState extends State<BuyCoinView> {
  bool viewDetails = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(MediaQuery.of(context).padding.top + 24),
            InkWell(
              onTap: Navigator.of(context).pop,
              splashColor: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back),
                  // const Gap(24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/bitcoin.png'),
                      const Gap(2),
                      Text(
                        'Buy',
                        style:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            const Gap(43),
            Text(
              'Wallet balance: 0.383 N',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
            ),
            const Gap(67),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Euro 1883',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: AppColors.redColor,
                        ),
                  ),
                  SvgPicture.asset(
                    'assets/svgs/euro.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.blackColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(26),
            Text(
              '= NGN75,489.49',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
            ),
            const Gap(17),
            Text(
              '0.0008640 BTC',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: const Color(0x91000000)),
            ),
            const Gap(40),
            Text(
              'Max daily amount Euro 0.00',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
            ),
            const Gap(18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                percentWidget(context, '25%'),
                percentWidget(context, '50%'),
                percentWidget(context, '75%'),
                percentWidget(context, 'All'),
              ],
            ),
            const Spacer(),
            primaryButton(context, title: 'Buy', onTap: () async {
              await showModalBottomSheet(
                context: context,
                builder: (_) => IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(40),
                        Text(
                          'Choose Payment Methods',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                        ),
                        const Gap(30),
                        paymentMethodsWidget(context,
                            img: 'apple',
                            name: 'Voled Wallet',
                            isSelected: true),
                        const Gap(32),
                        paymentMethodsWidget(context,
                            img: 'mastercard', name: 'Master card'),
                        const Gap(32),
                        paymentMethodsWidget(
                          context,
                          img: 'visa_var',
                          name: 'VISA',
                        ),
                        const Gap(36),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const Gap(36),
          ],
        ),
      ),
    );
  }
}

Widget percentWidget(BuildContext context, String val) => Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xA6000000),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        val,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color(0xA6000000),
            ),
      ),
    );

Widget paymentMethodsWidget(
  BuildContext context, {
  required String name,
  required String img,
  bool isSelected = false,
}) =>
    InkWell(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/$img.png'),
              const Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    'XXXX5555',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xFF696F8C)),
                  ),
                ],
              ),
            ],
          ),
          if (isSelected)
            const Icon(
              Icons.check_circle_outlined,
              color: Color(0xFF098C26),
            )
        ],
      ),
    );
