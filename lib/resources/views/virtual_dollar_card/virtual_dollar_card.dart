import 'package:billvaoit/app/Models/user/User.dart';
import 'package:billvaoit/app/http/controllers/virtual_card_controller.dart';
import 'package:billvaoit/resources/views/profile/profile_setting.dart';
import 'package:billvaoit/resources/views/virtual_dollar_card/topup_virtual_card.dart';
import 'package:billvaoit/resources/views/virtual_dollar_card/widgets/virtual_card_widget.dart';
import 'package:billvaoit/resources/views/virtual_dollar_card/withdrawal_virtual_card.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../utils/button.dart';
import '../../widgets/transaction_card.dart';
import 'kyc_verification.dart';
import 'package:get/get.dart';

class VirtualDollarCard extends StatefulWidget {
  const VirtualDollarCard({super.key});
@override
  State<VirtualDollarCard> createState() => _VirtualDollarCard();
}
class _VirtualDollarCard extends State<VirtualDollarCard>{

  bool viewDetails = true;
  late VirtualDollarCardController virtualDollarCardController ;
  RefreshController refreshController = RefreshController(initialRefresh: false);
  late bool hasCard = true;
  String card_number = '';

  bool isTransaction = false;
  late var depositHistory = [];

  @override
  void initState() {
    super.initState();
    virtualDollarCardController = Get.put(VirtualDollarCardController());
    initialise();
  }


  void _onLoading() async {
  }

  void _onRefresh() async {
    virtualDollarCardController = Get.put(VirtualDollarCardController());
    initialise();
    await Future.delayed(const Duration(seconds: 5));
    refreshController.refreshCompleted();
  }

