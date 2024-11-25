import 'package:billvaoit/resources/views/virtual_dollar_card/selfie.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gap/gap.dart';
import '../../widgets/custom_textfield.dart';
import '../../utils/button.dart';

class AddressInputScreen extends StatefulWidget {
  const AddressInputScreen({super.key});

  @override
  State<AddressInputScreen> createState() => _AddressInputScreenState();
}

class _AddressInputScreenState extends State<AddressInputScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();

  final GetStorage storage = GetStorage();

  final _formKey = GlobalKey<FormState>();

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      storage.write('address', addressController.text.trim());
      storage.write('city', cityController.text.trim());
      storage.write('state', stateController.text.trim());
      storage.write('country', countryController.text.trim());
      storage.write('postal_code', postalCodeController.text.trim());
      storage.write('house_no', houseNoController.text.trim());
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const Selfie(),
      ));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Address saved successfully')),
      // );

      // Navigate or perform further actions if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Address ', style: TextStyle(fontSize: 15),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30,),
              CustomTextfield(
                label: 'Address',
                hintText: 'Enter Address',
                ctrl: addressController,
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const Gap(16),
              CustomTextfield(
                label: 'City',
                hintText: 'Enter City',
                ctrl: cityController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const Gap(16),
              CustomTextfield(
                label: 'State',
                hintText: 'Enter State',
                ctrl: stateController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
              ),
              const Gap(16),
              CustomTextfield(
                label: 'Country',
                hintText: 'Enter Country',
                ctrl: countryController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country';
                  }
                  return null;
                },
              ),
              const Gap(16),
              CustomTextfield(
                label: 'Postal Code',
                hintText: 'Enter Postal Code',
                ctrl: postalCodeController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your postal code';
                  }
                  return null;
                },
              ),
              const Gap(16),
              CustomTextfield(
                label: 'House Number',
                hintText: 'Enter House Number',
                ctrl: houseNoController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your house number';
                  }
                  return null;
                },
              ),
              const Gap(32),
              primaryButton(
                context,
                title: 'Continue',
                onTap: _saveAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
