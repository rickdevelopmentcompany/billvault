import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:billvaoit/app/http/controllers/bill_payments.dart';
import 'package:billvaoit/resources/utils/app_theme.dart';
import 'package:billvaoit/resources/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:billvaoit/resources/views/onboarding/onboarding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/http/controllers/auth/signup_controller.dart';
import 'app/http/controllers/giftcards/giftcard_controller.dart';
import 'app/http/controllers/live_chat_controller.dart';
import 'app/http/controllers/pin_controller.dart';
import 'app/http/controllers/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(SignupController);
  // Get.put(UserController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LiveChatController());
    // Get.put(UserController());
    Get.put(PinController());
    Get.put(BillPaymentsController());
    final GiftCardController giftCardController = Get.put(GiftCardController());
    giftCardController.getProducts();
    giftCardController.getCategories();
    final box = GetStorage();
    bool isLoggedIn = box.read('isLoggedIn') ?? false; // Check if logged in
    // print(box.read('deposit_methods'));
    return ScreenUtilInit( // Initialize ScreenUtil
      designSize: const Size(360, 690), // Set your design size
      minTextAdapt: true, // To adapt to smaller screens
      splitScreenMode: true, // For split-screen support
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: CustomAppTheme.lightTheme,
          darkTheme: CustomAppTheme.darkTheme,
          builder: EasyLoading.init(),
          home: AnimatedSplashScreen(
            splash: 'assets/images/logo.png',
            nextScreen: isLoggedIn ? const Home() : const FirstPage(),
            splashTransition: SplashTransition.rotationTransition,
          ),
        );
      },
    );
  }
}
