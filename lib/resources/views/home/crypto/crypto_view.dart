import 'package:billvaoit/resources/views/home/crypto/single_coin_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../widgets/custom_textfield.dart';
import '../../wallet/wallet.dart';
import 'deposit/deposit_coin.dart';

class CryptoView extends StatefulWidget {
  const CryptoView({super.key});

  @override
  State<CryptoView> createState() => CryptoViewState();
}

class CryptoViewState extends State<CryptoView> {
  bool viewDetails = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
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
                      'Crypto',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),
              ),
              const Gap(52),
              Text(
                'Click any coin to start trading',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
              ),
              const Gap(28),
              const CustomTextfield(
                hintText: 'Search for a coin',
              ),
              const Gap(28),
              ...List.generate(
                8,
                (index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SingleCoinView(),
                    ));
                  },
                  child: assetWidget(
                    context,
                    decrease: false,
                    percent: '+31.00%',
                    assetName: 'Bitcoin',
                    amount: '0.000033 BTC',
                    nairaAmount: '₦2000.121',
                    img: 'btc',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
