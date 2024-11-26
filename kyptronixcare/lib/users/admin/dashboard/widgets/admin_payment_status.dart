import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminPaymentStatus extends StatelessWidget {
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  const AdminPaymentStatus(
      {super.key, required this.textTheme, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusCard(
            'Received',
            Colors.green.shade800,
            textTheme,
            context,
          ),
          _buildStatusCard(
            'Pending',
            Colors.orange.shade800,
            textTheme,
            context,
          ),
          _buildStatusCard(
            'Total',
            Colors.blue.shade800,
            textTheme,
            context,
          ),
        ],
      ),
    );
  }

  // Helper Method: Status Card
  Widget _buildStatusCard(
      String title, Color color, TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.30,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
          child: Column(
            children: [
              Text(
                title,
                style: textTheme.bodyLarge!.copyWith(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              const Gap(8.0),
              Text(
                '\$0',
                style: textTheme.displayLarge!.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
