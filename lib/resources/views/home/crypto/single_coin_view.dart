import 'package:billvaoit/resources/views/home/crypto/sell_coin.dart';
import 'package:billvaoit/resources/views/home/crypto/buy_crypto.dart';
import 'package:billvaoit/resources/views/home/crypto/sell_crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../app/http/controllers/crypto_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/button.dart';
import 'buy_coin.dart';
import 'deposit/select_coin.dart';
import 'package:get/get.dart';

class SingleCoinView extends StatefulWidget {
  const SingleCoinView({super.key});

  @override
  State<SingleCoinView> createState() => SingleCoinViewState();
}

class SingleCoinViewState extends State<SingleCoinView> {
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
                        'BTC',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SelectCoinView(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        'Deposit',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Gap(30),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Market price',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/svgs/eur.svg'),
                        Text(
                          ' 38,552.62',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30,
                                  ),
                        ),
                      ],
                    ),
                    Text(
                      '+E1,439.58(3.88%)',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'E39,051.68',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                  ),
                ),
                const Gap(4),
                Image.asset('assets/images/chart.png'),

                const Gap(4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'E36,862.36',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                  ),
                ),
              ],
            ),
            const Gap(57),
            Wrap(
              runSpacing: 38,
              spacing: 38,
              children: [
                Text(
                  '1H',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xFF707070)),
                ),
                Text(
                  '1D',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xFFFFBE55),
                      ),
                ),
                Text(
                  '1W',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xFF707070)),
                ),
                Text(
                  '1M',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xFF707070)),
                ),
                Text(
                  '1Y',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xFF707070)),
                ),
                Text(
                  'All',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color(0xFF707070)),
                ),
              ],
            ),
            const Gap(12),
            const Divider(
              color: Color(0x70003130),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: primaryButton(
                    context,
                    title: 'Buy',
                    isOutlined: true,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BuyCryptoScreen(controller: Get.put(CryptoController())),
                      ));
                    },
                  ),
                ),
                const Gap(16),
                Expanded(
                    child: primaryButton(context, title: 'Sell', onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SellCryptoScreen(), //const SellCoinView(),
                  ));
                })),
              ],
            ),
            const Gap(36),
          ],
        ),
      ),
    );
  }
}

Widget essentialWidget(BuildContext context,
        {required String svg, required String title, VoidCallback? onTap}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        width: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(spreadRadius: 2, color: Colors.black.withOpacity(.2)),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SvgPicture.asset('assets/svgs/$svg.svg'),
            const Gap(8),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: const Color(0xFF3E9850),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
