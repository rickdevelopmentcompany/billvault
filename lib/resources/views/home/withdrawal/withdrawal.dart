import 'package:billvaoit/resources/views/home/withdrawal/withdrawal_by_card_view.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:billvaoit/resources/utils/app_colors.dart';
import 'package:billvaoit/resources/widgets/custom_textfield.dart';
import 'package:billvaoit/resources/utils/button.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:get/get.dart';
import '../../../../app/http/controllers/withdrawal_controller.dart';
import '../../success_view.dart';
import 'add_method.dart';

class Withdrawal extends StatefulWidget {
  const Withdrawal({super.key});

  @override
  State<Withdrawal> createState() => WithdrawalState();
}

class  WithdrawalState extends State<Withdrawal>{
  WithdrawalController withdrawalController = Get.put(WithdrawalController());
  RefreshController refreshController = RefreshController(initialRefresh: false);
  Map<String,dynamic> methods = {};


  @override
  initState(){
    super.initState();
    load();
  }

  Future<void> load() async {
    withdrawalController.isLoading.value = true;
    methods =  withdrawalController.withdrawMethods();
    await Future.delayed(const Duration(seconds: 5));
    withdrawalController.isLoading.value = false;
  }


  void _onLoading() async{
    refreshController.loadComplete();
  }
  void _onRefresh() async{
    withdrawalController.isLoading.value = true;
    await Future.delayed(const Duration(seconds: 5));
    withdrawalController.isLoading.value = false;
    refreshController.refreshCompleted();
  }
  @override
  Widget build(BuildContext context) {
    dynamic methodsData = methods['data']['methods']['data'];

// Check if the list is null or empty
    bool isMethodsEmpty = methodsData == null || methodsData.isEmpty;

    print(isMethodsEmpty);
    // dynamic screenWidth
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:  InkWell(
          splashColor: Colors.transparent,
          onTap: Navigator.of(context).pop,
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Withdraw Money',
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body:
    Obx((){
      return withdrawalController.isLoading.value ? const  UsableLoading() : SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const MaterialClassicHeader(),
        controller: refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:  ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                  children: [
                    Gap(MediaQuery.of(context).padding.top + 24),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Withdrawal Method',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue.withOpacity(0.5)), // Border color
                                  borderRadius: BorderRadius.circular(8), // Rounded corners
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Get.to( const AddMethod());
                                    // Add your onPressed code here
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add, // Plus icon
                                        color: Colors.blue, // Icon color
                                      ),
                                      SizedBox(width: 8), // Space between icon and text
                                      Text(
                                        'Add Method',
                                        style: TextStyle(
                                          color: Colors.blue, // Text color
                                          fontSize: 16, // Text size
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                          const Divider(),

                          const Gap(15),

                          isMethodsEmpty ?
                          Container(
                            width: 300.w, // Width of the container
                            height: 150.h, // Height of the container
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white, // Card color
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Icon Container
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue, // Background color of the icon
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.account_balance, // Bank icon
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 15), // Space between icon and text
                                const Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'No Withdraw Methods',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ) :
                          Column(
                            children: [

                              Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/amex.png'),
                                      Text('BANK TRANSFER'),
                                    ],

                                  )
                              ),
                              const Gap(8),
                              Image.asset(
                                'assets/images/visa.png',
                                color: const Color(0xFF1434CB),
                              ),
                              const Gap(8),
                              Image.asset('assets/images/amex.png'),
                              const Gap(8),
                              Image.asset('assets/images/discover.png'),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                )),
                // const Spacer(),

              ],
            ),

      );


    }),
    );
  }
}
