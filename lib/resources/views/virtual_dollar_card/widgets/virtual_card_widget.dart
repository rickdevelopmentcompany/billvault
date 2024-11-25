import 'package:billvaoit/app/Models/user/User.dart';
import 'package:billvaoit/app/http/controllers/virtual_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

Widget virtualCard({required BuildContext context, bool viewDetails = false,required VirtualDollarCardController virtualDollarCardController}) => Container(
      // height: 200,
  width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/card_bg.png'),
        ),

      ),
      child: Column(
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Column(
              children: [
                Text(
                  'CVV',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                Text(
                  viewDetails ? virtualDollarCardController.cvv : '****',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
          const Gap(80),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                viewDetails ? virtualDollarCardController.cardNumber : '****  ****  ****  ****',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const Gap(12),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card holder name',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      viewDetails ? virtualDollarCardController.fullName : '****',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiry date',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      viewDetails ? virtualDollarCardController.expiringDate : '****',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
