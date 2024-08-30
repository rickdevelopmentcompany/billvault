import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';
import 'package:volex/utils/button.dart';
import 'package:volex/utils/custom_textfield.dart';
import 'package:volex/views/home/buy_giftcard/pin_bottomsheet.dart';

class BuyAirtimeView extends StatefulWidget {
  const BuyAirtimeView({super.key});

  @override
  State<BuyAirtimeView> createState() => BuyAirtimeViewtate();
}

class BuyAirtimeViewtate extends State<BuyAirtimeView> {
  late TextEditingController ctrl;
  bool viewDetails = true;

  @override
  void initState() {
    super.initState();
    ctrl = TextEditingController(text: '₦');
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          child: Padding(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                                    networkWidget(context,
                                        img: 'mtn', name: 'MTN'),
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
                                    networkWidget(context,
                                        img: 'glo', name: 'GLO'),
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
                  children: [
                    priceButton(context, '50'),
                    priceButton(context, '100'),
                    priceButton(context, '200'),
                    priceButton(context, '300'),
                    priceButton(context, '500'),
                    priceButton(context, '1000'),
                    priceButton(context, '2000'),
                    priceButton(context, '3000'),
                  ],
                ),
                const Gap(34),
                CustomTextfield(
                  label: 'Amount',
                  hintText: '₦',
                  ctrl: ctrl,
                  keyboardType: TextInputType.number,
                ),
                const Spacer(),
                primaryButton(context, title: 'Confirm', onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const PinBottomsheetView();
                      });
                }),
                const Gap(36),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

Widget priceButton(BuildContext context, String amount) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF8F7F7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '₦',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 8,
                ),
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
          )
        ],
      ),
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
