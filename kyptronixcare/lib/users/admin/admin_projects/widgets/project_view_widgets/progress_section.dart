import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyptronixcare/users/admin/admin_projects/widgets/project_view_widgets/section_card.dart';

import '../../../../model/projects_model.dart';
import 'color_palette.dart';

class ProgressSection extends StatelessWidget {
  final bool isDark;
  final ProjectModel project;
  const ProgressSection(
      {super.key, required this.isDark, required this.project});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      isDark: isDark,
      title: 'Progress',
      icon: Icons.trending_up,
      iconColor: isDark
          ? ColorPalette.darkPrimaryGradientMiddle
          : ColorPalette.lightPrimaryGradientMiddle,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressStat(
                title: 'Tasks',
                value: '24/36',
                color: isDark
                    ? ColorPalette.darkAccent1
                    : ColorPalette.lightAccent1,
              ),
              _buildProgressStat(
                title: 'Days',
                value: '45 left',
                color: isDark
                    ? ColorPalette.darkAccent2
                    : ColorPalette.lightAccent2,
              ),
              _buildProgressStat(
                title: 'Budget',
                value: '70%',
                color: isDark
                    ? ColorPalette.darkAccent3
                    : ColorPalette.lightAccent3,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.75,
              minHeight: 8,
              backgroundColor: isDark
                  ? ColorPalette.darkPrimaryGradientStart.withOpacity(0.1)
                  : ColorPalette.lightPrimaryGradientStart.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark
                    ? ColorPalette.darkPrimaryGradientMiddle
                    : ColorPalette.lightPrimaryGradientMiddle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStat({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
