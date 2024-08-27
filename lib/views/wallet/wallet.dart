import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/views/home/dashboard.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

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
              Row(
                children: [
                  Text(
                    'Filter by:',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                  ),
                  const Gap(12),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F7F7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('All transactions'),
                        Gap(15),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ],
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
              Image.asset('assets/images/wallet_ill.png')
            ],
          ),
        ),
      ),
    );
  }
}
