import 'package:billvaoit/resources/views/home/crypto/crypto_exchange_screen.dart';
import 'package:billvaoit/resources/views/home/crypto/sell_coin.dart';
import 'package:billvaoit/resources/views/webview_screen.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:billvaoit/app/http/controllers/crypto_controller.dart';
import 'package:billvaoit/resources/views/home/crypto/sell_crypto.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../../app/http/controllers/payment_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/usable_dashboard_slider.dart';
import '../add_money/add_money.dart';
import 'deposit/deposit_coin.dart';
import 'dart:math';

class CryptoView extends StatefulWidget {
  const CryptoView({super.key});

  @override
  State<CryptoView> createState() => CryptoViewState();
}


class CryptoViewState extends State<CryptoView> {
  // late CryptoController cryptoController;
  bool viewDetails = true;
  final random_num = Random(2);
  late PaymentController paymentController;
  List<Map<String, dynamic>> wallets = [];
  late TextEditingController amountController;
  GetStorage storage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseState();
  }


  @override
  void dispose() {
    // ctrl.dispose();
    super.dispose();
  }

  Future<void> initialiseState() async {
    amountController = TextEditingController(text: '0');
    paymentController = Get.put(PaymentController());
    paymentController.isLoading.value = true;
    print('Loading started...');
    await paymentController.getDepositMethods();
    print("Loading ended....");
    print(paymentController.depositWallets);
    paymentController.isLoading.value = false;
  }
  @override
  Widget build(BuildContext context) {
    // cryptoController = Get.put(CryptoController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Crypto',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: Obx((){
        return paymentController.isLoading.value ? const UsableLoading() : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Gap(MediaQuery.of(context).padding.top + 24),
              const Gap(52),
              const UsableDashboardSlider(imagePaths: [
                'assets/images/img_3.png',
                'assets/images/dash_image.png',
                'assets/images/img_2.png',
              ]),
              const Gap(14),
              Text(
                'Click any coin to start trading',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const Gap(28),

              // Removing nested SingleChildScrollView, this column will scroll
              // Column(
              //   children: paymentController.depositWallets.map((crypto) {
              //     print(crypto);
              //     // Access currency and other properties directly
              //     String currencyCode = crypto['currency']['currency_code'];
              //     String currencySymbol = crypto['currency']['currency_symbol'];
              //     String assetName = crypto['currency']['currency_fullname'];
              //     String balance = crypto['balance'].toString();
              //
              //     // Generate random percentage between -50% and +50%
              //     double randomPercent = (random_num.nextDouble() * 100) - 50;
              //     String percent = "${randomPercent.toStringAsFixed(2)}%";
              //
              //     return InkWell(
              //       onTap: () {
              //         // storage.write('sell_crypto', {
              //         //   'name': assetName,
              //         //   'short_name': currencyCode,
              //         //   'address': crypto['address'] ?? '',
              //         // });
              //         // Get.to(SellCryptoScreen());
              //       },
              //       child: Column(
              //         children: [
              //           const Gap(10),
              //           Container(
              //             padding: const EdgeInsets.symmetric(horizontal: 10),
              //             decoration: BoxDecoration(
              //               borderRadius: const BorderRadius.all(Radius.circular(12)),
              //               color: Colors.white,
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black.withOpacity(0.1),
              //                   spreadRadius: 1,
              //                   blurRadius: 1,
              //                 ),
              //               ],
              //             ),
              //             child: assetWidget(
              //               context,
              //               decrease:true,
              //               percent: '12',
              //               assetName: assetName, // Use the full name of the currency
              //               amount: '${balance} $currencyCode', // Show the balance with the currency code
              //               nairaAmount: '\$${(balance * crypto['currency']['rate'])}', // Convert to a display amount
              //               img: currencyCode.toLowerCase(), // Assuming this is the image asset name
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   }).toList(),
              // ),
              Column(
                children: List.generate(paymentController.depositWallets.length, (index) {
                  final bundle = paymentController.depositWallets[index];
                  double rate = double.parse(bundle['currency']['rate'].toString());
                  double balance = double.parse(bundle['balance'].toString());

                  String bal;

                  if (balance == 0) {
                    bal = '0.00'; // You can adjust this as needed
                  } else {
                    double result =  balance * rate;
                    // Format with commas and two decimal places
                    bal = NumberFormat('#,##0.00').format(result);
                  }
                  double ba = double.parse(bundle['currency']['rate']);
                  String nairaAmount =
                      '${NumberFormat('#,##0.00').format(ba)}/₦';
                  return InkWell(
                    onTap: () async {
                      paymentController.isLoading.value = true;
                      paymentController.setSelectedWallet(bundle['currency']['currency_fullname']);
                      print( bundle['currency']['currency_code'].toString().toLowerCase());
                      paymentController.min_amount.value = '';
                      paymentController.max_amount.value = '';
                      paymentController.rate.value = '';
                      paymentController.paymentCurrencyShortCode.value = '';
                      // plan = bundle;
                      wallets = await  paymentController.getGateways(bundle['currency_id'].toString());
                      // paymentContrzoller.exchangeConfirm();
                      GetStorage().write('crypto_wallets', wallets);
                      GetStorage().write('crypto_', bundle);

                      paymentController.isLoading.value = false;
                      // ctrl.text = bundle['price'].toString();
                      // print(data_bundle);
                      // print(billPaymentsController.selectedDataBundle.value); // Use .value
                      // Navigator.pop(context);
                      Get.delete<PaymentController>();
                      Get.to(()=> ExchangeScreen());
                      // Get.to(()=> const WebViewScreen(redirectUrl: 'https://billvaolt.payvalue.com.ng/user/exchange/money'));
                    },
                    child: Column(
                      children: [
                        bundle['currency']['currency_code'] != 'NGN' && bundle['currency']['currency_code'] != 'USD' ? assetWidget(
                                      context,
                                      decrease:false,
                                      percent: 'Bal ~ ₦$bal' ,
                                      assetName: bundle['currency']['currency_fullname'], // Use the full name of the currency
                                      amount: '${double.parse(bundle['balance'].toString()).toStringAsFixed(4)} ${bundle['currency']['currency_symbol'].toString().toUpperCase()}', // Show the balance with the currency code
                                      nairaAmount: nairaAmount , // Convert to a display amount
                                      img: bundle['currency']['currency_code'].toString().toLowerCase(), // Assuming this is the image asset name
                                    ): Container(),
                        // addMoneyWidget(
                        //   context,
                        //   title: bundle['currency']['currency_fullname'],
                        //   img: bundle['currency']['currency_code'].toString().toLowerCase(),
                        // ),
                        const Gap(16),
                        // if (index != paymentController.depositWallets.length - 1)
                        //   const Divider(color: AppColors.greyBorderColor),
                      ],
                    ),
                  );
                }),
              ),
              const Gap(20), // Add gap to ensure there is space at the bottom
            ],
          ),
        ),
      );
  }),
    );
  }
}
