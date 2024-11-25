import 'dart:convert';

import 'package:billvaoit/app/Models/Wallet.dart';
import 'package:billvaoit/app/http/controllers/wallet_controller.dart';
import 'package:billvaoit/resources/views/home/add_money/add_money.dart';
import 'package:billvaoit/resources/views/home/transfer/transfer_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../app/Models/user/User.dart';
import '../../../app/http/controllers/crypto_controller.dart';
import '../../../app/http/controllers/user_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/dashboard_topbar.dart';
import '../home/crypto/currency_card_chart.dart';
import '../home/dashboard.dart';
import '../home/withdrawal/withdrawal_by_card_view.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final CryptoController controller = Get.put(CryptoController());
  bool showRecent = false;
  bool onAsset = false;
  String selected = 'All transactions';
  final dropdownItems = [
    'All transactions',
    'Bill Payment',
    'Buy Gift Card',
    'Wallet Top-Ups',
    'Withdrawals',
    'Virtual Card',
    'Crypto',
  ];

  @override
  void initState() {
    super.initState();
    print("oj");
  }

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.put(WalletController());
    walletController.fetchResponse();

    Wallet wallet = Wallet();
    Map<String, dynamic> currencyDatas = wallet.getCurrencyData();

    User user = User();
    // UserController userController = Get.put(UserController());
    GetStorage storage = GetStorage();
    var data = json.decode(storage.read('dashboard'));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: DasboardTopBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const Gap(24),
              // BalanceCard(balance:data['data']['total_site_balance'] ?? 0.00),
              BalanceCard(balance: "₦${controller.availableBalance.value}"),
              const Gap(13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const TransferView(),
                        ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:  AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(33),
                        ),
                        height: 40,
                        child: Text(
                          'Add Money',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const WithdrawalByCardView(),
                        ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(33),
                        ),
                        height: 40,
                        child: Text(
                          'Withdraw',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // const CurrencyCardChart(
              //   currencyName: 'Ethereum',
              //   currencyAmount: '0.0004586 ETH',
              //   currencyPrice: '₦1,085.18',
              //   percentageChange: '-21.00%',
              //   percentageChangeColor: Colors.red,
              //   trendData: [
              //     FlSpot(0, 1),
              //     FlSpot(1, 1.5),
              //     FlSpot(2, 1.4),
              //     FlSpot(3, 1.2),
              //     FlSpot(4, 1.1),
              //   ], // Replace with actual trend data
              // ),
              CurrencyList(controller: controller,),

              const Gap(43),
              // if (!onAsset) ...[
              //   Align(
              //     alignment: Alignment.centerLeft,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'My Asset',
              //           style: Theme.of(context).textTheme.labelLarge?.copyWith(
              //             fontSize: 20,
              //           ),
              //         ),
              //         InkWell(
              //           splashColor: Colors.transparent,
              //           onTap: () {
              //             setState(() {
              //               onAsset = !onAsset;
              //             });
              //           },
              //           child: Container(
              //             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(8),
              //               color: AppColors.primaryColor,
              //             ),
              //             child: Text(
              //               'Transaction',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .labelMedium
              //                   ?.copyWith(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 14,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   const Gap(13),
              //   // ...List.generate(
              //   //   1,
              //   //       (index) => assetWidget(
              //   //     context,
              //   //     decrease: false,
              //   //     percent: '+31.00%',
              //   //     assetName: 'Bitcoin',
              //   //     amount: '0.000033 BTC',
              //   //     nairaAmount: '₦200,000.121',
              //   //     img: 'btc',
              //   //   ),
              //   // ),
              //   CurrencyList(currencyDatas: currencyDatas, controller: controller),
              // ],
              if (onAsset) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Filter by:',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Gap(12),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F7F7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton(
                              isExpanded: false,
                              value: selected,
                              underline: const SizedBox(),
                              items: dropdownItems
                                  .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                                  .toList(),
                              onChanged: (val) {
                                if (val == null) return;
                                setState(() {
                                  selected = val;
                                  showRecent = !showRecent;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            onAsset = !onAsset;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                          child: Text(
                            'Asset',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recent Transactions',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (showRecent) const Gap(24),
                Wrap(
                  runSpacing: 24,
                  children: showRecent
                      ? [
                    transactionHistoryWidget(context),
                    transactionHistoryWidget(
                      context,
                      title: 'Airtime Topup',
                      amount: '₦500',
                      svg: 'phone_history',
                    ),
                    transactionHistoryWidget(
                      context,
                      title: 'Electricity Purchase',
                      amount: '₦1500',
                      svg: 'electricity',
                    ),
                    transactionHistoryWidget(
                      context,
                      title: 'Topup',
                      amount: '₦150000',
                      svg: 'upload',
                    ),
                    transactionHistoryWidget(
                      context,
                      title: 'Electricity Purchase',
                      amount: '₦1500',
                      svg: 'electricity',
                    ),
                    transactionHistoryWidget(
                      context,
                      title: 'Airtime Topup',
                      amount: '₦500',
                      svg: 'phone_history',
                    ),
                    transactionHistoryWidget(
                      context,
                      title: 'Electricity Purchase',
                      amount: '₦1500',
                      svg: 'electricity',
                    ),
                    transactionHistoryWidget(
                      context,
                      title: 'Topup',
                      amount: '₦150000',
                      svg: 'upload',
                    ),
                    transactionHistoryWidget(
                      context,
                      title: 'Electricity Purchase',
                      amount: '₦1500',
                      svg: 'electricity',
                    ),
                  ]
                      : [
                    Container(
                      height: 250,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 26),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/wallet_ill.png'))),
                      child: Text(
                        'Sorry! You don’t have any wallet activities yet.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
class CurrencyList extends StatelessWidget {
  final CryptoController controller;

  const CurrencyList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.cryptoList.length,
      itemBuilder: (context, index) {
        final coin = controller.cryptoList[index];
        return Obx(() => CurrencyCardChart(
          currencyKey: coin['name'],
          currencyFullname: coin['name'],
          currencySymbol: "${controller.cryptoAmount.value} ${coin['symbol']}",
          rate: "${controller.cryptoRate.value}",
          trendData: controller.trendData,
          percentageChange: controller.percentageChange.value,
          percentageChangeColor: controller.percentageChangeColor.value,
        ));
      },
    );
  }
}


class CurrencyCard extends StatelessWidget {
  final String currencyKey;
  final String currencyFullname;
  final String currencySymbol;
  final String rate;
  final int isDefault;
  final String createdAt;

  const CurrencyCard({
    required this.currencyKey,
    required this.currencyFullname,
    required this.currencySymbol,
    required this.rate,
    required this.isDefault,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(1),
      child: ListTile(
        title: Text("$currencyKey ($currencyFullname)"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Currency Symbol: $currencySymbol", style: const TextStyle(
                fontFamily: 'Roboto'
            ),),
            Text("Rate: $rate"),
            Text("Is Default: ${isDefault == 1 ? 'Yes' : 'No'}"),
            Text("Created At: $createdAt"),
          ],
        ),
      ),
    );
  }
}
Widget transactionHistoryWidget(
    BuildContext context, {
      String title = '',
      String amount = '',
      String svg = '',
    }) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/icons/$svg.svg', // Path to your SVG asset
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          amount,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.green, // Adjust color as needed
          ),
        ),
      ],
    ),
  );
}
