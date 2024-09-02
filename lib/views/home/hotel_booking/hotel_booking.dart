import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/custom_textfield.dart';

class HotelBooking extends StatelessWidget {
  const HotelBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(MediaQuery.of(context).padding.top + 24),
              InkWell(
                onTap: Navigator.of(context).pop,
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back),
                    const Gap(24),
                    Text(
                      'Hotel Booking',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              const CustomTextfield(
                hintText: 'Search for country, Hotel',
                svgPrefix: 'hotel_search',
                trailingSvg: 'filter',
              ),
              const Gap(11),
              Text(
                'Recommended for you',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Gap(18),
              Container(
                color: Colors.red,
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => Column(
                    children: [
                      recommendedWidget(context, title: 'The An’s Vill Hotel'),
                    ],
                  ),
                ),
              ),
              //
              Gap(MediaQuery.of(context).padding.bottom + 24),
            ],
          ),
        ),
      ),
    );
  }
}

Widget recommendedWidget(
  BuildContext context, {
  required String title,
  String? rating,
}) =>
    Container(
      width: 253,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/hotel_image.png'),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/star.svg',
                      colorFilter: const ColorFilter.mode(
                        Colors.yellow,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      rating ?? '5.0',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Pimple Gurav, Pune',
               style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
            ),
          ),
          const Gap(8),
        ],
      ),
    );
