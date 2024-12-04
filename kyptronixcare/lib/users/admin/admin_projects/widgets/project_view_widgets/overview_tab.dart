import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyptronixcare/users/admin/admin_projects/widgets/project_view_widgets/progress_section.dart';
import 'package:kyptronixcare/users/admin/admin_projects/widgets/project_view_widgets/project_links.dart';
import 'package:kyptronixcare/users/admin/admin_projects/widgets/project_view_widgets/tags_section.dart';

import '../../../../model/projects_model.dart';
import 'animate_card.dart';
import 'color_palette.dart';
import 'section_card.dart';

class OverviewTab extends StatelessWidget {
  final bool isDark;
  final ProjectModel project;
  const OverviewTab({super.key, required this.isDark, required this.project});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimateCard(
            child: SectionCard(
              isDark: isDark,
              title: 'Project Description',
              icon: Icons.description,
              iconColor:
                  isDark ? ColorPalette.darkAccent1 : ColorPalette.lightAccent1,
              child: Text(
                project.description,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimateCard(
            child: ProgressSection(isDark: isDark, project: project),
          ),
          const SizedBox(height: 16),
          const AnimateCard(
            child: ProjectLinks(
              demoUrl: 'www.google.com',
              githubUrl: 'github.com',
              liveUrl: 'google.com',
            ),
          ),
          const SizedBox(height: 16),
          const AnimateCard(
            child: TagsSection(tags: ['Flutter', 'Web Development']),
          ),
        ],
      ),
    );
  }
}
