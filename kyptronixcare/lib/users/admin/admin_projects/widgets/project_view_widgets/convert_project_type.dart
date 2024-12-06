import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyptronixcare/users/admin/admin_projects/bloc/admin_projects_bloc.dart';
import 'package:kyptronixcare/users/model/projects_model.dart';

import 'color_palette.dart';

class ConvertProjectType extends StatelessWidget {
  final String currentProjectType;
  final Function(bool) onConversionConfirmed;
  final ProjectModel projectModel;

  const ConvertProjectType({
    super.key,
    required this.currentProjectType,
    required this.onConversionConfirmed,
    required this.projectModel,
  });

  void _showConversionDialog(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Convert to Multiple Projects',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange[600],
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                'You\'re about to switch to multiple projects. This cannot be undone. Please confirm your decision to proceed.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: isDarkMode ? Colors.white : Colors.black,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();
                context
                    .read<AdminProjectsBloc>()
                    .add(AdminProjectsConvertToSubProjectsEvent(projectModel));
                // Add your conversion logic here
                // For example: _convertToMultipleProjects();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorPalette.getCardBg1(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showConversionDialog(context),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Type: $currentProjectType',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Click to Convert to Multiple Project Type',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.swap_horiz,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
