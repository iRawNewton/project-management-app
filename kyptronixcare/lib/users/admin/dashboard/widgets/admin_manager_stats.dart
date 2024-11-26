import 'package:flutter/material.dart';

class ManagerPerformanceCard extends StatelessWidget {
  final String managerName;
  final int projectsManaged;
  final List<String> ongoingProjects;
  final List<Color> gradientColor;
  final double currentMonthCollection;

  const ManagerPerformanceCard({
    super.key,
    required this.managerName,
    required this.projectsManaged,
    required this.ongoingProjects,
    required this.gradientColor,
    required this.currentMonthCollection,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  managerName,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow(Icons.work, 'Projects Managed',
                    '$projectsManaged', context),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.pending_actions, 'Ongoing Projects',
                    '${ongoingProjects.length}', context),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.attach_money, 'Current Month Collection',
                    '\$${currentMonthCollection.toStringAsFixed(2)}', context),
                const SizedBox(height: 16),
                Text(
                  'Ongoing Projects:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ongoingProjects
                      .map((project) => Chip(
                            label: Text(project),
                            backgroundColor: Colors.white.withOpacity(0.2),
                            labelStyle: const TextStyle(color: Colors.white),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, String value, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            '$label: $value',
            // style: const TextStyle(fontSize: 16.0, color: Colors.white),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }
}
