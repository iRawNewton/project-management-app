import 'package:flutter/material.dart';

class AdminPaymentHistory extends StatelessWidget {
  const AdminPaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Define colors for light and dark modes
    final backgroundColor = isDarkMode ? Colors.grey[850] : Colors.blueGrey[50];
    final iconColor = isDarkMode ? Colors.lightBlueAccent : Colors.blueAccent;
    final receivedColor = isDarkMode ? Colors.lightGreenAccent : Colors.green;
    final overdueColor = isDarkMode ? Colors.redAccent : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.history, color: iconColor),
                  title: Text(
                    'Project ABC - Part 1',
                    style: theme.textTheme.bodyLarge!.copyWith(fontSize: 14.0),
                  ),
                  subtitle: Text(
                    'One-Time Payment: ₹50,000',
                    style: theme.textTheme.bodyLarge!.copyWith(fontSize: 14.0),
                  ),
                  trailing: Text(
                    'Received',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 12.0,
                      color: receivedColor,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.history, color: iconColor),
                  title: Text(
                    'Project XYZ - Part 2',
                    style: theme.textTheme.bodyLarge!.copyWith(fontSize: 14.0),
                  ),
                  subtitle: Text(
                    'Monthly Payment: ₹10,000',
                    style: theme.textTheme.bodyLarge!.copyWith(fontSize: 14.0),
                  ),
                  trailing: Text(
                    'Overdue',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 12.0,
                      color: overdueColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
