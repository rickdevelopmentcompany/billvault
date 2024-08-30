import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/utils/button.dart';

class DepositCoinView extends StatefulWidget {
  const DepositCoinView({super.key});

  @override
  State<DepositCoinView> createState() => DepositCoinViewState();
}

class DepositCoinViewState extends State<DepositCoinView> {
  bool viewDetails = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Deposit Coin',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
            const Gap(55),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFCFCFCF),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 54.0),
                    child: Image.asset('assets/images/qrcode.png'),
                  ),
                  const Divider(
                    color: Color(0xFFCFCFCF),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wallet address',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                            ),
                            Text(
                              '3K9CKsePi...Df5NfQh7iK',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFCFCFCF),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Copy',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            primaryButton(context, title: 'Share', onTap: Navigator.of(context).pop),
            const Gap(36),
          ],
        ),
      ),
    );
  }
}

Widget assetWidget(
  BuildContext context, {
  String? img,
  String? assetName,
  String? amount,
  String? nairaAmount,
  String? percent,
  bool decrease = true,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/${img ?? 'eth'}.png'),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assetName ?? 'Etherium',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    amount ?? '0.0004586 ETH',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: const Color(0xFF6C757D)),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                nairaAmount ?? '₦1,085.18',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: const Color(0xFF343A40),
                    ),
              ),
              Text(
                percent ?? '-21.00%',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: decrease
                          ? AppColors.redColor
                          : AppColors.primaryColor,
                    ),
              )
            ],
          )
        ],
      ),
    );
