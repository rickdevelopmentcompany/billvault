

import 'dart:async';
import 'dart:convert';

import 'package:billvaoit/app/http/controllers/deposit_controller.dart';
import 'package:billvaoit/resources/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../app/Models/user/User.dart';
import '../../../../routes/routes.dart';
import '../../../widgets/usable_loading.dart';

class AddMoney extends StatelessWidget {
  const AddMoney({super.key});


  Widget build(BuildContext context) {
    final DepositController depositController  = Get.put(DepositController(user: User()));
    GetStorage storage = GetStorage();
    Map<String, dynamic> payment_methods = {};
    print(depositController.depostMethods());
    // Safely read from storage
    var storedMethods = storage.read('deposit_methods');
    // Check if it's a Map and handle the payment_methods
    if(storedMethods == null) {
      final DepositController depositController  = DepositController(user: User());
      depositController.fetchResponse("deposit_methods",WebRoutes.depositMethods);
    }else if (storedMethods is Map<String, dynamic>) {
        payment_methods = storedMethods;
        print("Payment methods map: $payment_methods");
      } else {
        payment_methods = jsonDecode(storedMethods);
        print("Invalid type: Expected Map<String, dynamic> but got $payment_methods");
      }

      return  GetBuilder<DepositController>(
      init: DepositController(user: User()),  // Initialize the controller
      builder: (controller) => Scaffold(
        body:  const Center(        // Use a proper lambda function for builder
          child: Text('wallets'),
        ),
      )
    );
    }

  }
