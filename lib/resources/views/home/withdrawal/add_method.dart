import 'package:billvaoit/app/http/controllers/withdrawal_controller.dart';
import 'package:billvaoit/resources/views/home/withdrawal/withdrawal_by_card_view.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:billvaoit/resources/utils/app_colors.dart';
import 'package:billvaoit/resources/widgets/custom_textfield.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../utils/button.dart';
import '../buy_giftcard/pin_bottomsheet.dart';
import '../../success_view.dart';

class AddMethod extends StatefulWidget {
  const AddMethod({super.key});

  @override
  State<AddMethod> createState() => AddMethodState();
}

class AddMethodState extends State<AddMethod> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  WithdrawalController withdrawalController =  Get.put(WithdrawalController());
  String selectedWithdrawalMethod = 'NGN - Withdrawal';
  String selectedCurrency = 'NGN';
  // WithdrawalController withdrawalController = Get.put(WithdrawalController());
  Map<String,dynamic> methods = {};


  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load() async {
    withdrawalController.isLoading.value = true;
    withdrawalController.getAddWithdrawMethods();
    await Future.delayed(const Duration(seconds: 15));
    withdrawalController.isLoading.value = false;
  }

  void _onLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    refreshController.loadComplete();
  }

  void _onRefresh() async {
    load();
    // await Future.delayed(const Duration(seconds: 15));
    refreshController.refreshCompleted();
  }

  void _showSelectNetworkSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('NGN - Withdrawal'),
                onTap: () {
                  setState(() {
                    selectedWithdrawalMethod = 'NGN - Withdrawal';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('USD - Withdrawal'),
                onTap: () {
                  setState(() {
                    selectedWithdrawalMethod = 'USD - Withdrawal';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('EURO - Withdrawal'),
                onTap: () {
                  setState(() {
                    selectedWithdrawalMethod = 'EURO - Withdrawal';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSelectCurrencySheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('NGN'),
                onTap: () {
                  setState(() {
                    selectedCurrency = 'NGN';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('USD'),
                onTap: () {
                  setState(() {
                    selectedCurrency = 'USD';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('EURO'),
                onTap: () {
                  setState(() {
                    selectedCurrency = 'EURO';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          onTap: Navigator.of(context).pop,
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Add Withdrawal Method',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const MaterialClassicHeader(),
        controller: refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Obx((){
              return withdrawalController.isLoading.value ? const UsableLoading() : ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Gap(MediaQuery.of(context).padding.top * 0.34),
                  Container(
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        InkWell(
                          onTap: _showSelectNetworkSheet,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Image.asset('assets/images/mtn.png'),
                                // const SizedBox(width: 8),
                                Text(selectedWithdrawalMethod),
                                const SizedBox(width: 8),
                                SvgPicture.asset('assets/svgs/dropdown.svg'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text('Select Currency'),
                        InkWell(
                          onTap: _showSelectCurrencySheet,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: Row(
                              children: [
                                Text(selectedCurrency),
                                const Spacer(),
                                SvgPicture.asset('assets/svgs/dropdown.svg'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(1.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18),
                        Text(
                          'Please provide your bank details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        CustomTextfield(
                          hintText: 'Enter a nickname',
                        ),
                        SizedBox(height: 16),
                        CustomTextfield(
                          keyboardType: TextInputType.number,
                          hintText: 'Enter your account number',
                        ),
                        SizedBox(height: 16),
                        CustomTextfield(
                          hintText: 'Enter your bank name',
                        ),
                        SizedBox(height: 16),
                        CustomTextfield(
                          hintText: 'Enter your account name',
                        ),
                      ],
                    ),
                  ),

      const Spacer(),
      primaryButton(
        context,
        title: 'Confirm',
        color: AppColors.primaryColor,
        onTap: () async {
            await showModalBottomSheet(
              context: context,
              builder: (context) {
                return const PinBottomsheetView();
              },
            );
        },
      ),
                ],
              ),
            ),
          ],
        );
  }),
      ),
    );
  }
}
