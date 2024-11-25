import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/button.dart';
import '../../widgets/custom_textfield.dart';
import 'address_screen.dart';

class KycVerification extends StatefulWidget {
  const KycVerification({super.key});

  @override
  State<KycVerification> createState() => _KycVerificationState();
}

class _KycVerificationState extends State<KycVerification> {
  String selectedDocumentType = 'BVN';
  GetStorage storage = GetStorage();
  TextEditingController bvnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:
        InkWell(
          splashColor: Colors.transparent,
          onTap: Navigator.of(context).pop,
          child: const Row(
            children: [ const Gap(14),
              const Icon(Icons.arrow_back),


            ],
          ),
        ),
        title: Text(
          'KYC Verification ',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
          children: [
                  // Gap(MediaQuery.of(context).padding.top + 24),
                  const Gap(57),
                  SvgPicture.asset('assets/svgs/kyc.svg'),
                  const Gap(13),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:Text(
                    'KYC Verification',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  )),
                  const Gap(22),
                  Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child:Text(
                    'Verify your identity! Upload a\ngovernment-issued ID (Passport, driver’s license, national ID card) to complete KYC verification, secure your account and unlock full platform features.',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.textGreyColor2,
                    ),
                    textAlign: TextAlign.center,
                  )),
                  const Gap(48),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Document Type',textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16),
                    )],
                  )),
                  const Gap(8),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:InkWell(
                    onTap: () =>_showDocumentTypeBottomSheet(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Row(
                        children: [
                          Text( selectedDocumentType),
                          const Spacer(),
                          SvgPicture.asset('assets/svgs/dropdown.svg'),
                        ],
                      ),
                    ),
                  )),
                  const Gap(24),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextfield(
                      label: 'BVN Number',
                      hintText: 'Enter BVN number',
                      ctrl: bvnController,
                      keyboardType: TextInputType.phone,
                    )),
                  // const Spacer(),
                Column(
                  children: [

                    const Gap(37),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: primaryButton(context, title: 'Proceed', onTap: () {
                          if(bvnController.text.isEmpty){
                            Get.snackbar("Error","Provide your BVN!",backgroundColor: Colors.red,colorText: Colors.white,
                                icon: const Icon( Icons.warning_amber_rounded));
                          }else if(bvnController.text.length != 11) {
                            Get.snackbar("Error","Provide a valid BVN!",backgroundColor: Colors.red,colorText: Colors.white,
                                icon: const Icon( Icons.warning_amber_rounded));
                          }else{
                            storage.write('bvn', bvnController.text);
                            storage.write('selected_document_type', selectedDocumentType);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const AddressInputScreen(),
                            ));
                          }
                        })),
                  ],
                )
          ]),
    );
  }

  void _showDocumentTypeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Document Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              const Gap(16),
              ListTile(
                title: const Text('BVN'),
                onTap: () {
                  setState(() {
                    selectedDocumentType = 'BVN';
                  });
                  Navigator.of(context).pop();
                },
              ),
              // ListTile(
              //   title: const Text('NIN'),
              //   onTap: () {
              //     setState(() {
              //       selectedDocumentType = 'NIN';
              //     });
              //     Navigator.of(context).pop();
              //   },
              // ),
              // ListTile(
              //   title: const Text('Nigerian International Passport'),
              //   onTap: () {
              //     setState(() {
              //       selectedDocumentType = 'Nigerian International Passport';
              //     });
              //     Navigator.of(context).pop();
              //   },
              // ),
              // ListTile(
              //   title: const Text('Nigerian PVC'),
              //   onTap: () {
              //     setState(() {
              //       selectedDocumentType = 'Nigerian PVC';
              //     });
              //     Navigator.of(context).pop();
              //   },
              // ),
              // ListTile(
              //   title: const Text('Nigerian Drivers License'),
              //   onTap: () {
              //     setState(() {
              //       selectedDocumentType = 'Nigerian Drivers License';
              //     });
              //     Navigator.of(context).pop();
              //   },
              // ),
              // const Gap(16),
              // ElevatedButton(
              //   onPressed: () {
              //     // Functionality for uploading a picture
              //   },
              //   child: const Text('Upload Document Picture'),
              // ),
            ],
          ),
        );
      },
    );
  }
}
