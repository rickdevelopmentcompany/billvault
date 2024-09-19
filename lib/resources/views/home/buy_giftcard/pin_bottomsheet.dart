import 'package:billvaoit/app/http/controllers/bill_payments.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class PinBottomsheetView extends StatefulWidget {
  final String? successText;
  final Widget? next;
  const PinBottomsheetView({super.key, this.successText, this.next});

  @override
  State<PinBottomsheetView> createState() => _PinBottomsheetViewState();
}

class _PinBottomsheetViewState extends State<PinBottomsheetView> {
  late TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController();
  }

  @override
  void dispose() {
    _ctrl = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Gap(16),
            Container(
              width: 40,
              height: 2,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.29),
                  borderRadius: BorderRadius.circular(28)),
            ),
            const Gap(24),
            Text(
              'Enter your 4-digit pin',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(35),
            Pinput(
              controller: _ctrl,
              length: 4,
              onCompleted: (val) {
                print(val);
                Get.put(BillPaymentsController());

              //   Navigator.of(context).pop();
              //   Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (_) =>
              //         // SellGiftcardSuccessView(content: widget.successText,)
              //   ));
              },
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
