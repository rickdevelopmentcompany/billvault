import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:volex/views/auth_views/otp_verification.dart';
import 'package:volex/views/success_view.dart';

class PinBottomsheetView extends StatefulWidget {
  const PinBottomsheetView({super.key});

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
    return Container(
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
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const OTPVerificationView(
                    next: SuccessView(),
                  ),
                ));
              },
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
