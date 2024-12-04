import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animate_card.dart';
import 'color_palette.dart';
import 'section_card.dart';

class TeamTab extends StatelessWidget {
  final bool isDark;
  const TeamTab({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AnimateCard(
          child: SectionCard(
            isDark: isDark,
            title: 'Project Manager',
            icon: Icons.person,
            iconColor:
                isDark ? ColorPalette.darkAccent2 : ColorPalette.lightAccent2,
            child: _buildTeamMember(
              name: 'John Doe',
              role: 'Project Manager',
              color:
                  isDark ? ColorPalette.darkAccent2 : ColorPalette.lightAccent2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        AnimateCard(
          child: SectionCard(
            isDark: isDark,
            title: 'Team Members',
            icon: Icons.groups,
            iconColor:
                isDark ? ColorPalette.darkAccent3 : ColorPalette.lightAccent3,
            child: Column(
              children: List.generate(
                4,
                (index) => _buildTeamMember(
                  name: 'Developer ${index + 1}',
                  role: 'Senior Developer',
                  color: isDark
                      ? ColorPalette.darkAccent1
                      : ColorPalette.lightAccent1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String role,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Text(
              name[0],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  role,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.mail),
                color: color,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.chat),
                color: color,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
