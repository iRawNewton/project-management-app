import 'package:flutter/material.dart';

class ProjectSummaryCard extends StatelessWidget {
  final String projectName;
  final String category;
  final String status;
  final double progress;
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onDetailsPressed;

  const ProjectSummaryCard({
    super.key,
    required this.projectName,
    required this.category,
    required this.status,
    required this.progress,
    required this.startDate,
    required this.endDate,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Colors.grey[900]!, Colors.grey[800]!]
              : [Colors.white, Colors.grey[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.5)
                : Colors.grey.withOpacity(0.3),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            projectName,
            style: textTheme.titleLarge?.copyWith(
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            category,
            style: textTheme.bodyLarge?.copyWith(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Icon(
                _getStatusIcon(status),
                color: _getStatusColor(status),
              ),
              const SizedBox(width: 8.0),
              Text(
                status,
                style: textTheme.bodyLarge?.copyWith(
                  color: _getStatusColor(status),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
            color: _getProgressBarColor(progress),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Text(
                'Start: ${_formatDate(startDate)}',
                style: textTheme.displayLarge?.copyWith(
                  fontSize: 14.0,
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[700],
                ),
              ),
              const Spacer(),
              Text(
                'End: ${_formatDate(endDate)}',
                style: textTheme.displayLarge?.copyWith(
                  fontSize: 14.0,
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: onDetailsPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: _getButtonColor(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              elevation: 5.0,
            ),
            child: const Text('View Details'),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.pending;
      case 'ongoing':
        return Icons.play_circle_outline;
      case 'completed':
        return Icons.check_circle_outline;
      case 'paused':
        return Icons.pause_circle_outline;
      default:
        return Icons.help_outline;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'ongoing':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'paused':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getProgressBarColor(double progress) {
    return progress < 0.5 ? Colors.orange : Colors.green;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getButtonColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? Colors.blueAccent : Colors.blue;
  }
}
