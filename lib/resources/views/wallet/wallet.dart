import 'dart:convert';
import 'dart:math';

import 'package:billvaoit/app/Models/Wallet.dart';
import 'package:billvaoit/app/http/controllers/wallet_controller.dart';
import 'package:billvaoit/resources/views/home/add_money/add_money.dart';
import 'package:billvaoit/resources/views/home/crypto/crypto_exchange_screen.dart';
import 'package:billvaoit/resources/views/home/transfer/transfer_view.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../app/Models/user/User.dart';
import '../../../app/http/controllers/crypto_controller.dart';
import '../../../app/http/controllers/payment_controller.dart';
import '../../../app/http/controllers/user_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/dashboard_topbar.dart';
import '../home/crypto/deposit/deposit_coin.dart';
import '../home/crypto/sell_crypto.dart';
import '../home/withdrawal/withdrawal.dart';
import '../home/withdrawal/withdrawal_by_card_view.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  late CryptoController cryptoController;
  final random_num = Random(2);
  GetStorage storage = GetStorage();
  bool showRecent = false;
  bool onAsset = false;
  String selected = 'All transactions';
  final dropdownItems = [
    'All transactions',
    'Bill Payment',
    'Buy Gift Card',
    'Wallet Top-Ups',
    'Withdrawals',
    'Virtual Card',
    'Crypto',
  ];// late CryptoController cryptoController;
  bool viewDetails = true;
  late PaymentController paymentController;
  List<Map<String, dynamic>> wallets = [];
  late TextEditingController amountController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cryptoController = Get.put(CryptoController());
    print("oj");
    initialiseState();
  }


  @override
  void dispose() {
    // ctrl.dispose();
    super.dispose();
  }

  Future<void> initialiseState() async {
    amountController = TextEditingController(text: '0');
    paymentController = Get.put(PaymentController());
    paymentController.isLoading.value = true;
    print('Loading started...');
    await paymentController.getDepositMethods();
    print("Loading ended....");
    print(paymentController.depositWallets);
    paymentController.isLoading.value = false;
  }


  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.put(WalletController());
    walletController.fetchResponse();

    Wallet wallet = Wallet();
    Map<String, dynamic> currencyDatas = wallet.getCurrencyData();

    User user = User();
    // UserController userController = Get.put(UserController());
    GetStorage storage = GetStorage();
    var data = json.decode(storage.read('dashboard'));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: DasboardTopBar(),
      ),
      body: Obx((){
        return paymentController.isLoading.value ? const UsableLoading() : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const Gap(24),
              BalanceCard(balance:data['data']['total_site_balance'] ?? 0.00),
              const Gap(13),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const AddMoney(),
                        ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:  AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(33),
                        ),
                        height: 40,
                        child: Text(
                          'Add Money',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const Withdrawal(),
                        ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(33),
                        ),
                        height: 40,
                        child: Text(
                          'Withdraw',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(43),
              if (!onAsset) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Asset',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            onAsset = !onAsset;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                          child: Text(
                            'Transaction',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(13),
                // Column(
                //   children: cryptoController.cryptoList.map((crypto) {
                //     // Each `crypto` is a Map<String, dynamic>
                //     String key = crypto.keys.first;
                //     String _symbol = crypto.keys.last; // Assuming each map has only one key-value pair
                //     dynamic value = crypto[key];
                //     dynamic symbol = crypto[_symbol];
                //
                //     // Generate random percentage between -50% and +50%
                //     double randomPercent = (random_num.nextDouble() * 100) - 50;
                //     String percent = "${randomPercent.toStringAsFixed(2)}%";
                //
                //     // Customize the Row widget as needed
                //     return InkWell(
                //       onTap: () {
                //         storage.write('sell_crypto', {
                //           'name': value,
                //           'short_name': symbol,
                //           'address': crypto['address']
                //         });
                //         Get.to(ExchangeScreen());
                //       },
                //       child: Column(
                //         children: [
                //           const Gap(10),
                //           Container(
                //             padding: const EdgeInsets.symmetric(horizontal: 10),
                //             decoration: BoxDecoration(
                //               borderRadius: const BorderRadius.all(Radius.circular(12)),
                //               color: Colors.white,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.black.withOpacity(0.1),
                //                   spreadRadius: 1,
                //                   blurRadius: 1,
                //                 ),
                //               ],
                //             ),
                //             child: assetWidget(
                //               context,
                //               decrease: percent.startsWith('-') ? true : false,
                //               percent: percent,
                //               assetName: value,
                //               amount: '0.0000 ${symbol.toUpperCase()}',
                //               nairaAmount: '\$0.00',
                //               img: symbol.toLowerCase(),
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   }).toList(),
                // ),

                Gap(15),
                Column(
                  children: List.generate(paymentController.depositWallets.length, (index) {
                    final bundle = paymentController.depositWallets[index];
                    double rate = double.parse(bundle['currency']['rate'].toString());
                    double balance = double.parse(bundle['balance'].toString());

                    String bal;

                    if (balance == 0) {
                      bal = '0.00'; // You can adjust this as needed
                    } else {
                      double result =  balance * rate;
                      // Format with commas and two decimal places
                      bal = NumberFormat('#,##0.00').format(result);
                    }
                    double ba = double.parse(bundle['currency']['rate']);
                    String nairaAmount =
                        '${NumberFormat('#,##0.00').format(ba)}/₦';
                    return InkWell(
                      onTap: () async {
                        paymentController.isLoading.value = true;
                        paymentController.setSelectedWallet(bundle['currency']['currency_fullname']);
                        print( bundle['currency']['currency_code'].toString().toLowerCase());
                        paymentController.min_amount.value = '';
                        paymentController.max_amount.value = '';
                        paymentController.rate.value = '';
                        paymentController.paymentCurrencyShortCode.value = '';
                        // plan = bundle;
                        wallets = await  paymentController.getGateways(bundle['currency_id'].toString());
                        // paymentContrzoller.exchangeConfirm();
                        GetStorage().write('crypto_wallets', wallets);
                        GetStorage().write('crypto_', bundle);

                        paymentController.isLoading.value = false;
                        // ctrl.text = bundle['price'].toString();
                        // print(data_bundle);
                        // print(billPaymentsController.selectedDataBundle.value); // Use .value
                        // Navigator.pop(context);
                        Get.delete<PaymentController>();
                        Get.to(()=> ExchangeScreen());
                        // Get.to(()=> const WebViewScreen(redirectUrl: 'https://billvaolt.payvalue.com.ng/user/exchange/money'));
                      },
                      child: Column(
                        children: [
                          bundle['currency']['currency_code'] != 'NGN' && bundle['currency']['currency_code'] != 'USD' ?
                          assetWidget(
                            context,
                            decrease:false,
                            percent: 'Bal ~ ₦$bal' ,
                            assetName: bundle['currency']['currency_fullname'], // Use the full name of the currency
                            amount: '${double.parse(bundle['balance'].toString()).toStringAsFixed(4)} ${bundle['currency']['currency_symbol'].toString().toUpperCase()}', // Show the balance with the currency code
                            nairaAmount: nairaAmount , // Convert to a display amount
                            img: bundle['currency']['currency_code'].toString().toLowerCase(), // Assuming this is the image asset name
                          ): Container(),
                          // addMoneyWidget(
                          //   context,
                          //   title: bundle['currency']['currency_fullname'],
                          //   img: bundle['currency']['currency_code'].toString().toLowerCase(),
                          // ),
                          const Gap(16),
                          // if (index != paymentController.depositWallets.length - 1)
                          //   const Divider(color: AppColors.greyBorderColor),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ],
          ),
        ),
      );
  }),
    );
  }
}

