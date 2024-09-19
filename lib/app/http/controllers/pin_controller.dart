import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinController extends GetxController {
  var pin = ''.obs; // Observable to store the current PIN
  late TextEditingController pinController; // Controller for PIN input field

  @override
  void onInit() {
    super.onInit();
    pinController = TextEditingController(); // Initialize the TextEditingController
  }

  // Function to set the PIN once input is completed
  void setPin(String enteredPin) {
    pin.value = enteredPin;
    print('Entered PIN: $enteredPin');
    // You can add additional validation or API calls here if necessary
  }

  @override
  void onClose() {
    pinController.dispose(); // Dispose of the controller when done
    super.onClose();
  }
}
