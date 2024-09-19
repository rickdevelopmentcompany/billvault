import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:billvaoit/app/http/controllers/auth/auth_controller.dart';

import '../../../routes/routes.dart';

class BillPaymentsController extends GetxController {
  dynamic airtimeShortcutAmount = 100.obs;
  dynamic networkLogo = 'mtn'.obs;
  late List<Map<String, dynamic>> dataBundles = [];

  void setAirtimeShortcutAmount(dynamic val) {
    airtimeShortcutAmount.value = val;
  }

  Future<List<Map<String, dynamic>>> getDataBundles() async {
    this.dataBundles = [
      {'price': "100", "desc": "100MB FOR 1 day"},
      {'price': "200", "desc": "200MB FOR 2 days"},
      {'price': "500", "desc": "500MB FOR 7 days"},
    ];
    return this.dataBundles;
  }

  void setNetworkLogo(String val) {
    networkLogo.value = val;
  }

  Future<List<Map<String,dynamic>>> getataBundles() async{
    this.dataBundles = [{ 'price':"100", "desc":"100MB FOR 1 day" },
      { 'price':"200", "desc":"200MB FOR 2 days" },
      { 'price':"500", "desc":"500MB FOR 7 days" },];
    return this.dataBundles;
  }
  // Purchase Airtime
  Future<void> purchaseAirtime(String network, String phoneNumber, double amount) async {
    try {
      final response = await http.post(
        Uri.parse(WebRoutes.purchaseAirtime),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_token_here', // Replace with your token logic
        },
        body: jsonEncode({
          'network': network,
          'phoneNumber': phoneNumber,
          'amount': amount,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // Handle success
        print("Airtime purchased successfully: ${data['message']}");
      } else {
        // Handle failure
        var errorData = json.decode(response.body);
        print("Failed to purchase airtime: ${errorData['message']}");
      }
    } catch (e) {
      // Handle error
      print("Error purchasing airtime: $e");
    }
  }

  // Purchase Data Bundle
  Future<void> purchaseDataBundle(String network, String phoneNumber, String bundleCode) async {
    try {
      final response = await http.post(
        Uri.parse(WebRoutes.purchaseData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_token_here', // Replace with your token logic
        },
        body: jsonEncode({
          'network': network,
          'phoneNumber': phoneNumber,
          'bundleCode': bundleCode,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // Handle success
        print("Data bundle purchased successfully: ${data['message']}");
      } else {
        // Handle failure
        var errorData = json.decode(response.body);
        print("Failed to purchase data bundle: ${errorData['message']}");
      }
    } catch (e) {
      // Handle error
      print("Error purchasing data bundle: $e");
    }
  }

  // Query Transaction
  Future<void> queryTransaction(String orderId) async {
    try {
      final response = await http.post(
        Uri.parse(WebRoutes.queryTransaction),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_token_here', // Replace with your token logic
        },
        body: jsonEncode({
          'orderId': orderId,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // Handle success
        print("Transaction queried successfully: ${data['status']}");
      } else {
        var errorData = json.decode(response.body);
        // Handle failure
        print("Failed to query transaction: ${errorData['message']}");
      }
    } catch (e) {
      // Handle error
      print("Error querying transaction: $e");
    }
  }

  // Cancel Transaction
  Future<void> cancelTransaction(String orderId) async {
    try {
      final response = await http.post(
        Uri.parse(WebRoutes.cancelTransaction),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_token_here', // Replace with your token logic
        },
        body: jsonEncode({
          'orderId': orderId,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // Handle success
        print("Transaction canceled successfully: ${data['status']}");
      } else {
        var errorData = json.decode(response.body);
        // Handle failure
        print("Failed to cancel transaction: ${errorData['message']}");
      }
    } catch (e) {
      // Handle error
      print("Error canceling transaction: $e");
    }
  }

  // Verify Customer ID (IUC/Smartcard)
  Future<void> verifyCustomerID(String customerID, String serviceType) async {
    try {
      final response = await http.post(
        Uri.parse(WebRoutes.verifyCustomerID),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_token_here', // Replace with your token logic
        },
        body: jsonEncode({
          'customerID': customerID,
          'serviceType': serviceType,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // Handle success
        print("Customer verified: ${data['customer_name']}");
      } else {
        var errorData = json.decode(response.body);
        // Handle failure
        print("Failed to verify customer: ${errorData['message']}");
      }
    } catch (e) {
      // Handle error
      print("Error verifying customer: $e");
    }
  }
}
