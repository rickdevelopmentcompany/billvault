import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../app/http/controllers/bill_payments.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/button.dart';
import '../../../widgets/custom_textfield.dart';
import '../buy_giftcard/pin_bottomsheet.dart';
import 'package:get/get.dart';

class BuyDataView extends StatefulWidget {
  const BuyDataView({super.key});

  @override
  State<BuyDataView> createState() => BuyDataViewtate();
}

class BuyDataViewtate extends State<BuyDataView> {
  late TextEditingController ctrl;
  bool viewDetails = true;
  BillPaymentsController billPaymentsController = Get.put(BillPaymentsController());
  List<Map<String, dynamic>> bundles = [];

  @override
  void initState() {
    super.initState();
    ctrl = TextEditingController(text: '₦');
    fetchDataBundles();
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  // Assuming this is in an async function
  Future<void> fetchDataBundles() async {
    BillPaymentsController billPaymentsController = Get.put(BillPaymentsController());

    // Await the future to get the actual data
    bundles = await billPaymentsController.getataBundles();

    // Now you can use the `bundles` list
    print(bundles);
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
                        'Data',
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(),
                                          Text(
                                            'Select Network',
                                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SvgPicture.asset('assets/svgs/cancel.svg'),
                                        ],
                                      ),
                                    ),
                                    const Gap(30),
                                    networkWidget(context, img: 'mtn', name: 'MTN', action: ()=> {billPaymentsController.setNetworkLogo('mtn'), Navigator.pop(context)}),
                                    const Gap(16),
                                    const Divider(color: AppColors.greyBorderColor),
                                    const Gap(16),
                                    networkWidget(context, img: 'airtel', name: 'Airtel', action: ()=> {billPaymentsController.setNetworkLogo('airtel'), Navigator.pop(context)}),
                                    const Gap(16),
                                    const Divider(color: AppColors.greyBorderColor),
                                    const Gap(16),
                                    networkWidget(context, img: 'glo', name: 'GLO', action: ()=>{ billPaymentsController.setNetworkLogo('glo'), Navigator.pop(context)}),
                                    const Gap(16),
                                    const Divider(color: AppColors.greyBorderColor),
                                    const Gap(16),
                                    networkWidget(context, img: '9mobile', name: '9Mobile', action: ()=> { billPaymentsController.setNetworkLogo('9mobile'), Navigator.pop(context)}),
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
                            Obx((){
                              return Image.asset('assets/images/${billPaymentsController.networkLogo.value}.png');
                            }),
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
                const Gap(38),
                CustomTextfield(
                  label: 'Select Bundle',
                  hintText: 'Select Bundles',
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
                                      'Select Bundle',
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
                              Column(
                                children: List.generate(bundles.length, (index) {
                                  final bundle = bundles[index];
                                  return Column(
                                    children: [
                                      bundleWidget(
                                        context,
                                        title: bundle['desc'],
                                        value: bundle['price'],
                                      ),
                                      const Gap(16), // Add Gap between widgets
                                      if (index != bundles.length - 1) // Only add Divider if it's not the last item
                                        const Divider(
                                          color: AppColors.greyBorderColor,
                                        ),
                                    ],
                                  );
                                }),
                              ),
                              // const Gap(16),
                              // const Divider(
                              //   color: AppColors.greyBorderColor,
                              // ),
                              // const Gap(16),
                              // bundleWidget(
                              //   context,
                              //   title: '160MB for 30 days',
                              //   value: '₦150',
                              // ),
                              const Gap(46),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                 primaryButton(context,
                     color: AppColors.primaryColor, title: 'Confirm', onTap: () async {
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

Widget networkWidget(BuildContext context, {required String name, required String img, dynamic action}) => InkWell(
  onTap: action,
  child:  Row(
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
  ),
);

Widget bundleWidget(
  BuildContext context, {
  required String title,
  required String value,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
            fontFamily: 'Roboto'
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              fontFamily: 'Roboto'
              ),
        ),
      ],
    );
