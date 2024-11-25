import 'package:billvaoit/app/http/controllers/giftcards/giftcard_controller.dart';
import 'package:billvaoit/app/http/controllers/giftcards/sell_giftcard_controller.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../widgets/custom_textfield.dart';
import 'sell_single_giftcard.dart';
import 'package:get/get.dart';


class SellGiftcardView extends StatefulWidget {
  const SellGiftcardView({super.key});

  @override
  State<SellGiftcardView> createState() => SellGiftcardViewState();
}

class SellGiftcardViewState extends State<SellGiftcardView> {
  GiftCardController giftCardController = Get.put(GiftCardController());
  bool viewDetails = true;



  @override
  void initState() {
    super.initState();
    init();

  }


  Future<void> init() async{
    giftCardController.isLoading.value = true;
    await giftCardController.getCategories();
    // await Future.delayed(const Duration(seconds: 3));
    giftCardController.isLoading.value = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx((){
        return giftCardController.isLoading.value ? const UsableLoading() : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(MediaQuery.of(context).padding.top + 24),
                InkWell(
                  onTap: Navigator.of(context).pop,
                  splashColor: Colors.transparent,
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back),
                      const Gap(24),
                      Text(
                        'Sell Gift Card',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(28),
                CustomTextfield(
                    label: 'Select Country',
                    hintText: 'Nigeria',
                    callback: () async {
                      final sheet = await showModalBottomSheet(
                        context: context,
                        builder: (_) => Container(
                          color: Colors.red,
                        ),
                      );
                      print(sheet);
                    }),
                const Gap(11),
                const CustomTextfield(
                  hintText: 'Search for Giftcard',
                  trailingSvg: 'search',
                ),
                const Gap(11),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    giftcardWidget(context,'Apple Card','apple-gc.png'),
                    giftcardWidget(context,'Amazon Card','amazon-gc.png'),
                    giftcardWidget(context,'Steam Card','visa-gc.png'),
                    giftcardWidget(context,'Razor Gold card','apple-gc.png'),
                    giftcardWidget(context,'Google play Card','google-gc.png'),
                    giftcardWidget(context,'Xbox Giftcard ','myglamm-gc.png'),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget giftcardWidget(BuildContext context, String? name, String? img) => InkWell(
  onTap: () {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const SellSingleGiftcardView(),
    ));
  },
  child: Container(
    width: 150,
    // color: Colors.red,
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/$img'),
        const Gap(15),
        Text(
          name.toString(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        )
      ],
    ),
  ),
);
