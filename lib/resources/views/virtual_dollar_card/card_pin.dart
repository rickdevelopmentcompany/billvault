import 'package:billvaoit/resources/utils/app_colors.dart';
import 'package:billvaoit/resources/views/home/dashboard.dart';
import 'package:billvaoit/resources/views/virtual_dollar_card/virtual_dollar_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/http/controllers/virtual_card_controller.dart';
import '../home.dart';
import '../success_view.dart';

class PinScreen extends StatelessWidget {
  final TextEditingController pinController1 = TextEditingController();
  final TextEditingController pinController2 = TextEditingController();
  // final CardPinController controller = Get.put(CardPinController());
  VirtualDollarCardController virtualDollarCardController = Get.put(VirtualDollarCardController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFF),
      appBar: AppBar(
        title: Text("Set PIN",style: TextStyle(fontSize: 14),),
        backgroundColor: Color(0xFFFFFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            // First PIN input
            CustomTextField(
              label: "First PIN",
              hintText: "Enter First PIN",
              controller: pinController1,
              obscureText: true,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.length != 4) {
                  return "PIN must be 4 digits.";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            // Second PIN input
            CustomTextField(
              label: "Second PIN",
              hintText: "Enter Second PIN",
              controller: pinController2,
              obscureText: true,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.length != 4) {
                  return "PIN must be 4 digits.";
                }
                if (value != pinController1.text) {
                  return "PINs do not match.";
                }
                return null;
              },
            ),
            SizedBox(height: 40),

            Spacer(),
            ElevatedButton(
              onPressed: () async{
                if (pinController1.text == pinController2.text && pinController1.text.length == 4) {


                  virtualDollarCardController.isLoading.value = true;
                  dynamic holder  = await virtualDollarCardController.createCard(pinController1.text);
                  virtualDollarCardController.isLoading.value = false;
                  holder ? Get.to(PinScreen()) : null;
                  Future.delayed(const Duration(seconds: 1500));
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SuccessView(
                          content: 'Your virtual card has been created successfully',
                          buttonText: 'View Card',
                          next: Home(),
                      ),
                    ),
                  );
                  //
                  Get.snackbar("Success", "PIN set successfully.",
                      snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.blue,colorText: Colors.white);
                } else {
                  Get.snackbar("Error", "PINs do not match.",
                      snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red,colorText: Colors.white);
                }
              },
              child: Text("Set PIN",style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
    );
  }
}
