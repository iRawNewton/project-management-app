import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminMissedPayments extends StatelessWidget {
  const AdminMissedPayments({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Define colors for light and dark modes
    final backgroundColor = isDarkMode ? Colors.red[800] : Colors.red[50];
    final iconColor = isDarkMode ? Colors.redAccent : Colors.redAccent;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final buttonColor = isDarkMode ? Colors.redAccent : Colors.redAccent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(12.0),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.warning, color: iconColor),
                  title: Text(
                    'Project XYZ - Part 2',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    'Payment Due: ₹10,000',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Logic to notify client
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    child: Text(
                      'Notify Client',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Additional missed payments can be listed here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
