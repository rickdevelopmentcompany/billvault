import 'dart:convert';
import 'package:billvaoit/app/Models/user/User.dart';
import 'package:billvaoit/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../resources/views/home.dart';
import '../../../resources/views/virtual_dollar_card/card_pin.dart';
import '../../../resources/views/virtual_dollar_card/virtual_dollar_card.dart';
import '../services/api_services.dart';
import 'package:http_parser/http_parser.dart';


class VirtualDollarCardController extends GetxController {

  ApiServices apiServices = ApiServices();
  final dynamic isLoading = true.obs;
  final dynamic hasCard = false.obs;
  final dynamic card_details = {}.obs;
  final dynamic isCardDetailsEmpty = true.obs;


  @override
  void onInit() {
    super.onInit();
    // This runs after the widget is initialized, ensuring the UI is ready
    // Get.snackbar("Controller Initialized", 'VirtualDollarCardController is ready');
  }



  Future<String?> fetchCsrfToken() async {
    try {
      // Replace with your server's URL to get the CSRF token
      final response = await http.get(Uri.parse('${ApiRoutes.baseUrl}/generate-token'));

      if (response.statusCode == 200) {
        // Extract the CSRF token from the response
        // Assuming the server returns JSON with a field named 'csrf_token'
        final data = jsonDecode(response.body);
        GetStorage().write('card_token',data['token']);
        return data['token']; // Adjust according to your response structure
      } else {
        print('Failed to fetch CSRF token. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching CSRF token: $e');
    }
    return null;
  }


  // Fetch wallet response
  Future<String> fetchResponse(url,headers) async {
    try {
      // Example request to fetch the wallet data
      String response = await apiServices.makeGetRequest(url, headers);
      // update();
      return response;
    } catch (error) {
      return '$error';
      print('$error');
      // Get.snackbar("","Error fetching wallet data: $error");
    } finally {
      // Get.snackbar("","Finally");
      isLoading(false); // Stop loading
    }
    update();
    return "";
  }

  Future<void> hasCardMethod() async{
    fetchCsrfToken();
    String user_id = User().user_id;
    // print('User().user_id: $user_id');

    String query = "?id=$user_id";
    Map<String, String> headers = {

    };
    dynamic response = await fetchResponse(ApiRoutes.hasCard+ query,headers);
    // var storedMethods = storage.read('withdrawal_methods');

    dynamic details =  jsonDecode(response);
    print(details['data'][0]['card_id']);
    dynamic card_id = details['data'][0]['card_id'];
    GetStorage().write("card_id",card_id);
    this.hasCard.value =  details['success'];
  }

  Future<bool> registerCardholder() async {
    User user = User();
    GetStorage storage = GetStorage();
    String csrfToken = storage.read('card_token');
    // String cardCsrfToken = storage.read('card_csrf_token');
    String userId = user.user_id;
    String url = ApiRoutes.registerCardholder;

    // Retrieve stored data
    String address = storage.read('address') ?? '';
    String city = storage.read('city') ?? '';
    String state = storage.read('state') ?? '';
    String country = storage.read('country') ?? '';
    String postalCode = storage.read('postal_code') ?? '';
    String houseNo = storage.read('house_no') ?? '';
    String bvn = storage.read('bvn') ?? '';
    String selfieImagePath = storage.read('selfieImagePath') ?? '';
// print(selfieImagePath);
    String fullName = user.fullName; // Assuming user.fullName is the full name
    List<String> nameParts = fullName.split(' ');

// Extract first and last name
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    // Create request data
    Map<String, String> data = {
      "id": userId,
      "first_name": firstName,
      "last_name": lastName,
      "address[address]": address,
      "address[city]": city,
      "address[state]": state,
      "address[country]": country,
      "address[postal_code]": postalCode,
      "address[house_no]": houseNo,
      "phone": user.mobile,
      "email_address": user.email,
      "identity[id_type]": "NIGERIAN_BVN_VERIFICATION",
      "identity[bvn]": bvn,
    };

    try {
      // Determine content type based on the file extension
      MediaType? contentType;
      if (selfieImagePath.isNotEmpty) {
        String extension = selfieImagePath.split('.').last.toLowerCase();
        if (extension == 'jpg' || extension == 'jpeg') {
          contentType = MediaType('image', 'jpeg');
        } else if (extension == 'png') {
          contentType = MediaType('image', 'png');
        }
      }

        // Prepare multipart request
        var request = http.MultipartRequest('POST', Uri.parse(url))
          ..fields.addAll(data)
          ..headers.addAll({
            "Authorization": "Bearer $csrfToken",
            "Accept": "application/json",
          });

        // Add selfie image file if available
        if (contentType != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'identity[selfie_image]',
            selfieImagePath,
            contentType: contentType,
          ));
        }

        // Send the request
        var response = await request.send();

        // Handle the response
        if (response.statusCode == 200) {
          // Your existi
          String responseBody = await response.stream.bytesToString();
        dynamic details = jsonDecode(responseBody);
        if (details['status'] == 'success') {
          Get.snackbar(
            'Success',
            'User verified successfully.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          //
          storage.write('cardholder_id', details['data']['cardholder_id'].toString());
          // {cardholder_id: 99534693c67a47d5b4fed04be4fe784c}
          // Get.to(PinScreen());
          return true;
          print('Cardholder created successfully. Details: ${details['data']}');
        } else {
          Get.snackbar(
            'Error',
            details['message'] ?? 'An unknown error occurred.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          print('Error: ${details}');
        }
      } else {
        String responseBody = await response.stream.bytesToString();
        dynamic de = json.decode(responseBody);
        Get.snackbar(
          'Error',
          '${de['message'].toString()} ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.snackbar(
          'Error',
          'Failed to Verify User. Try again ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Failed to register cardholder. Status Code: ${response.statusCode}. Response: $responseBody');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error occurred: $e');
    }
    return false;
  }



  Future<bool> createCard(dynamic pin) async {
    // Define the server URL
    const String url = ApiRoutes.createCard; // Replace with your server's URL
    dynamic cardholder_id = GetStorage().read('cardholder_id');
    print(cardholder_id);
    // Create the payload
    final Map<String, dynamic> payload = {
      'cardholder_id': cardholder_id,
      'pin': pin
    };

    try {
      // Send a POST request to the server
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(payload),
      );

      // Check for success status code (usually 200 or 201)
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response body if needed
        final responseBody = jsonDecode(response.body);
        dynamic card_id = responseBody['data']['card_id'];
        GetStorage().write("card_id",card_id);
        dynamic newUrl = ApiRoutes.baseUrl+"/store-card";


    final Map<String, dynamic> payload = {
    'user_id': User().user_id,
    'card_id':card_id,
    'currency': 'USD'
    };
        final http.Response res = await http.post(
          Uri.parse(newUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(payload),
        );

        print(res.body);

        Get.snackbar(
          'Success',
          'Virtual Card created successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print('Card created successfully: ${responseBody}');
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Failed to create card.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Failed to create card. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error occurred while creating card: $e');
    }
    return false;
  }

 Future<void> fundCard(String amount) async{
// Define the server URL
   const String url = ApiRoutes.fundCard; // Replace with your server's URL
   dynamic card_id = GetStorage().read('card_id');
   print('card_id: $card_id');
   print("amounr: $amount");


   // Create the payload
   final Map<String, dynamic> payload = {
   'user_id' : User().user_id,
   'card_id' : card_id,
   'amount' : amount,
   'currency' : 'USD'
   };

   try {
     // Send a POST request to the server
     final http.Response response = await http.post(
       Uri.parse(url),
       headers: {
         'Content-Type': 'application/json',
         'Accept': 'application/json',
       },
       body: jsonEncode(payload),
     );

     // Check for success status code (usually 200 or 201)
     if (response.statusCode == 200 || response.statusCode == 201) {


       print(response.body);

       Get.snackbar(
         'Success',
         'Virtual Card Funded successfully.',
         snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.green,
         colorText: Colors.white,
       );
       print('Card funded successfully: ${response.body}');
       // return true;
       Get.to( const Home());
     } else {
       Get.snackbar(
         'Error',
         'Failed to fund card.',
         snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.red,
         colorText: Colors.white,
       );
       print(response.body);
       print('Failed to fund card. Status code: ${response.statusCode}');
       print('Error response: ${response.body}');
     }
   } catch (e) {
     Get.snackbar(
       'Error',
       'An error occurred: $e',
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor: Colors.red,
       colorText: Colors.white,
     );
     print('Error occurred while funding card: $e');
   }
 }
  // /card-details/{cardId}


  Future<void> withdrawFromCard(String amount) async{
// Define the server URL
    const String url = ApiRoutes.unloadCard; // Replace with your server's URL
    dynamic card_id = GetStorage().read('card_id');
    print('card_id: $card_id');
    print("amounr: $amount");


    // Create the payload
    final Map<String, dynamic> payload = {
      'user_id' : User().user_id,
      'card_id' : card_id,
      'amount' : amount,
      'currency' : 'USD'
    };

    try {
      // Send a POST request to the server
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(payload),
      );

      // Check for success status code (usually 200 or 201)
      if (response.statusCode == 200 || response.statusCode == 201) {


        print(response.body);

        Get.snackbar(
          'Success',
          'Withdrawal successful.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        print(' Withdraw successful: ${response.body}');
        // return true;
        Get.to( const Home());
      } else {
        print(response.body);
        Get.snackbar(
          'Error',
          'Failed to withdraw.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print(response.body);
        print('Failed to withdraw. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error occurred while withdrawing card: $e');
    }
  }

  Future<void> cardDetails() async {
    card_details.value = {};
    isCardDetailsEmpty.value = true;
    String card_id = GetStorage().read("card_id");
    // Define the server URL
    String url = ApiRoutes.cardDetails; // Replace with your server's URL
    try {
      // Send a POST request to the server
      final http.Response response = await http.get(
        Uri.parse('$url/$card_id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      // Check for success status code (usually 200 or 201)
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response body if needed
        final responseBody = jsonDecode(response.body);
        card_details.value = responseBody;
        print('Card details: ${response.body}');
        isCardDetailsEmpty.value = false;
      }else{

        print('Card error: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while creating card: $e');
    }
    // return false;
  }

  // Map to hold card details
  Map<String, dynamic> get getCardDetails {
    return {
      "firstname": "Nchukwu",
    };
  }

  String get balance {
    double d = double.parse(card_details['data']['available_balance']);

    // Divide by 100 and format to 2 decimal places
    String available_balance = (d / 100).toStringAsFixed(2);

    return available_balance;
  }


  String get cvv{
    String cvv = card_details['data']['cvv'];
    return cvv;
  }


  String get fullName{
    String card_name = card_details['data']['card_name'];
    return card_name;
  }
  String get expiringDate{
    String expiry_month = card_details['data']['expiry_month'];
    String expiry_year = card_details['data']['expiry_year'].toString().replaceAll('20', '');
    return "$expiry_month/$expiry_year";
  }

  String get cardNumber {
    String cardNumber = card_details['data']['card_number'];

    // Use a regular expression to split the card number into groups
    return cardNumber.replaceAllMapped(RegExp(r".{1,4}"), (match) => "${match.group(0)}   ");
  }

}
