import 'dart:io';

import 'package:billvaoit/app/Models/user/User.dart';
import 'package:billvaoit/app/http/controllers/virtual_card_controller.dart';
import 'package:billvaoit/resources/views/virtual_dollar_card/virtual_dollar_card.dart';
import 'package:billvaoit/resources/widgets/usable_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/button.dart';
import '../auth_views/otp_verification.dart';
import '../success_view.dart';
import 'card_details_view.dart';
import 'card_pin.dart';

class Selfie extends StatefulWidget {
  const Selfie({super.key});

  @override
  State<Selfie> createState() => _SelfieState();
}

class _SelfieState extends State<Selfie> {
  XFile? _selfieImage;
  final ImagePicker _picker = ImagePicker();
  final GetStorage _storage = GetStorage();
  VirtualDollarCardController virtualDollarCardController = Get.put(VirtualDollarCardController());

  @override
  void initState(){
    super.initState();
    load();
  }

  Future<void> load() async {
    virtualDollarCardController.isLoading.value = true;

    await Future.delayed(const Duration(seconds: 3));

    virtualDollarCardController.isLoading.value = false;
  }

  Future<void> _takeSelfie() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front, // Restricts to front camera
    );
    if (image != null) {
      setState(() {
        _selfieImage = image;
      });
      // Add code to store the image path if needed
      // Store the image path in GetStorage
      _storage.write('selfieImagePath', image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Obx((){
        return virtualDollarCardController.isLoading.value ? const UsableLoading() :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(MediaQuery.of(context).padding.top + 24),
            InkWell(
              splashColor: Colors.transparent,
              onTap: Navigator.of(context).pop,
              child: Row(
                children: [
                  const Icon(Icons.arrow_back),
                  const Gap(24),
                  Text(
                    'Take Selfie',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(57),
            SvgPicture.asset('assets/svgs/kyc.svg'),
            const Gap(13),
            Text(
              'Take a Selfie',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(22),
            Text(
              'Take a selfie for identity verification. Ensure your face is clearly visible and well-lit.',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.textGreyColor2,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            _selfieImage == null
                ? Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'No Selfie Taken',
                  style: TextStyle(
                    color: AppColors.textGreyColor2,
                    fontSize: 16,
                  ),
                ),
              ),
            )
                : Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(
                    File(_selfieImage!.path),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            _selfieImage == null
                ? primaryButton(
              context,
              title: _selfieImage == null ? 'Take Selfie' : 'Retake Selfie',
              onTap: _takeSelfie,
            ) :
            primaryButton(
              context,
              title: 'Upload',
              onTap: _selfieImage != null ? () async{


                virtualDollarCardController.isLoading.value = true;
                dynamic holder = await virtualDollarCardController.registerCardholder();
                virtualDollarCardController.isLoading.value = false;
                holder ? Get.to(PinScreen()) : null;
                // Future.delayed(const Duration(seconds: 1500));
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (_) => const SuccessView(
                //         content: 'Your selfie has been uploaded successfully',
                //         buttonText: 'View Card',
                //         next: VirtualDollarCard(),
                //     ),
                //   ),
                // );
              } : null,
            ),
            const Gap(38),
          ],
        ),
      );
  }),
    );
  }
}
