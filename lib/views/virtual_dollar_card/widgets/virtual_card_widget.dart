import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

Widget virtualCard(BuildContext context) => Container(
      // height: 200,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/svgs/volex.svg'),
              Image.asset('assets/images/visa.png'),
            ],
          ),
          const Gap(39),
          Text(
            '**** **** ****  2345',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.white,
                ),
          ),
          Row(
            children: [
              Image.asset('assets/images/card_part.png'),
            ],
          ),
          const Gap(12),
          Row(
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
                  const Gap(10),
                  Text(
                    'Norman Manzoor',
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
                  const Gap(10),
                  Text(
                    '02/30',
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
        ],
      ),
    );
