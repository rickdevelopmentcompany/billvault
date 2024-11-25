import 'dart:io';

import 'package:billvaoit/app/http/controllers/payment_controller.dart';
import 'package:billvaoit/resources/utils/app_colors.dart';
import 'package:billvaoit/resources/views/home/crypto/trade_success.dart';
import 'package:billvaoit/resources/views/success_view.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../utils/button.dart';
import '../buy_giftcard/pin_bottomsheet.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Ensure this package is installed
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/http/controllers/crypto_controller.dart';

class SellCryptoScreen extends StatefulWidget {
  const SellCryptoScreen({super.key});

  @override
  State<SellCryptoScreen> createState() => SellCryptoScreenState();
}


class SellCryptoScreenState extends State<SellCryptoScreen>{
  // final CryptoController controller = Get.put(CryptoController());
  TextEditingController amountController = TextEditingController();
  PaymentController paymentController = Get.put(PaymentController());
  dynamic manualDepositDatas = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetStorage storage  = GetStorage();
    var trx = storage.read('trx');
    print(trx);
    initialiseState();
  }


  @override
  void dispose() {
    // ctrl.dispose();
    super.dispose();
  }


  Future<void> initialiseState() async {
    GetStorage storage  = GetStorage();
    var trx = storage.read('trx');
    print(trx);
    print('Loading start...');
    paymentController.isLoading.value = true;
    await paymentController.manualDepositConfirm(trx);
    paymentController.isLoading.value = false;
    manualDepositDatas = paymentController.manualDepositDatas;
    amountController.text = double.parse('${manualDepositDatas['data']['amount']}').toStringAsFixed(4);
    print('Loading stop...');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          height: 10,  width: 10,
        child: InkWell(
          onTap: () {
            // Add your onTap functionality here
            // paymentController.isLoading.value = false;
            Get.back();
          },
          child:   Container(

            child: const Icon(Icons.arrow_back_ios_new_sharp,
            size: 15,
            ),
          ),
        )),
      ),
      body: Obx((){
        return paymentController.isLoading.value ? const UsableLoading() : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('',
                        style: const TextStyle(fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () async {
                          var contact = "234811121816";
                          var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I want to buy crpto";
                          var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I want to buy crpto')}";

                          try{
                            if(Platform.isIOS){
                              await launchUrl(Uri.parse(iosUrl));
                            }
                            else{
                              await launchUrl(Uri.parse(androidUrl));
                            }
                          } on Exception{
                            EasyLoading.showError('WhatsApp is not installed.');
                          }
                        },
                        child:  Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.4),
                              borderRadius: BorderRadius.all(Radius.circular(22)),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Buy Crypto',
                                  style: TextStyle(fontSize:12),),
                                Icon(Icons.arrow_right_alt)
                              ],
                            )
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: AppColors.primaryColor.withOpacity(0.1)
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text(
                            //    'Coin',
                            //    style: TextStyle(color: Colors.grey),
                            //  ),
                            SizedBox(height: 8),
                            Visibility(
                                visible: false,
                                child:
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800]?.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:  Row(
                                    children: [
                                      // Icon(Icons.currency_bitcoin, color: Colors.yellow),
                                      SizedBox(width: 8),
                                      // Text(
                                      //   name,
                                      //   style: TextStyle(color: Colors.black),
                                      // ),
                                      Spacer(),
                                      // Icon(Icons.arrow_drop_down, color: Colors.white),
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 16),
                            // Row(
                            //   // crossAxisAlignment: CrossAxisAlignment.s,
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text('Enter Amount:'),
                            //     Text(
                            //       '${manualDepositDatas['data']['amount']}',
                            //       style: TextStyle(color: Colors.grey),
                            //     )
                            //   ],
                            // ),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: amountController ,
                              onChanged: (value) {
                                // controller.calculateCryptoAmount(ngnAmount: double.parse(amountController.text) );
                              },
                              readOnly: true,
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // Adjust padding to reduce height
                                suffixText: '${manualDepositDatas['data']['method_currency']}',
                              ),
                            ),
                            SizedBox(height: 18),
                            // Obx((){
                            //   return Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       Text('Amount: ${controller.cryptoAmount.value.toStringAsFixed(6)}'),
                            //     ],
                            //   );
                            // }),
                            const Center(
                              child: Text(' make your payment below👇',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Gap(25),
                            Center(
                              child: Text('${manualDepositDatas['gateway']['description']}', style: const TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(height: 30),
                            // Correctly use QrImage
                            Center(
                              child: QrImageView(
                                data: manualDepositDatas['gateway']['description'],  // Pass the wallet address to generate the QR code
                                size: 250.0,
                                version: QrVersions.auto, // Optional
                              ),
                            ),
                            Center(
                              child: Text('Scan ')
                            ),
                            const SizedBox(height: 16),

                            const SizedBox(height: 56),
                            Row(
                              children: [
                                Expanded(
                                    child:    primaryButton(context, color: AppColors.primaryColor, title: 'Confirm',
                                        onTap: () async {

                                          Get.delete<PaymentController>();
                                          PaymentController bill = Get.put(
                                              PaymentController());
                                          bill.isLoading.value = true;
                                          await bill.manualDepositUpdate();
                                          // await showModalBottomSheet(
                                          //   context: context,
                                          //   builder: (context) {
                                          //     return const PinBottomsheetView(action: 'add_money',);
                                          //   },
                                          // )  ;
                                        })
                                ),
                                const SizedBox(width: 10), // Add some space between the buttons
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: manualDepositDatas['gateway']['description'])); // Copy the address to the clipboard
                                      Get.snackbar('', 'Address copied to clipboard');
                                    },
                                    child: const Text('Copy Address'),
                                  ),
                                ),
                              ],
                            ),
                            Gap(20),

                          ],
                        ),

                        const SizedBox(height: 20),
                        // Amount Input

                      ],
                    ),
                  ),
                  const SizedBox(height: 20),


                ],
              ),
            ));
      }
    ),
    );
  }


}
