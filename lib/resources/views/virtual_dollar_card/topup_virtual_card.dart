
import 'dart:async';
import 'dart:convert';

import 'package:billvaoit/app/http/controllers/deposit_controller.dart';
import 'package:billvaoit/app/http/controllers/payment_controller.dart';
import 'package:billvaoit/resources/utils/app_colors.dart';
import 'package:billvaoit/resources/views/home/crypto/sell_crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../app/Models/user/User.dart';
import '../../../../routes/routes.dart';
import '../../../app/http/controllers/virtual_card_controller.dart';
import '../../utils/button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/usable_loading.dart';

class TopupVirtualcard extends StatefulWidget {
  const TopupVirtualcard({super.key});

  @override
  State<TopupVirtualcard> createState() => TopupVirtualcardState();
}


class TopupVirtualcardState extends State<TopupVirtualcard>{
  VirtualDollarCardController virtualDollarCardController = Get.put(VirtualDollarCardController());
  PaymentController paymentController = Get.put(PaymentController());
  List<Map<String, dynamic>> wallets = [];
  late TextEditingController amountController;
  GetStorage storage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseState();
  }

  Future<void> initialiseState() async {
    PaymentController paymentController = Get.put(PaymentController());
    amountController = TextEditingController(text: '0');
    print('Loading started...');
    await paymentController.getDepositMethods();
    // Initialize the controller here
    virtualDollarCardController.isLoading.value = true;
    virtualDollarCardController = Get.put(VirtualDollarCardController());
    await virtualDollarCardController.hasCardMethod();
    await virtualDollarCardController.cardDetails();
    await Future.delayed(const Duration(seconds: 5));
    virtualDollarCardController.isLoading.value = false;
    print("Loading ended....");
    paymentController.isLoading.value = false;
  }

  @override
  void dispose() {
    // ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Top up',
          style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20),),
      ),
      body: Obx((){
        return paymentController.isLoading.value ? const UsableLoading() :
        CustomScrollView(slivers: [
          SliverFillRemaining(
              child: Stack(
                  children: [Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(28),

                        // Gap(14),
                        Obx((){
                          return  CustomTextfield(
                            label: 'Choose wallet',
                            hintText: paymentController.selectedWallet.value != ''
                                ? paymentController.selectedWallet.value
                                : "Choose your wallet",
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
                                    child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const Gap(18),
                                            Column(
                                              children: List.generate(paymentController.depositWallets.length, (index) {
                                                final bundle = paymentController.depositWallets[index];
                                                return InkWell(
                                                  onTap: () async {
                                                    paymentController.isLoading.value = true;
                                                    paymentController.setSelectedWallet(bundle['currency']['currency_fullname']);
                                                    String curName = bundle['currency']['currency_code'].toString().toLowerCase();
                                                    print(bundle['currency'] );
                                                    curName == 'ngn' ?paymentController.rate.value = '' : paymentController.rate.value = '';
                                                    paymentController.min_amount.value = '1';
                                                    paymentController.max_amount.value = '1000';

                                                    paymentController.paymentCurrencyShortCode.value = '';
                                                    // plan = bundle;
                                                    wallets = await  paymentController.getGateways(bundle['currency_id'].toString());

                                                    paymentController.isLoading.value = false;
                                                    Navigator.pop(context);
                                                  },
                                                  child:


                                                      bundle['currency']['currency_code'] != 'USD' ? Container() :
                                                  Column(
                                                    children: [
                                                      addMoneyWidget(
                                                        context,
                                                        title: bundle['currency']['currency_fullname'],
                                                        img: bundle['currency']['currency_code'].toString().toLowerCase(),
                                                      ),
                                                      const Gap(16),
                                                      if (index != paymentController.depositWallets.length - 1)
                                                        const Divider(color: AppColors.greyBorderColor),
                                                    ],
                                                  ) ,
                                                );
                                              }),
                                            ),
                                            const Gap(36),
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                        const Gap(23),
                        Column(
                          children: [

                            CustomTextfield(
                              label: 'Amount',
                              // hintText: amountController.text,
                              ctrl: amountController,
                              keyboardType: TextInputType.number,
                              // readOnly: true,
                            ),
                            Obx((){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Text(
                                    ' limit : \$${paymentController.min_amount.value} ~ \$${paymentController.max_amount.value}',
                                    style: const TextStyle(
                                        color: Colors.orange
                                    ),
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                        const Spacer(),
                        primaryButton(context, color: AppColors.primaryColor, title: 'Confirm',
                            onTap: () async {
                              String _min = paymentController.min_amount.value.toString().replaceAll('Min ','');
                              String _max = paymentController.max_amount.value.toString().replaceAll('Max ','');
                              dynamic min = 1;//double.parse(_min);
                              dynamic max = 1000; //double.parse(_max);
                              print('paymentController.selectedWallet.value; ${paymentController.selectedWallet.value}');
                              print('amountController.text: ${amountController.text}');
                              if(paymentController.selectedWallet.value == ''){
                                Get.snackbar(
                                  'Error',
                                  'Try select your wallet',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
                                );
                              }else if(double.parse(amountController.text.toString()) == 0 ){
                                Get.snackbar(
                                  'Error',
                                  'Enter amount',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
                                );
                              }else if(double.parse(amountController.text.toString()) < min || double.parse(amountController.text.toString()) > max ){
                                Get.snackbar(
                                  'Error',
                                  'Check Limit',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
                                );
                              }else {
                                paymentController.isLoading.value = true;
                                dynamic amount = int.parse(amountController.text) * 100;

                                await virtualDollarCardController.fundCard(amount.toString());
                                Get.delete<VirtualDollarCardController>();
                                Get.delete<PaymentController>();
                                // storage.write("deposit_amount",double.parse(amountController.text.toString()) );
                                // print(max);
                                // paymentController.isLoading.value = true;
                                // await paymentController.depositInsert();
                                // paymentController.isLoading.value = false;
                                // Get.delete(PaymentController());
                                // Get.to(const SellCryptoScreen());

                              }
                            }
                        ),
                        const Gap(36),
                      ],
                    ),
                  ),
                    Obx((){
                      return paymentController.isLoading.value ? UsableLoading() : Container();
                    })
                  ]
              )
          ),
        ]);



      }),
    );
  }

}


Widget addMoneyWidget(
    BuildContext context, {
      required String title,
      required String? img,
    }) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded( // To ensure the text fits within available space
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Use Axis.horizontal for horizontal scrolling
                child:Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                )
            )
        ),
        Image.asset('assets/images/$img.png',
          height: 30, width: 30,
        ),
      ],
    );