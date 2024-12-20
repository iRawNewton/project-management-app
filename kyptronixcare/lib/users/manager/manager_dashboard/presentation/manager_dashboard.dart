import 'package:flutter/material.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme.bodyLarge;

    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardTheme(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: isDark ? Colors.grey[850] : Colors.white,
        ),
      ),
      child: Scaffold(
        appBar: _buildAppBar(colorScheme),
        body: _buildBody(colorScheme, isDark, textTheme),
        floatingActionButton: _buildFAB(colorScheme),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ColorScheme colorScheme) {
    return AppBar(
      elevation: 0,
      backgroundColor: colorScheme.surface,
      title: Text(
        'Manager Dashboard',
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
          tooltip: 'Notifications',
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
            tooltip: 'Profile',
          ),
        ),
      ],
    );
  }

  Widget _buildBody(
      ColorScheme colorScheme, bool isDark, TextStyle? textTheme) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Column(
          spacing: 16.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectOverview(colorScheme, isDark, textTheme),
            _buildProgressTracking(colorScheme, isDark, textTheme),
            _buildTaskManagement(colorScheme, isDark, textTheme),
            _buildPaymentsSection(colorScheme, isDark, textTheme),
            _buildFinancialSummary(colorScheme, isDark, textTheme),
            _buildTeamCollaboration(colorScheme, isDark, textTheme),
            _buildHistoryAndUpdates(colorScheme, isDark, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB(ColorScheme colorScheme) {
    return FloatingActionButton.extended(
      onPressed: () {},
      icon: const Icon(Icons.add),
      label: const Text('New Task'),
      elevation: 4,
      backgroundColor: colorScheme.primary,
    );
  }

  Widget _buildProjectOverview(
      ColorScheme colorScheme, bool isDark, TextStyle? textTheme) {
    return _buildAnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Project Overview', colorScheme, textTheme),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildStatusCard(
                  'Pending', Colors.amber, 3, colorScheme, textTheme),
              _buildStatusCard('Ongoing', const Color(0xFF2196F3), 5,
                  colorScheme, textTheme),
              _buildStatusCard(
                  'Paused', const Color(0xFFF44336), 2, colorScheme, textTheme),
              _buildStatusCard('Completed', const Color(0xFF4CAF50), 7,
                  colorScheme, textTheme),
              _buildStatusCard('Waiting for Approval', const Color(0xFFFF9800),
                  2, colorScheme, textTheme),
            ],
          ),
        ],
      ),
      isDark: isDark,
    );
  }

  Widget _buildProgressTracking(
      ColorScheme colorScheme, bool isDark, TextStyle? textTheme) {
    return _buildAnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Progress Tracking', colorScheme, textTheme),
          const SizedBox(height: 16),
          _buildProgressItem(
            'Project 1',
            0.75,
            colorScheme.primary,
            colorScheme,
          ),
          const SizedBox(height: 12),
          _buildProgressItem(
            'Project 2',
            0.45,
            colorScheme.secondary,
            colorScheme,
          ),
        ],
      ),
      isDark: isDark,
    );
  }

  Widget _buildTaskManagement(
      ColorScheme colorScheme, bool isDark, TextStyle? textTheme) {
    return _buildAnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Task Management', colorScheme, textTheme),
          const SizedBox(height: 16),
          _buildTaskItem(
            'Task 1',
            'In Progress',
            'Developer A',
            colorScheme.primary,
            colorScheme,
          ),
          const SizedBox(height: 8),
          _buildTaskItem(
            'Task 2',
            'Pending',
            'Developer B',
            colorScheme.secondary,
            colorScheme,
          ),
        ],
      ),
      isDark: isDark,
    );
  }

  Widget _buildPaymentsSection(
      ColorScheme colorScheme, bool isDark, TextStyle? textTheme) {
    return _buildAnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Payments Tracking', colorScheme, textTheme),
          const SizedBox(height: 16),
          _buildPaymentItem(
            'Project 1',
            'Paid',
            'One-Time Payment',
            colorScheme.secondary,
            colorScheme,
          ),
          const SizedBox(height: 8),
          _buildPaymentItem(
            'Project 2',
            'Pending',
            'Recurring Payment',
            colorScheme.primary,
            colorScheme,
          ),
        ],
      ),
      isDark: isDark,
    );
  }

  Widget _buildFinancialSummary(
      ColorScheme colorScheme, bool isDark, TextStyle? textTheme) {
    return _buildAnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Financial Summary', colorScheme, textTheme),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildFinancialCard('To Collect', '\$15,000', colorScheme.error,
                  colorScheme, textTheme),
              _buildFinancialCard('Collected', '\$10,000',
                  colorScheme.secondary, colorScheme, textTheme),
              _buildFinancialCard('Total', '\$25,000', colorScheme.primary,
                  colorScheme, textTheme),
            ],
          ),
        ],
      ),
      isDark: isDark,
    );
  }

  Widget _buildTeamCollaboration(
      ColorScheme colorScheme, bool isDark, TextStyle? textTheme) {
    return _buildAnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Team Collaboration', colorScheme, textTheme),
          const SizedBox(height: 16),
          _buildTeamMember(
            'Developer A',
            'Active',
            'Project 1',
            colorScheme.primary,
            colorScheme,
          ),
          const SizedBox(height: 8),
          _buildTeamMember(
            'Developer B',
            'Active',
            'Project 2',
            colorScheme.secondary,
            colorScheme,
          ),
        ],
      ),
      isDark: isDark,
    );
  }

  Widget _buildHistoryAndUpdates(
      ColorScheme colorScheme, bool isDark, TextStyle? textTheme) {
    return _buildAnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('History & Updates', colorScheme, textTheme),
          const SizedBox(height: 16),
          _buildHistoryItem(
            'Task 1 Updated',
            '2 hours ago',
            'Developer A added a comment',
            colorScheme.primary,
            colorScheme,
            textTheme,
          ),
          const SizedBox(height: 8),
          _buildHistoryItem(
            'Payment Confirmed',
            '4 hours ago',
            'Project 1 payment received',
            colorScheme.secondary,
            colorScheme,
            textTheme,
          ),
        ],
      ),
      isDark: isDark,
    );
  }

  // Helper Widgets
  Widget _buildSectionTitle(
      String title, ColorScheme colorScheme, TextStyle? textTheme) {
    return Text(
      title,
      style: textTheme!.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
    );
  }

  Widget _buildAnimatedCard({required Widget child, required bool isDark}) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0.95, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? const Color.fromARGB(255, 14, 14, 14)
                : Colors.white, // Background color
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: child,
          ),
        ),
      ),
      child: child,
    );
  }

  Widget _buildStatusCard(String status, Color color, int count,
      ColorScheme colorScheme, TextStyle? textTheme) {
    return Container(
      // width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        // color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            status,

            style: textTheme!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
            // overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(
      String title, double value, Color color, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          tween: Tween<double>(begin: 0, end: value),
          builder: (context, value, _) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(String task, String status, String assignee,
      Color color, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.task_alt, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  '$status - Assigned to $assignee',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: colorScheme.onSurface.withOpacity(0.5),
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(String project, String status, String type,
      Color color, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.payment, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$project - $status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialCard(String label, String amount, Color color,
      ColorScheme colorScheme, TextStyle? textTheme) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: textTheme!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: textTheme.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String status, String project,
      Color color, ColorScheme colorScheme) {
    return Container(
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
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name - $status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Assigned to $project',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: status == 'Active' ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String time, String description,
      Color color, ColorScheme colorScheme, TextStyle? textTheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.history, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: textTheme!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      time,
                      style: textTheme.copyWith(
                        fontSize: 12,
                        color: colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: textTheme.copyWith(
                    fontSize: 14,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
