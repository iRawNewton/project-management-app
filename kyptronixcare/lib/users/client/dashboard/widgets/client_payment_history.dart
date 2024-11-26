import 'package:flutter/material.dart';

class ClientPaymentHistory extends StatelessWidget {
  const ClientPaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPaymentCard(
          context,
          amount: 1500.0,
          dueDate: '2024-09-15',
          status: 'Pending',
        ),
        const SizedBox(height: 10),
        _buildPaymentCard(
          context,
          amount: 1200.0,
          dueDate: '2024-08-15',
          status: 'Completed',
        ),
        // Add more payments here
      ],
    );
  }

  Widget _buildPaymentCard(
    BuildContext context, {
    required double amount,
    required String dueDate,
    required String status,
  }) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkTheme = theme.brightness == Brightness.dark;

    final cardGradient = LinearGradient(
      colors: isDarkTheme
          ? [Colors.blueGrey[900]!, Colors.blueGrey[700]!]
          : [Colors.blue[100]!, Colors.blue[300]!],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final statusColor =
        status == 'Pending' ? Colors.orangeAccent : Colors.greenAccent;

    final textColor = isDarkTheme ? Colors.white : Colors.black87;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: cardGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${amount.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Due Date: $dueDate',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDarkTheme ? Colors.grey[400] : Colors.black54,
                    ),
                  ),
                ],
              ),
              Chip(
                label: Text(
                  status,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: statusColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