class CurrencyList extends StatelessWidget {
  final Map<String, dynamic> currencyDatas;

  const CurrencyList({required this.currencyDatas});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
      shrinkWrap: true, // Makes the ListView fit the content
      itemCount: currencyDatas.length,
      itemBuilder: (context, index) {
        String key = currencyDatas.keys.elementAt(index);
        var value = currencyDatas[key];
        print(value);
        return CurrencyCard(
          currencyKey: key,
          currencyFullname: value['currency_fullname'],
          currencySymbol: value['currency_symbol'],
          rate: value['rate'],
          isDefault: value['is_default'],
          createdAt: value['created_at'],
        );
      },
    );
  }
}

class CurrencyCard extends StatelessWidget {
  final String currencyKey;
  final String currencyFullname;
  final String currencySymbol;
  final String rate;
  final int isDefault;
  final String createdAt;

  const CurrencyCard({
    required this.currencyKey,
    required this.currencyFullname,
    required this.currencySymbol,
    required this.rate,
    required this.isDefault,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(1),
      child: ListTile(
        title: Text("$currencyKey ($currencyFullname)"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Currency Symbol: $currencySymbol", style: const TextStyle(
              fontFamily: 'Roboto'
            ),),
            Text("Rate: $rate"),
            Text("Is Default: ${isDefault == 1 ? 'Yes' : 'No'}"),
            Text("Created At: $createdAt"),
          ],
        ),
      ),
    );
  }
}
Widget transactionHistoryWidget(
    BuildContext context, {
      String title = '',
      String amount = '',
      String svg = '',
    }) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/icons/$svg.svg', // Path to your SVG asset
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          amount,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.green, // Adjust color as needed
          ),
        ),
      ],
    ),
  );
}
