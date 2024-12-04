import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animate_card.dart';
import 'color_palette.dart';

class TasksTab extends StatelessWidget {
  final bool isDark;
  const TasksTab({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final List<Color> priorityColors = isDark
        ? [
            ColorPalette.darkError,
            ColorPalette.darkWarning,
            ColorPalette.darkSuccess,
            ColorPalette.darkAccent1,
            ColorPalette.darkAccent2,
          ]
        : [
            ColorPalette.lightError,
            ColorPalette.lightWarning,
            ColorPalette.lightSuccess,
            ColorPalette.lightAccent1,
            ColorPalette.lightAccent2,
          ];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => AnimateCard(
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                priorityColors[index].withOpacity(0.1),
                isDark ? Colors.black12 : Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: priorityColors[index].withOpacity(0.2),
            ),
          ),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: priorityColors[index].withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.task_alt, color: priorityColors[index]),
            ),
            title: Text(
              'Task ${index + 1}',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Due: ${DateTime.now().add(Duration(days: index + 1)).toString().substring(0, 10)}',
              style: GoogleFonts.poppins(),
            ),
            trailing: _buildPriorityBadge(index, isDark),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(int index, bool isDark) {
    final List<String> priorities = ['High', 'Medium', 'Low', 'Normal', 'Low'];
    final List<Color> priorityColors = isDark
        ? [
            ColorPalette.darkError,
            ColorPalette.darkWarning,
            ColorPalette.darkSuccess,
            ColorPalette.darkAccent1,
            ColorPalette.darkAccent2,
          ]
        : [
            ColorPalette.lightError,
            ColorPalette.lightWarning,
            ColorPalette.lightSuccess,
            ColorPalette.lightAccent1,
            ColorPalette.lightAccent2,
          ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: priorityColors[index].withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: priorityColors[index].withOpacity(0.2),
        ),
      ),
      child: Text(
        priorities[index],
        style: TextStyle(
          color: priorityColors[index],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
