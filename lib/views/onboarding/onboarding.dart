import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/utils/button.dart';
import 'package:volex/views/auth_views/login.dart';
import 'package:volex/views/auth_views/sign_up.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(MediaQuery.of(context).padding.top + 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Simplify Your Finances',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: Colors.white,
                    ),
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Volex App allows you to Transfer from euro account to African, trade crypto, pay bills, and get visual cards. Streamline your financial management with our easy-to-use and reliable platform',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 17,
                    ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/person.png',
                      scale: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        primaryButton(
                          context,
                          title: 'Get Started',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const SignupView(),
                            ));
                          },
                        ),
                        const Gap(30),
                        // const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have an account? ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const LoginView(),
                                ));
                              },
                              child: Text(
                                'Login now',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(38),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Stack(
            //   children: [
            //     Positioned(
            //       top: 0,
            //       child: Image.asset('assets/images/1.png'),
            //     ),
            //     Positioned(
            //       bottom: 0,
            //       child: Image.asset('assets/images/person.png'),
            //     ),
            //     Positioned(
            //       bottom: 20,
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           primaryButton(
            //             context,
            //             title: 'Get Started',
            //             onTap: () {
            //               Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (_) => const SignupView(),
            //               ));
            //             },
            //           ),
            //           const Gap(10),
            //           Row(
            //             children: [
            //               Text(
            //                 'Have an account? ',
            //                 style: Theme.of(context)
            //                     .textTheme
            //                     .labelLarge
            //                     ?.copyWith(
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 16,
            //                     ),
            //               ),
            //               InkWell(
            //                 onTap: () {
            //                    Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (_) => const LoginView(),
            //               ));
            //                 },
            //                 child: Text(
            //                   'Login now',
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .labelLarge
            //                       ?.copyWith(
            //                         color: AppColors.primaryColor,
            //                         fontWeight: FontWeight.w700,
            //                         fontSize: 16,
            //                       ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
