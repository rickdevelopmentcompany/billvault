import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/button.dart';
import '../../../widgets/custom_textfield.dart';
import '../buy_giftcard/pin_bottomsheet.dart';


class TvBillView extends StatefulWidget {
  const TvBillView({super.key});

  @override
  State<TvBillView> createState() => TvBillViewState();
}

class TvBillViewState extends State<TvBillView> {
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
      appBar: AppBar(
        title: Text(
          'Cable Tv',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(MediaQuery.of(context).padding.top + 14),

                CustomTextfield(
                  label: 'Select Channel',
                  hintText: 'DSTV',
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
                                      'Select Tv',
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
                              tvSheetWidget(
                                context,
                                title: 'DSTV',
                                img: 'dstv',
                              ),
                              const Gap(16),
                              const Divider(
                                color: AppColors.greyBorderColor,
                              ),
                              const Gap(16),
                              tvSheetWidget(
                                context,
                                title: 'GOTV',
                                img: 'gotv',
                              ),
                              const Gap(16),
                              const Divider(
                                color: AppColors.greyBorderColor,
                              ),
                              const Gap(16),
                              tvSheetWidget(
                                context,
                                title: 'Startimes',
                                img: 'startimes',
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
                  label: 'Smartcard Number',
                  hintText: 'Enter smartcard number',
                ),
                const Gap(41),
                CustomTextfield(
                  label: 'Amount',
                  hintText: '₦',
                  ctrl: ctrl,
                  keyboardType: TextInputType.number,
                ),
                const Spacer(),
                primaryButton(context, color: AppColors.primaryColor, title: 'Confirm', onTap: () async {
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

Widget tvSheetWidget(
  BuildContext context, {
  required String title,
  required String img,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
        ),
        Image.asset('assets/images/$img.png'),
      ],
    );
