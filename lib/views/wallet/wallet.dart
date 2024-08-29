import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/views/home/dashboard.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(MediaQuery.of(context).padding.top + 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primaryColor,
                      ),
                      Gap(8),
                      Text('Hi Divine 👋🏿'),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Add money',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: const Color(0xFF18191F),
                                  ),
                        ),
                        const Gap(8),
                        SvgPicture.asset('assets/svgs/add.svg'),
                        const Gap(8),
                        SvgPicture.asset('assets/svgs/notification.svg'),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(24),
              dashCard(context),
              const Gap(13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF003130),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 35,
                      child: Text(
                        'Transfer',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                  // const Gap(28),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF003130),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 35,
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
                ],
              ),
              const Gap(23),
              if (!onAsset) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Asset',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 20,
                            ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            onAsset = !onAsset;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                          child: Text(
                            'Transaction',
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
                const Gap(13),
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
                        // height: 40 * MediaQuery.of(context).textScaler.scale(1),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F7F7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        // margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
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
                  // mainAxisSize: MainAxisSize.min,
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
                              'Sorry! You don’t have any wallet activities yet..',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                            ),
                          ),
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
                    color: const Color(0xFF6C757D)),
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

Widget transactionHistoryWidget(
  BuildContext context, {
  String? svg,
  String? title,
  String? date,
  String? amount,
  String status = 'Completed',
  bool isCredit = true,
}) =>
    Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFF003130),
          radius: 16,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: svg == null
                ? Image.asset('assets/images/${svg ?? 'bitcoin'}.png')
                : SvgPicture.asset('assets/svgs/$svg.svg'),
          ),
        ),
        const Gap(14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? 'Crypto(Bitcoin)',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            Text(
              date ?? 'march 14, 2024  2:25 PM',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // -₦
                Text(
                  isCredit ? '-' : '+',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                ),
                Text(
                  amount ?? '0.0003BTC',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                ),
              ],
            ),
            Text(
              status,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: const Color(0xFF15DF42),
                  ),
            ),
          ],
        )
      ],
    );
