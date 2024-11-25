import 'package:billvaoit/resources/utils/app_colors.dart';
import 'package:billvaoit/resources/views/home/bills_payment/airtime_bill_view.dart';
import 'package:billvaoit/resources/views/home/buy_giftcard/pin_bottomsheet.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../app/http/controllers/exchange_controller.dart';

class ExchangeScreen extends StatefulWidget {

  State<ExchangeScreen> createState() => ExchangeScreenState();
}

class ExchangeScreenState extends State<ExchangeScreen>{
  late ExchangeController controller = Get.put(ExchangeController());
  late TextEditingController fromController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ini();
  }

  Future<void> ini() async{

    controller.isLoading.value = true;
    controller.exchangeMoneyForm();
    print(controller.fromCryptos);
    controller.isLoading.value = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchange Coin', style: TextStyle(fontSize: 15),),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: Get.back,
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: controller.isLoading.value ? const UsableLoading() : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(22),
            const Center(
              child: Text(
                'You Convert',
                style: TextStyle(fontSize: 16,),
              ),
            ),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius:  BorderRadius.circular(32),
              ),
              child: Obx((){
                return Container(
                    padding: const EdgeInsets.all(8.0), // Optional padding
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color for the container
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners (optional)
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), // Shadow color
                          spreadRadius: 2, // How far the shadow spreads
                          blurRadius: 2,   // The blur effect for the shadow
                          offset: const Offset(0, 1), // Shadow position (x, y)
                        ),
                      ],
                    ),
                    child:TextField(
                      keyboardType: TextInputType.number,
                      controller: fromController,
                      // readOnly: controller.disable.value,
                      onChanged: (value) {
                        // Update the controller's amount with the input value

                        controller.setAmount(value.toString(),controller.fromCrypto.value.toString());
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter amount',
                        hintStyle: const TextStyle(fontSize: 17),
                        // suffixIcon: Icon(Icons.search),
                        suffix: Text(controller.fromCrypto.value),
                        // contentPadding: const EdgeInsets.all(20),
                      ),
                    ));
              }),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text('You Receive', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 8),
            Obx(() => Container(
              padding: EdgeInsets.all(15.0), // Optional padding
              decoration: BoxDecoration(
                color: Colors.white, // Background color for the container
                borderRadius: BorderRadius.circular(8.0), // Rounded corners (optional)
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Shadow color
                    spreadRadius: 2, // How far the shadow spreads
                    blurRadius: 5,   // The blur effect for the shadow
                    offset: Offset(0, 1), // Shadow position (x, y)
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.amount.value}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Obx((){
                    return Text(
                      controller.toCrypto.value,
                      style: const TextStyle(fontSize: 18),
                    );
                  }),
                ],
              ),
            )),

            SizedBox(height: 16),
            _buildExchangeSection(),
            Spacer(),

            SizedBox(height: 20),
            Obx(() {
              // Show snackbar if `disable` is true
              // if (controller.disable.value) {
              //   Future.delayed(Duration.zero, () {
              //     Get.snackbar(
              //       'Error',
              //       'Amount exceeds balance or is invalid',
              //       snackPosition: SnackPosition.BOTTOM,
              //       backgroundColor: Colors.red,
              //       colorText: Colors.white,
              //     );
              //   });
              //   return Container(); // Return an empty container to avoid rendering the button when disabled
              // }

              // Return the button if `disable` is false
              return controller.disable.value ? Container() : ElevatedButton(
                onPressed: () async {
                  // Exchange action
                  // print('submitted');
                  if(controller.amount.value == '' || controller.toCrypto.value == '' || controller.fromCrypto.value == ''){
                    Get.snackbar(
                      'Error',
                      'Please check your Exchange information.',
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(Icons.warning_amber_rounded),
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }else {
                    GetStorage().write('from_crypto',controller.fromCryptoData);
                    GetStorage().write('to_crypto',controller.toCryptoData);
                    GetStorage().write('from_crypto_amount',fromController.text);
                    GetStorage().write('to_crypto_amount',controller.amount.value);



                    Get.delete<ExchangeController>();
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const PinBottomsheetView(action: 'exchange');
                      },
                    );
                  }
                },
                child: Text(
                  'Exchange',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.green, // Example color, replace with your custom color
                ),
              );
            })

          ],
        ),
      ),
    );
  }
  Widget _buildExchangeSection() {
    return Obx(() => Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDropdown(
            img: controller.fromCrypto.value.toString().toLowerCase(),
            label: 'From',
            value: controller.fromCrypto.value,
            items: controller.fromCryptos,
            onChanged: (value) {
              controller.setFromCrypto(value);
              // controller.setAmount(controller.amount.value, controller.toCrypto.value);
            },
          ),
          Icon(Icons.swap_horiz),
          _buildDropdown(
            img: controller.toCrypto.value.toString().toLowerCase(),
            label: 'To',
            value: controller.toCrypto.value,
            items: controller.toCryptos,
            onChanged: (value) {
              controller.setToCrypto(value);
              // controller.setAmount(controller.amount.value, controller.fromCrypto.value);
            },
          ),
        ],
      ),
    ));
  }


  Widget _buildDropdown({
    required String img,
    required String label,
    required String value,
    required RxList<Map<String, dynamic>> items,
    required Function(String) onChanged, // Change this
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(child: Text(label, style: const TextStyle(fontSize: 16)),),
        DropdownButton<String>(
          underline: const SizedBox(),
          value: value.isEmpty ? null : value,
          items: items.map((crypto) {
            return DropdownMenuItem<String>(
              value: crypto['currency']['currency_code'],
              child: Row(
                children: [
                  Image.asset('assets/images/${crypto['currency']['currency_code'].toString().toLowerCase()}.png', height: 20,width:20,),
                  Gap(10),
                  Text('${crypto['currency']['currency_code']}',
                    style: const TextStyle(fontFamily: 'Algerian'),
                  )
                ],
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              onChanged(val); // Ensure that the function returns void
            }
          },
        ),
      ],
    );
  }
}
