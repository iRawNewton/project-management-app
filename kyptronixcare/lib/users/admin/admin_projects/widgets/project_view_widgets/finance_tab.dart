import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animate_card.dart';
import 'color_palette.dart';
import 'section_card.dart';

class FinanceTab extends StatelessWidget {
  final bool isDark;
  const FinanceTab({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AnimateCard(
          child: SectionCard(
            isDark: isDark,
            title: 'Budget Overview',
            icon: Icons.account_balance_wallet,
            iconColor:
                isDark ? ColorPalette.darkSuccess : ColorPalette.lightSuccess,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Budget',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    Text(
                      '\$50,000',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? ColorPalette.darkSuccess
                            : ColorPalette.lightSuccess,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // ClipRRect
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.7,
                    minHeight: 8,
                    backgroundColor: isDark
                        ? ColorPalette.darkSuccess.withOpacity(0.1)
                        : ColorPalette.lightSuccess.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(isDark
                        ? ColorPalette.darkSuccess
                        : ColorPalette.lightSuccess),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Budget utilized: 70%',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        AnimateCard(
          child: SectionCard(
            isDark: isDark,
            title: 'Recent Payments',
            icon: Icons.payment,
            iconColor:
                isDark ? ColorPalette.darkAccent3 : ColorPalette.lightAccent3,
            child: Column(
              children: List.generate(
                5,
                (index) => _buildPaymentTile(index, isDark),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentTile(int index, bool isDark) {
    final bool isIncoming = index % 2 == 0;
    final Color statusColor = isIncoming
        ? isDark
            ? ColorPalette.darkSuccess
            : ColorPalette.lightSuccess
        : isDark
            ? ColorPalette.darkAccent3
            : ColorPalette.lightAccent3;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            statusColor.withOpacity(0.1),
            isDark ? Colors.black12 : Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isIncoming ? Icons.arrow_downward : Icons.arrow_upward,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isIncoming ? 'Payment Received' : 'Payment Sent',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  DateTime.now()
                      .subtract(Duration(days: index * 3))
                      .toString()
                      .substring(0, 10),
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${(index + 1) * 1000}',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: statusColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isIncoming ? 'Completed' : 'Processing',
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
