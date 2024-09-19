import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/routes.dart';
import '../../Models/user/User.dart';
import '../services/api_services.dart';

class UserController extends GetxController {
  // Observables
  var isLoading = false.obs; // For indicating loading state
  var userInfoData = {}.obs; // To store user info data
  var dashboardData = {}.obs; // To store dashboard data
  final GetStorage storage = GetStorage(); // Local storage instance

  ApiServices apiServices = ApiServices(); // API service instance
  Map<String, String> headers = <String, String>{}; // Headers for API requests
  UserController(){
    print('called object');
    // Fetch user info from local storage or API
    fetchUserAndSetHeaders();
    // Optionally, you can fetch user info or dashboard data upon initialization
    fetchUserInfo();
    fetchDashboardData();
    onInit();
  }

  @override
  void onInit() {
    super.onInit();

    // Fetch user info from local storage or API
    fetchUserAndSetHeaders();
    // Optionally, you can fetch user info or dashboard data upon initialization
    fetchUserInfo();
    fetchDashboardData();
  }

  // Fetch user and set headers for API requests
  void fetchUserAndSetHeaders() {
    User user = User(); // Replace with actual user fetching logic
    String accessToken = user.accessToken ?? '';  // Handle null
    String tokenType = user.tokenType ?? '';

    // Set authorization headers
    headers = {
      'Authorization': '$tokenType $accessToken',
      'Accept': 'application/json',
    };
  }

  // Fetch user info
  void fetchUserInfo() async {
    isLoading(true); // Start loading
    try {
      // API call to get user info
      String response = await apiServices.makeGetRequest(WebRoutes.userInfo, headers);

      // Optionally store user info in local storage
      storage.write('userInfo', response);

      // Update the observable with parsed data
      userInfoData.value = parseUserInfo(response);

      // Show success message
      // Get.snackbar('Success', 'User information fetched successfully');
    } catch (error) {
      // Handle errors
      print("Error fetching user info: $error");
      Get.snackbar('Error', 'Failed to fetch user info: $error');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Parse user info (example parsing logic)
  Map<String, dynamic> parseUserInfo(String response) {
    // Parse JSON and return a Map of user info
    var data = jsonDecode(response);
    return data ?? {};
  }

  // Fetch dashboard data
  void fetchDashboardData() async {
    isLoading(true); // Start loading
    try {
      // API call to get dashboard data
      String response = await apiServices.makeGetRequest(WebRoutes.dashboard, headers);

      // Store dashboard data in local storage
      storage.write('dashboard', response);
      // var data = storage.read('dashboard');


      // Update the observable with parsed data
      dashboardData.value = parseDashboardData(response);

      // Show success message
      // Get.snackbar('Success', 'Dashboard data fetched successfully');
    } catch (error) {
      // Handle errors
      print("Error fetching dashboard data: $error");
      Get.snackbar('Error', 'Failed to fetch dashboard data: $error');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Parse dashboard data (example parsing logic)
  Map<String, dynamic> parseDashboardData(String response) {
    var data = jsonDecode(response);
    return data ?? {};
  }

  // Submit user data
  Future<void> submitUserData(Map<String, dynamic> userData) async {
    isLoading(true); // Start loading
    try {
      // API call to submit user data
      String response = await apiServices.makePostRequest(WebRoutes.userDataSubmit, userData, headers);

      // Optionally store response in local storage
      storage.write('submittedUserData', response);

      // Show success message
      Get.snackbar('Success', 'User data submitted successfully');
    } catch (error) {
      // Handle errors
      print("Error submitting user data: $error");
      Get.snackbar('Error', 'Failed to submit user data: $error');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Get device token
  Future<void> fetchDeviceToken() async {
    isLoading(true); // Start loading
    try {
      // API call to get device token
      String response = await apiServices.makePostRequest(WebRoutes.getDeviceToken, {}, headers);

      // Optionally store device token in local storage
      storage.write('deviceToken', response);

      // Show success message
      Get.snackbar('Success', 'Device token fetched successfully');
    } catch (error) {
      // Handle errors
      print("Error fetching device token: $error");
      Get.snackbar('Error', 'Failed to fetch device token: $error');
    } finally {
      isLoading(false); // Stop loading
    }
  }
}
