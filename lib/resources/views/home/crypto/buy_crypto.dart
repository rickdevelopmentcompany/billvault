import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Ensure this package is installed

import '../../../../app/http/controllers/crypto_controller.dart';

class BuyCryptoScreen extends StatelessWidget {
  final CryptoController controller ;

  const BuyCryptoScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade Crypto',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        // backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Crypto Currency', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            // Dropdown for crypto selection
            Obx(() => DropdownButton<String>(
              value: controller.selectedCrypto.value,
              onChanged: (value) {
                if (value != null) {
                  controller.selectCrypto(value);
                }
              },
              items: controller.cryptoList
                  .map((crypto) => DropdownMenuItem<String>(
                value: crypto['name'],
                child: Text(crypto['name']),
              ))
                  .toList(),
            )),
           const SizedBox(height: 20),
            // Amount Input
            const Text('Enter Amount:'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.calculateCryptoAmount(ngnAmount: double.tryParse(value) ?? 0);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                suffixText: 'NGN',
              ),
            ),
            const SizedBox(height: 20),
            // Wallet Address and QR Code
            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.walletAddress.value, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                // Correctly use QrImage
                QrImageView(
                  data: controller.walletAddress.value,  // Pass the wallet address to generate the QR code
                  size: 150.0,
                  version: QrVersions.auto, // Optional
                ),
              ],
            )),
            SizedBox(height: 20),
            // Crypto Details Review
            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rate: ${controller.cryptoRate.value}'),
                Text('Amount: ${controller.cryptoAmount.value.toStringAsFixed(6)}'),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Proceed to payment
                  },
                  child: Text('Proceed to Payment'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }


}
