import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kyptronixcare/users/admin/admin_projects/widgets/project_view_widgets/glass_container.dart';
import 'package:kyptronixcare/users/admin/admin_projects/widgets/project_view_widgets/overview_tab.dart';
import 'package:kyptronixcare/users/admin/admin_projects/widgets/project_view_widgets/tasks_tab.dart';
import 'package:kyptronixcare/users/admin/admin_projects/widgets/project_view_widgets/team_tab.dart';
import '../../../model/projects_model.dart';
import '../widgets/project_view_widgets/color_palette.dart';
import '../widgets/project_view_widgets/convert_project_type.dart';
import '../widgets/project_view_widgets/finance_tab.dart';
import '../widgets/project_view_widgets/sub_project_view.dart';

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

    // Set the initial tab index to 2 (third tab)
    // _tabController.index = 2;
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
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
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
                          GlassContainer(
                            child: Text(
                              widget.project.id,
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GlassContainer(
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
                                const Gap(12.0),
                                GlassContainer(
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
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
              widget.project.subProjects!.isEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          ConvertProjectType(
                            currentProjectType: 'Single Project Type',
                            onConversionConfirmed: _handleConversion,
                            projectModel: widget.project,
                          ),
                          OverviewTab(isDark: isDark, project: widget.project),
                        ],
                      ),
                    )
                  // : OverviewTab(isDark: isDark, project: widget.project),

                  : ProjectsPage(
                      projects: [
                        ProjectTestModel(
                          title: 'Project Alpha',
                          description: 'AI-powered solution for automation.',
                          index: 0,
                          // imagePath:
                          //     'assets/project_alpha_icon.png', // Optional
                        ),
                        ProjectTestModel(
                          title: 'Project Beta',
                          description: 'Blockchain-based secure system.',
                          index: 1,
                        ),
                        ProjectTestModel(
                          title: 'Project Gamma',
                          description: 'IoT solution for smart devices.',
                          index: 2,
                        ),
                      ],
                    ),
              TeamTab(
                isDark: isDark,
                developersDetails: widget.project.developersDetails,
                managerDetails: widget.project.managersDetails,
                projectId: widget.project.id,
              ),
              TasksTab(isDark: isDark),
              FinanceTab(isDark: isDark),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor:
            isDark ? ColorPalette.darkAccent1 : ColorPalette.lightAccent1,
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }

  void _handleConversion(bool confirmed) {
    if (confirmed) {
      // Logic for converting to multiple project types
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Project converted to multiple types'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conversion cancelled'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
