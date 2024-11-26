import 'package:flutter/material.dart';
import 'package:kyptronixcare/users/client/project/client_project_details.dart';

class ClientProjectOverview extends StatelessWidget {
  const ClientProjectOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProjectCard(
          context,
          projectName: 'Project A',
          status: 'Ongoing',
          progress: 0.75,
          onQuickViewPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClientProjectDetails(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildProjectCard(
          context,
          projectName: 'Project B',
          status: 'Pending',
          progress: 0.4,
          onQuickViewPressed: () {
            // Handle Quick View
          },
        ),
        // Add more projects here
      ],
    );
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String projectName,
    required String status,
    required double progress,
    required VoidCallback onQuickViewPressed,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                projectName,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isDarkTheme ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Status: $status',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isDarkTheme ? Colors.grey[400] : Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: progress,
                backgroundColor:
                    isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDarkTheme ? Colors.cyanAccent : Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDarkTheme ? Colors.cyanAccent : Colors.blueAccent,
                    foregroundColor:
                        isDarkTheme ? Colors.black87 : Colors.white,
                  ),
                  onPressed: onQuickViewPressed,
                  child: const Text('Quick View'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
