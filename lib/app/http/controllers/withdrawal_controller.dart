



import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/routes.dart';
import '../../Models/user/User.dart';
import '../services/api_services.dart';

class WithdrawalController extends GetxController{

  RxBool isLoading = true.obs; // Observable for loading state
  var walletBalance = 0.0.obs; // Observable for wallet balance
  final GetStorage storage = GetStorage(); // Local storage instance
  ApiServices apiServices = ApiServices();
  Map<String, String> headers = <String, String>{};
  User user = User();
  WithdrawalController();


  @override
  void onInit(){
    super.onInit();
    // print(user);
    String accessToken = user.accessToken;
    String tokenType = user.tokenType;

    // Set headers for authorization
    headers = {
      'Authorization': '$tokenType $accessToken',
      'Accept': 'application/json',
    };

    update();
  }


  // Fetch wallet response
  Future<String> fetchResponse(req,url) async {
    try {
      // Example request to fetch the wallet data
      String response = await apiServices.makeGetRequest(url, headers);
      storage.write(req,response);
      update();
      return response;
    } catch (error) {
      Get.snackbar("","Error fetching wallet data: $error");
    } finally {
      // Get.snackbar("","Finally");
      isLoading(false); // Stop loading
    }
    update();
    return "";
  }

  Map<String,dynamic>   withdrawMethods(){
    fetchResponse("withdrawal_methods",WebRoutes.withdrawMethods);
    var storedMethods = storage.read('withdrawal_methods');
    return jsonDecode(storedMethods);
  }

  //
  Future<Map<String, dynamic>>   getAddWithdrawMethods() async {
    await fetchResponse("add_withdrawal_methods",WebRoutes.addWithdrawMethod);
    var storedMethods = storage.read('add_withdrawal_methods');
    return jsonDecode(storedMethods);
  }


}