  Future<void> initialise() async {
    // Initialize the controller here
    virtualDollarCardController.isLoading.value = true;
    virtualDollarCardController = Get.put(VirtualDollarCardController());
    await virtualDollarCardController.hasCardMethod();
    // await virtualDollarCardController.cardDetails();
    // await Future.delayed(const Duration(seconds: 5));
    virtualDollarCardController.isLoading.value = false;
  }
  @override
  Widget build(BuildContext context) {
    GetStorage storage = GetStorage();
    bool isVerified = User().isKYCVerified;
    // isVerified = false;
    depositHistory = storage.read('deposit_history')[0]['history'];
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
     body: SmartRefresher(
         enablePullDown: true,
         enablePullUp: true,
         header: const MaterialClassicHeader(),
         controller: refreshController,
         onRefresh: _onRefresh,
         onLoading: _onLoading,
         child:
     Obx((){
       hasCard = virtualDollarCardController.hasCard.value;
       if(hasCard){
         virtualDollarCardController.cardDetails();
       }
       print(hasCard);
       return   virtualDollarCardController.isLoading.value ? const UsableLoading() :
       hasCard ? ViewDetails() :
       ListView(
         children: [
       SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               const Gap(28),
               virtualCard(context: context, virtualDollarCardController: Get.put(VirtualDollarCardController())),
               const Gap(18),
               Text(
                 ' Virtual card',
                 style: Theme.of(context).textTheme.labelLarge?.copyWith(
                   fontWeight: FontWeight.w700,
                   fontSize: 20,
                 ),
               ),
               const Gap(11),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SvgPicture.asset('assets/svgs/budget.svg'),
                       const Gap(25),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             'Budget Effectively',
                             style:
                             Theme.of(context).textTheme.labelLarge?.copyWith(
                               fontWeight: FontWeight.w600,
                               fontSize: 16,
                             ),
                           ),
                           const Gap(8),
                           Text(
                             'Limit spending by only using the\namount uploaded to your card',
                             style:
                             Theme.of(context).textTheme.labelLarge?.copyWith(
                               fontWeight: FontWeight.w400,
                               fontSize: 15,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                   const Gap(40),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SvgPicture.asset('assets/svgs/phone.svg'),
                       const Gap(25),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             'Digital Native',
                             style:
                             Theme.of(context).textTheme.labelLarge?.copyWith(
                               fontWeight: FontWeight.w600,
                               fontSize: 16,
                             ),
                           ),
                           const Gap(8),
                           Text(
                             'A digital card for your digital life',
                             style:
                             Theme.of(context).textTheme.labelLarge?.copyWith(
                               fontWeight: FontWeight.w400,
                               fontSize: 15,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                   const Gap(40),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SvgPicture.asset('assets/svgs/dollar.svg'),
                       const Gap(25),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             'Card Creating Fee',
                             style:
                             Theme.of(context).textTheme.labelLarge?.copyWith(
                               fontWeight: FontWeight.w600,
                               fontSize: 16,
                             ),
                           ),
                           const Gap(8),
                           Text(
                             'USD 2.00 fee to create a USD card. ',
                             style:
                             Theme.of(context).textTheme.labelLarge?.copyWith(
                               fontWeight: FontWeight.w400,
                               fontSize: 15,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ],
               ),
               const Gap(34),
               primaryButton(context, title: 'Proceed', onTap: () {
                 Get.delete<VirtualDollarCardController>();
                 if(User().isKYCVerified){
                   Get.to(const KycVerification());
                 }else{
                   Get.to(const KycVerification());
                 }
               }),
               const Gap(24),
             ],
           ),
         ),
       )]);
     })
    ),

    );
  }

  Widget ViewDetails() {
    return
      Obx((){
        return virtualDollarCardController.isCardDetailsEmpty.value
        ? const UsableLoading() : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              virtualCard(context: context,
                  viewDetails: viewDetails,
                  virtualDollarCardController: virtualDollarCardController),
              const Gap(18),
              Text(
                'Card balance',
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Text(
                viewDetails ? "USD " +
                    virtualDollarCardController.balance.toString() : '****',
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const Gap(21),
              actionIcons(),
              const Gap(21),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Transactions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(21),
                  isTransaction ? SingleChildScrollView(
                      child: Column(
                        children: List.generate(depositHistory.length, (index) {
                          var trx = depositHistory[index];
                          String time = DateFormat('hh:mm a').format(
                              DateTime.parse('${trx['created_at']}'));
                          String formatted = DateFormat('dd MMM yyyy').format(
                              DateTime.parse('${trx['created_at']}'));
                          var val = trx['detail'][0];
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Gap(10),
                                TransactionCard(
                                    title: '${trx['method_currency']} Deposit',
                                    date: '$formatted',
                                    bankInfo: '$val',
                                    iconPath: 'assets/images/baby.png',
                                    status: '${trx['status']}',
                                    time: '$time',
                                    transactionId: '${trx['trx']}',
                                    amount: '2000'),
                                const Gap(10),
                              ]
                          );
                        }
                        ).toList(),
                      )
                  ) : Center(
                    child: Text(
                        'No Transactions'),
                  )
                ],
              )

            ],
          ),
        ));
  });
  }
  Widget actionIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            Get.to( TopupVirtualcard()); // Navigate using GetX
          },
          child: const Column(
            children: [
              Icon(Icons.add), // Display the icon
              Text("Top up"), // Display the text
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              viewDetails = !viewDetails;
            });
          },
          child: Column(
            children: [
              Icon(
                viewDetails ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              ) ,// Display the icon
              SizedBox(
                width: 60,
                child: Text(
                  viewDetails ? 'Hide details' : 'View details', // Display the text
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.to( WithdrawalVirtualcard()); // Navigate using GetX
          },
          child: Column(
            children: [
              Transform.rotate(
                angle: -45, // Rotate 45 degrees in radians
                child: const Icon(Icons.arrow_downward_rounded),
              ),
              const  Text("Withdraw"), // Display the text
            ],
          ),
        ),

        // InkWell(
        //   onTap: () {
        //     Get.to(const ProfileSettingView()); // Navigate using GetX
        //   },
        //   child: const Column(
        //     children: [
        //       Icon(Icons.receipt_outlined), // Display the icon
        //       Text("Statement"), // Display the text
        //     ],
        //   ),
        // ),
        // InkWell(
        //   onTap: () {
        //     Get.to(const ProfileSettingView()); // Navigate using GetX
        //   },
        //   child: const Column(
        //     children: [
        //       Icon(Icons.more_horiz), // Display the icon
        //       Text("More"), // Display the text
        //     ],
        //   ),
        // ),
      ],
    );
  }

}
