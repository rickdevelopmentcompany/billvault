import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CurrencyCardChart extends StatelessWidget {
  final String currencyKey;
  final String currencyFullname;
  final String currencySymbol;
  final String rate;
  final List<FlSpot> trendData;
  final String percentageChange;
  final Color percentageChangeColor;

  const CurrencyCardChart({
    required this.currencyKey,
    required this.currencyFullname,
    required this.currencySymbol,
    required this.rate,
    required this.trendData,
    required this.percentageChange,
    required this.percentageChangeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Crypto name and percentage change
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currencyKey,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      percentageChange,
                      style: TextStyle(
                        fontSize: 16,
                        color: percentageChangeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      percentageChangeColor == Colors.green
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: percentageChangeColor,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Currency rate and symbol
            Text(
              "Rate: $rate NGN",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Balance: $currencySymbol",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),

            // Line chart showing price trends
            SizedBox(
              height: 50,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(
                    show: false,
                    border: const Border(
                      bottom: BorderSide(color: Colors.grey, width: 1),
                      left: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: trendData,
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      color: percentageChangeColor,  // This is the correct usage now
                      belowBarData: BarAreaData(show: false),
                      barWidth: 2,
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
