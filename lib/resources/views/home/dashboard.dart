import 'dart:convert';
import 'dart:io';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:billvaoit/app/http/controllers/user_controller.dart';
import 'package:billvaoit/resources/views/home/add_money/add_money.dart';
import 'package:billvaoit/resources/views/home/crypto/crypto_exchange_screen.dart';
import 'package:billvaoit/resources/views/home/crypto/crypto_view.dart';
import 'package:billvaoit/resources/views/home/sell_giftcard/sell_giftcard.dart';
import 'package:billvaoit/resources/views/home/transfer/transfer_view.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:billvaoit/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/Models/user/User.dart';
import '../../utils/app_colors.dart';
import '../../widgets/transaction_card.dart';
import '../../widgets/usable_dashboard_slider.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/dashboard_topbar.dart';
import '../../widgets/useable_dashboard_card.dart';
import 'bills_payment/bills_payment.dart';
import 'buy_giftcard/buy_giftcard.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardView> {
  late UserController userController;
  late GetStorage storage = GetStorage();
  late var depositHistory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async{
    Get.delete<UserController>();
    userController = Get.put(UserController());
      userController.isLoading.value = true;
    var history = await userController.getDepositHistory();
    print('deposit histories: ${userController.depositHistory}');
    await Future.delayed(const Duration(seconds: 5));
    userController.isLoading.value = false;
    await Future.delayed(const Duration(seconds: 3));
  }


  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    userController.isLoading.value = true;
    init();
    await Future.delayed(const Duration(milliseconds: 1000));
    userController.isLoading.value = false;
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // depositHistory = storage.read('deposit_history')[0]['history']! ?? '';
    depositHistory = userController.depositHistory;
    // userController.getWithdrawalHistory();
    var data = json.decode(storage.read('dashboard'));
    final _controller = SidebarXController(selectedIndex: 0, extended: true);
    final _key = GlobalKey<ScaffoldState>();
    User user = new User();
    // return  Obx(() {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: DasboardTopBar(),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Text(
                  'Dashboard Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  // Handle navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: () {
                  // Handle navigation
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Handle navigation
                },
              ),
            ],
          ),
        ),
        body:  Obx((){
          return userController.isLoading.value ? const UsableLoading() :
          SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child:  ListView(
                
                    children: [

                      // const Gap(24),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BalanceCard(balance:data['data']['total_site_balance'] ?? 0.00),
                      ),
                      const Gap(13),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              onTap: () {
                                // Get.snackbar("Message", 'Coming Soon...');
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (_) => const TransferView(),
                                // ));
                                Get.to(const AddMoney());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 35,
                                child: Text(
                                  'Deposit',
                                  style:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // const Gap(28),
                          const Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              onTap: () =>
                              {
                                // Get.snackbar("Message", 'Coming Soon...')
                                Get.to( CryptoView(), arguments: ['']),
                                // Get.to(WebsiteViewer(url: WebRoutes.tawktoLink,title: 'Trade Crypto',))
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: 35,

                                child: Text(
                                  'Exchange Crypto',
                                  style:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                      const Gap(40),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const UsableDashboardSlider(imagePaths: [
                        'assets/images/img_3.png',
                        'assets/images/dash_image.png',
                        'assets/images/img_2.png',
                      ])
                        ),

                      const Gap(16),
                      Center(
                          // padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        children: [
                          InkWell(
                            onTap: () =>
                            {
                              Get.to( const BuyGiftcardView())
                            },
                            child: const UsableDashboardCard(
                              backgroundColor: Color(0xBFC3E9E9),
                              title: 'Buy Gift Card',
                              iconBackgroundColor: Color(0xFF39D6D6),
                              icon: 'assets/svgs/dash_giftcard.svg',
                              // view:  null,
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                Get.to(const SellGiftcardView());
                                // var contact = "2348111218116";
                                // var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I want to Sell Giftcard";
                                // var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I want to Sell Giftcard')}";
                                //
                                // try{
                                //   if(Platform.isIOS){
                                //     await launchUrl(Uri.parse(iosUrl));
                                //   }
                                //   else{
                                //     await launchUrl(Uri.parse(androidUrl));
                                //   }
                                // } on Exception{
                                //   EasyLoading.showError('WhatsApp is not installed.');
                                // }
                              },
                              child: const UsableDashboardCard(
                                backgroundColor: Color(0xBFF7A9B7),
                                title: 'Sell Giftcard',
                                iconBackgroundColor: Color(0xFF2083AE),
                                icon: 'assets/svgs/dash_crypto.svg',
                              )),
                          InkWell(
                              onTap: () =>
                              {
                                Get.to(const BillsPaymentView())
                              },
                              child: const UsableDashboardCard(
                                backgroundColor: Color(0xBFF7F4A9),
                                title: 'Bill Payment',
                                iconBackgroundColor: Color(0xFF752999),
                                icon: 'assets/svgs/bill.svg',)
                          ),

                          InkWell(
                              onTap: () =>
                              {
                                Get.to( ExchangeScreen())
                                // Get.snackbar("Message", 'Coming Soon...')
                              },
                              child: const UsableDashboardCard(
                                backgroundColor: Color(0xFF83EFFF),
                                title: 'Exchange Crypto',
                                iconBackgroundColor: Color(0xFFD90429),
                                icon: 'assets/svgs/flight.svg',)
                          ),

                        ],
                      )
          ),


                      const Gap(16),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Transaction History'),
                          // InkWell(
                          //   child: Text('See all'),
                          // )
                        ],
                      )
          ),
                      const Gap(26),

                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(depositHistory.length, (index){
                          var trx = depositHistory[index]['history'][0];
                          print(trx);
                          String time = DateFormat('hh:mm a').format(DateTime.parse('${trx['created_at']}'));
                          String formatted = DateFormat('dd MMM yyyy').format(DateTime.parse('${trx['created_at']}'));
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
                      ),
                    )
                        ),
                   Gap(MediaQuery
                          .of(context)
                          .padding
                          .bottom + 18),
                    ],
          ),
          );
                  }),
      );
    // });
  }
}


Widget dashCard(BuildContext context,String balance) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFf2f9fc),
        borderRadius: BorderRadius.circular(16),
      ),
      height: 100,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(11),
          Text(
            'Account balance',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.black.withOpacity(.8),
                ),
          ),
          // const Gap(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // const Gap(8),
              Text(
                balance,

                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black,
                  fontFamily: 'Roboto',
                    ),
              ),
              const Gap(8),
              const Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.black,
              ),
            ],
          )
        ],
      ),
    );
