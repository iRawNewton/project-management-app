import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../model/projects_model.dart';
import 'admin_project_listview.dart';

// import '../widgets/sub_project_view.dart';

class ColorPalette {
  // Light Theme Colors
  static const lightPrimaryGradientStart = Color(0xFF4158D0);
  static const lightPrimaryGradientMiddle = Color(0xFFC850C0);
  static const lightPrimaryGradientEnd = Color(0xFFFFCC70);
  static const lightAccent1 = Color(0xFF00B4DB);
  static const lightAccent2 = Color(0xFF0083B0);
  static const lightAccent3 = Color(0xFFFF6B6B);
  static const lightSuccess = Color(0xFF48C9B0);
  static const lightWarning = Color(0xFFF4D03F);
  static const lightError = Color(0xFFE74C3C);
  static const lightCardBg1 = Color(0xFFF8F9FE);
  static const lightCardBg2 = Color(0xFFF2F5FF);
  static const lightTextPrimary = Color(0xFF000000);

  // Dark Theme Colors
  static const darkPrimaryGradientStart = Color(0xFF2A3157);
  static const darkPrimaryGradientMiddle = Color(0xFF9B3B9B);
  static const darkPrimaryGradientEnd = Color(0xFFCC9E50);
  static const darkAccent1 = Color(0xFF0090B0);
  static const darkAccent2 = Color(0xFF006A8F);
  static const darkAccent3 = Color(0xFFFF4F4F);
  static const darkSuccess = Color(0xFF2EAF94);
  static const darkWarning = Color(0xFFD4B32F);
  static const darkError = Color(0xFFCF3C2D);
  static const darkCardBg1 = Color(0xFF1E1E2E);
  static const darkCardBg2 = Color(0xFF2A2A3A);
  static const darkTextPrimary = Color(0xFFFFFFFF);

  static Color getCardBg1(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightCardBg1
        : darkCardBg1;
  }

  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightTextPrimary
        : darkTextPrimary;
  }
}

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key, required this.project});
  final ProjectModel project;
  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 140 && !_showAppBarTitle) {
      setState(() => _showAppBarTitle = true);
    } else if (_scrollController.offset <= 140 && _showAppBarTitle) {
      setState(() => _showAppBarTitle = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? ColorPalette.darkCardBg1 : ColorPalette.lightCardBg1,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: AnimatedOpacity(
                opacity: _showAppBarTitle ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  '',
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            ColorPalette.darkPrimaryGradientStart,
                            ColorPalette.darkPrimaryGradientMiddle,
                            ColorPalette.darkPrimaryGradientEnd,
                          ]
                        : [
                            ColorPalette.lightPrimaryGradientStart,
                            ColorPalette.lightPrimaryGradientMiddle,
                            ColorPalette.lightPrimaryGradientEnd,
                          ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      top: -30,
                      right: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: -50,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildGlassContainer(
                            child: Text(
                              widget.project.projectName,
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildGlassContainer(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        color: Colors.white, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      // 'Jan 2024 - Dec 2024',
                                      '${DateFormat('MMM yyyy').format(widget.project.startDate!.toDate())}'
                                      ' - '
                                      '${DateFormat('MMM yyyy').format(widget.project.endDate!.toDate())}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              _buildGlassContainer(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.link,
                                        color: Colors.white, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Visit Project',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Team'),
                Tab(text: 'Tasks'),
                Tab(text: 'Finances'),
              ],
            ),
          ),
        ],
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      ColorPalette.darkCardBg1,
                      ColorPalette.darkCardBg2,
                    ]
                  : [
                      ColorPalette.lightCardBg1,
                      ColorPalette.lightCardBg2,
                    ],
            ),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(isDark),
              // ProjectsPage(),
              _buildTeamTab(isDark),
              _buildTasksTab(isDark),
              _buildFinancesTab(isDark),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const ImprovedProjectFormPage()));
        },
        backgroundColor:
            isDark ? ColorPalette.darkAccent1 : ColorPalette.lightAccent1,
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }

  Widget _buildGlassContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: child,
    );
  }

  Widget _buildOverviewTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedCard(
            child: _buildSectionCard(
              isDark: isDark,
              title: 'Project Description',
              icon: Icons.description,
              iconColor:
                  isDark ? ColorPalette.darkAccent1 : ColorPalette.lightAccent1,
              child: Text(
                'This is the project description. It provides a detailed overview of the project\'s purpose and goals.',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildAnimatedCard(
            child: _buildProgressSection(isDark),
          ),
          const SizedBox(height: 16),
          _buildAnimatedCard(
            child: _buildProjectLinks(
              demoUrl: 'www.google.com',
              githubUrl: 'github.com',
              liveUrl: 'google.com',
            ),
          ),
          const SizedBox(height: 16),
          _buildAnimatedCard(
            child: _buildTagsSection(['Flutter', 'Web Development']),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection(List<String>? tags) {
    if (tags == null || tags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: tags.map((tag) => _buildTag(tag)).toList(),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.blue[700],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProjectLinks({
    String? githubUrl,
    String? liveUrl,
    String? demoUrl,
  }) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: [
        if (githubUrl != null)
          _buildLinkButton(
            url: githubUrl,
            icon: FontAwesomeIcons.github,
            label: 'Source Code',
          ),
        if (liveUrl != null)
          _buildLinkButton(
            url: liveUrl,
            icon: Icons.public,
            label: 'Live Site',
          ),
        if (demoUrl != null)
          _buildLinkButton(
            url: demoUrl,
            icon: Icons.play_circle_outline,
            label: 'Live Demo',
          ),
      ],
    );
  }

  Widget _buildLinkButton({
    required String url,
    required IconData icon,
    required String label,
  }) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
  }) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildAnimatedCard(
          child: _buildSectionCard(
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
        _buildAnimatedCard(
          child: _buildSectionCard(
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

  Widget _buildTasksTab(isDark) {
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
      itemBuilder: (context, index) => _buildAnimatedCard(
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

  Widget _buildFinancesTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildAnimatedCard(
          child: _buildSectionCard(
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
        _buildAnimatedCard(
          child: _buildSectionCard(
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

/* 
  Widget _buildSectionCard({
    required String title,
    required Widget child,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
 */
  Widget _buildProgressSection(bool isDark) {
    return _buildSectionCard(
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

  Widget _buildAnimatedCard({required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
/*
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildProjectLinks({
  String? githubUrl,
  String? liveUrl,
  String? demoUrl,
}) {
  return Wrap(
    spacing: 16.0,
    runSpacing: 8.0,
    children: [
      if (githubUrl != null)
        _buildLinkButton(
          url: githubUrl,
          icon: FontAwesomeIcons.github,
          label: 'Source Code',
        ),
      if (liveUrl != null)
        _buildLinkButton(
          url: liveUrl,
          icon: Icons.public,
          label: 'Live Site',
        ),
      if (demoUrl != null)
        _buildLinkButton(
          url: demoUrl,
          icon: Icons.play_circle_outline,
          label: 'Live Demo',
        ),
    ],
  );
}

Widget _buildLinkButton({
  required String url,
  required IconData icon,
  required String label,
}) {
  return InkWell(
    onTap: () async {
      if (await canLaunch(url)) {
        await launch(url);
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildTagsSection(List<String>? tags) {
  if (tags == null || tags.isEmpty) return const SizedBox.shrink();

  return Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    children: tags.map((tag) => _buildTag(tag)).toList(),
  );
}

Widget _buildTag(String tag) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.blue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      tag,
      style: TextStyle(
        color: Colors.blue[700],
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
*/

