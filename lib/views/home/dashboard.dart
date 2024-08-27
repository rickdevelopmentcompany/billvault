import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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
              Image.asset('assets/images/dash_image.png'),
              const Gap(14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 4,
                  ),
                  Gap(7),
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: AppColors.primaryColor,
                  ),
                  Gap(7),
                  CircleAvatar(
                    radius: 4,
                  ),
                ],
              ),
              const Gap(16),
              Wrap(
                // alignment: WrapAlignment.start,
                // crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 14,
                runSpacing: 14,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    height: 139,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xBFC3E9E9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFF39D6D6),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/svgs/dash_giftcard.svg',
                            ),
                          ),
                        ),
                        const Gap(16),
                        Text(
                          'Buy Gift Card',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 139,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xBFF7F4A9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFF752999),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/svgs/bill.svg',
                            ),
                          ),
                        ),
                        const Gap(16),
                        Text(
                          'Bill Payment',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    height: 139,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xBFF7A9B7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFF2083AE),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/svgs/dash_crypto.svg',
                            ),
                          ),
                        ),
                        const Gap(16),
                        Text(
                          'Crypto',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget dashCard(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF030D13),
        borderRadius: BorderRadius.circular(16),
      ),
      height: 140,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 11,
                    ),
                    Gap(5),
                    Text('Euro currency'),
                    Gap(5),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor,
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const Gap(11),
          Text(
            'Account balance',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.white.withOpacity(.8),
                ),
          ),
          const Gap(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '€',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white,
                    ),
              ),
              const Gap(8),
              Text(
                ' 2580,440.30',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
              ),
              const Gap(8),
              const Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
