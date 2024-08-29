import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';

class BuyAirtimeView extends StatefulWidget {
  const BuyAirtimeView({super.key});

  @override
  State<BuyAirtimeView> createState() => BuyAirtimeViewtate();
}

class BuyAirtimeViewtate extends State<BuyAirtimeView> {
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
                    'Airtime',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
            const Gap(18),
            Container(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFB8B0B0),
                  ),
                ),
              ),
              // clipBehavior: Clip.hardEdge,
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                       await showModalBottomSheet(
                        context: context,
                        builder: (_) => IntrinsicHeight(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                const Gap(40),
                                InkWell(
                                  onTap: Navigator.of(context).pop,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Text(
                                        'Select Network',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                      ),
                                      SvgPicture.asset(
                                          'assets/svgs/cancel.svg'),
                                    ],
                                  ),
                                ),
                                const Gap(30),
                                networkWidget(context, img: 'mtn', name: 'MTN'),
                                const Gap(16),
                                const Divider(
                                  color: AppColors.greyBorderColor,
                                ),
                                const Gap(16),
                                networkWidget(context,
                                    img: 'airtel', name: 'Airtel'),
                                const Gap(16),
                                const Divider(
                                  color: AppColors.greyBorderColor,
                                ),
                                const Gap(16),
                                networkWidget(context, img: 'glo', name: 'GLO'),
                                const Gap(16),
                                const Divider(
                                  color: AppColors.greyBorderColor,
                                ),
                                const Gap(16),
                                networkWidget(context,
                                    img: '9mobile', name: '9Mobile'),
                                const Gap(36),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/mtn.png'),
                        SvgPicture.asset('assets/svgs/dropdown.svg'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onTap: () {},
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 4),
                        hintText: 'Enter mobile number',
                        hintStyle: TextStyle(fontSize: 12),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(35),
            Wrap(
              runSpacing: 12,
              spacing: 12,
              children: [],
            )
          ],
        ),
      ),
    );
  }
}

Widget priceButton(String amount) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF8F7F7),
      ),
      child: Row(children: [],),
    );

Widget networkWidget(BuildContext context,
        {required String name, required String img}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
        ),
        Image.asset('assets/images/$img.png'),
      ],
    );
