import 'package:billvaoit/app/http/controllers/crypto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../../../utils/button.dart';
import '../../../widgets/usable_loading.dart';
import '../../home.dart';


class TradeSuccessView extends StatefulWidget {
  final String? content;
  final String? buttonText;
  final Widget? next;
  final Widget? secondaryLocation;
  const TradeSuccessView({
    super.key,
    this.content,
    this.buttonText,
    this.next,
    this.secondaryLocation,
  });

  @override
  State<TradeSuccessView> createState() => TradeSuccessViewState();
}

class TradeSuccessViewState extends State<TradeSuccessView> {
  CryptoController controller = CryptoController();


  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 5));
    controller.isLoading.value = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delay();
  }


  @override
  Widget build(BuildContext context) {
    GetStorage storage = GetStorage();
    var coin_name = storage.read('sell_crypto')['name'];
    var amount = storage.read('trade_crypto')['amount'];
    return Scaffold(
      body:
      Stack(
      children: [
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Gap(),
            Container(
              margin:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 24),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: Navigator.of(context).pop,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/cancel.svg'),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Image.asset('assets/images/success.png'),
                const Gap(23),
                Text(
                  'Success!!!',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Gap(10),
                Text(
                  widget.content ?? 'You Successfully trade $amount  ${coin_name} ',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // const Spacer(),
            Column(
              children: [
                if (widget.secondaryLocation != null) ...[
                  primaryButton(
                    context,
                    title: 'View Receipt',
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => widget.secondaryLocation!,
                        ),
                      );
                    },
                  ),
                  const Gap(21),
                ],
                primaryButton(
                  context,
                  title: widget.buttonText ?? 'Go to Home',
                  onTap: () {
                    if (widget.next == null) {
                      Get.to(const Home());
                      return;
                    }
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => widget.next!,
                    ));
                  },
                ),
                Gap(MediaQuery.of(context).padding.bottom + 24),
              ],
            )
          ],
        ),
      ),
        Obx(() {
          return controller.isLoading.value
              ? const UsableLoading(opacity: 1.00,) : Container(); // Show loading animation
        }),
  ])
    );
  }
}
