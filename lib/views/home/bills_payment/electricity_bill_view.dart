import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/button.dart';
import 'package:volex/utils/custom_textfield.dart';
import 'package:volex/views/home/buy_giftcard/pin_bottomsheet.dart';

class ElectricityBillView extends StatefulWidget {
  const ElectricityBillView({super.key});

  @override
  State<ElectricityBillView> createState() => ElectricityBillViewState();
}

class ElectricityBillViewState extends State<ElectricityBillView> {
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
                        'Electricity',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                      ),
                    ],
                  ),
                ),
                const Gap(32),
                CustomTextfield(
                  label: 'City',
                  ctrl: TextEditingController(text: 'Ikeja Electric'),
                  keyboardType: TextInputType.number,
                  trailingSvg: 'dropdown',
                  readOnly: true,
                  callback: () async {
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
                                      'Electricity',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                    ),
                                    SvgPicture.asset('assets/svgs/cancel.svg'),
                                  ],
                                ),
                              ),
                              const Gap(30),
                              electricSheetWidget(
                                context,
                                title: 'Ikeja',
                              ),
                              const Gap(16),
                              const Gap(16),
                              electricSheetWidget(
                                context,
                                title: 'Abuja',
                              ),
                              const Gap(16),
                              const Gap(16),
                              electricSheetWidget(
                                context,
                                title: 'Ibadan',
                              ),
                              const Gap(36),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Gap(23),
                const CustomTextfield(
                  label: 'Prepaid Item',
                  hintText: 'Prepaid',
                ),
                const Gap(41),
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

Widget electricSheetWidget(
  BuildContext context, {
  required String title,
}) =>
    Row(
      children: [
        Image.asset('assets/images/ie.png'),
        const Gap(18),
        Text(
          '$title electric',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
        ),
      ],
    );
