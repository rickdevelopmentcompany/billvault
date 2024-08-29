import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/utils/button.dart';
import 'package:volex/utils/custom_textfield.dart';
import 'package:volex/views/home/buy_giftcard/checkout.dart';

class BuySingleGiftcardView extends StatefulWidget {
  const BuySingleGiftcardView({super.key});

  @override
  State<BuySingleGiftcardView> createState() => BuySingleGiftcardViewState();
}

class BuySingleGiftcardViewState extends State<BuySingleGiftcardView> {
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
                children: [
                  const Icon(Icons.arrow_back),
                  const Gap(24),
                  Text(
                    'Buy Gift Card',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
            const Gap(33),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/apple-gc.png'),
              radius: 32,
            ),
            const Gap(9),
            Text(
              'Apple Pay E-Gift Card',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
            ),
            const Gap(23),
            const CustomTextfield(
              label: 'Select Amount',
              hintText: '\$ 10.00 - NGN 16,050.00',
              trailingSvg: 'dropdown',
              enabled: false,
            ),
            const Gap(11),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quantity',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                ),
                const Gap(6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      color: AppColors.primaryColor,
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        color: const Color(0xFFF8F7F7),
                        child: Text(
                          '1',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 21,
                                  ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      color: AppColors.primaryColor,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Gap(18),
            const CustomTextfield(
              label: 'Gift card details will be sent to',
              hintText: 'Please enter email ID',
            ),
            const Gap(25),
            const CustomTextfield(
              label: 'Receive number',
              hintText: '0000 0000 0000 0000',
              // svgPrefix: 'dropdown',
              enabled: false,
            ),
            const Gap(25),
            Text(
              'Redeem instructions',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: const Color(0xFF003130),
                  ),
            ),
            const Spacer(flex: 3),
            primaryButton(context, title: 'Confirm', onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => const CheckoutView(),
              ));
            }),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
