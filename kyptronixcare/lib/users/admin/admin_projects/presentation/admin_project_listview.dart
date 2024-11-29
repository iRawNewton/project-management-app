import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/custom_appbar.dart';
import 'admin_create_project.dart';
import 'admin_project_view.dart';

class Project {
  final String name;
  final double progress;
  final String client;
  final String manager;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime lastUpdated;
  final String paymentModel;
  final List<SubProject> subProjects;

  Project({
    required this.name,
    required this.progress,
    required this.client,
    required this.manager,
    required this.startDate,
    required this.endDate,
    required this.lastUpdated,
    required this.paymentModel,
    this.subProjects = const [],
  });
}

class SubProject {
  final String name;
  final double progress;
  final int remainingTasks;
  final DateTime startDate;
  final DateTime endDate;

  SubProject({
    required this.name,
    required this.progress,
    required this.remainingTasks,
    required this.startDate,
    required this.endDate,
  });
}

class AdminProjectListview extends StatelessWidget {
  const AdminProjectListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminCreateProject(),
                ),
              );
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.add),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppbar(title: 'Projects'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) =>
                      ProjectCard(project: sampleProjects[index]),
                  itemCount: sampleProjects.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: _isExpanded
            ? const LinearGradient(
                colors: [
                  Color(0xFF296FF9),
                  Color(0xFF296FF9),
                  Color(0xFF6717CD),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              )
            : const LinearGradient(
                colors: [Color(0xFF296FF9), Color.fromARGB(255, 18, 97, 255)]),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Project Information

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.project.name,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    _buildPaymentModelChip(widget.project.paymentModel, theme),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          '${(widget.project.progress * 100).toInt()}%',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: widget.project.progress,
                        backgroundColor: colorScheme.primary.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getProgressColor(
                              widget.project.progress, colorScheme),
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Project Details
                _buildDetailRow(
                  Icons.person,
                  'Client',
                  widget.project.client,
                  theme,
                ),
                const SizedBox(height: 4),
                _buildDetailRow(
                  Icons.manage_accounts,
                  'Manager',
                  widget.project.manager,
                  theme,
                ),
                const SizedBox(height: 4),
                _buildDetailRow(
                  Icons.calendar_today,
                  'Timeline',
                  '${DateFormat('MMM d, y').format(widget.project.startDate)} - ${DateFormat('MMM d, y').format(widget.project.endDate)}',
                  theme,
                ),
                const SizedBox(height: 4),
                _buildDetailRow(
                  Icons.update,
                  'Last Updated',
                  DateFormat('MMM d, y').format(widget.project.lastUpdated),
                  theme,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: theme.colorScheme.onPrimaryContainer,
                      backgroundColor: theme.colorScheme.primaryContainer,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProjectPage()));
                    },
                    label: Text(
                      'Click To View',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_right_rounded,
                      color: Colors.black,
                      weight: 30.0,
                      size: 30.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          // Sub-projects Section
          if (widget.project.subProjects.isNotEmpty)
            Column(
              children: [
                InkWell(
                  onTap: _toggleExpanded,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${widget.project.subProjects.length} Sub-projects',
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        RotationTransition(
                          turns: Tween(begin: 0.0, end: 0.5)
                              .animate(_expandAnimation),
                          child: const Icon(
                            Icons.expand_more,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizeTransition(
                  sizeFactor: _expandAnimation,
                  child: Column(
                    children: widget.project.subProjects
                        .map((subProject) => _buildSubProjectTile(
                              subProject,
                              theme,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentModelChip(String model, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            model == 'Recurring' ? Icons.repeat : Icons.money,
            size: 16,
            color: theme.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            model,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubProjectTile(SubProject subProject, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subProject.name,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: subProject.progress,
                        backgroundColor:
                            theme.colorScheme.primary.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getProgressColor(
                              subProject.progress, theme.colorScheme),
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remaining Tasks',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subProject.remainingTasks.toString(),
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${DateFormat('MMM d').format(subProject.startDate)} - ${DateFormat('MMM d').format(subProject.endDate)}',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(double progress, ColorScheme colorScheme) {
    if (progress >= 0.75) return Colors.green;
    if (progress >= 0.5) return colorScheme.primary;
    if (progress >= 0.25) return Colors.orange;
    return Colors.red;
  }
}

// Sample data for demonstration
final List<Project> sampleProjects = [
  Project(
    name: 'Website Redesign',
    progress: 0.75,
    client: 'Tech Corp',
    manager: 'John Doe',
    startDate: DateTime(2024, 1, 1),
    endDate: DateTime(2024, 6, 30),
    lastUpdated: DateTime(2024, 3, 15),
    paymentModel: 'One-Time',
    subProjects: [
      SubProject(
        name: 'Frontend Development',
        progress: 0.85,
        remainingTasks: 3,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 4, 30),
      ),
      SubProject(
        name: 'Backend Integration',
        progress: 0.65,
        remainingTasks: 7,
        startDate: DateTime(2024, 3, 1),
        endDate: DateTime(2024, 6, 30),
      ),
    ],
  ),
  Project(
    name: 'Mobile App Development',
    progress: 0.45,
    client: 'StartUp Inc',
    manager: 'Jane Smith',
    startDate: DateTime(2024, 2, 1),
    endDate: DateTime(2024, 8, 31),
    lastUpdated: DateTime(2024, 3, 10),
    paymentModel: 'Recurring',
  ),
];
