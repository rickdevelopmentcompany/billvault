import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/utils/nav_controller.dart';
import 'package:volex/views/home/dashboard.dart';
import 'package:volex/views/wallet/wallet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List navItems = [
    {
      'label': 'Home',
      'svg': 'assets/svgs/home_off.svg',
      'widget': const DashboardView()
    },
    {
      'label': 'Wallet',
      'svg': 'assets/svgs/wallet.svg',
      'widget': const WalletView()
    },
    {
      'label': 'Virtual Card',
      'svg': 'assets/svgs/card.svg',
      'widget': const DashboardView()
    },
    {
      'label': 'Profile',
      'svg': 'assets/svgs/person.svg',
      'widget': const DashboardView()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: navController,
        builder: (__, _) {
          return Scaffold(
            body: navItems[navController.selectedIndex]['widget'],
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              height: 74,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  navItems.length,
                  (index) {
                    final selected = index == navController.selectedIndex;
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        navController.updateIndex(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // color: selected
                          //     ? AppColors.primaryColor
                          //     : Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            Flexible(
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    navItems[index]['svg'],
                                    colorFilter: ColorFilter.mode(
                                      selected
                                          ? AppColors.primaryColor
                                          : AppColors.iconGreyColor2,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  if (selected)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      top: 0,
                                      child: SvgPicture.asset(
                                        'assets/svgs/on_home.svg',
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const Gap(8),
                            Text(
                              navItems[index]['label'],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: selected
                                        ? AppColors.primaryColor
                                        : AppColors.iconGreyColor2,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
