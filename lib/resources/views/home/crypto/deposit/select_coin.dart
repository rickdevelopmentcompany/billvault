import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utils/app_colors.dart';
import 'deposit_coin.dart';

class SelectCoinView extends StatefulWidget {
  const SelectCoinView({super.key});

  @override
  State<SelectCoinView> createState() => SelectCoinViewState();
}

class SelectCoinViewState extends State<SelectCoinView> {
  bool viewDetails = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          'BTC',
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
              const Gap(38),
              Text(
                'Select Coin to Deposit',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
              ),
              const Gap(23),
              ...List.generate(
                8,
                (index) => assetWidget(
                  context,
                  decrease: false,
                  percent: '+31.00%',
                  assetName: 'Bitcoin',
                  amount: '0.000033 BTC',
                  nairaAmount: '₦2000.121',
                  img: 'btc',
                ),
              ),
            ],
          ),
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
    InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const DepositCoinView(),
        ));
      },
      child: Padding(
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
      ),
    );
