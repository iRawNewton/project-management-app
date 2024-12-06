import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kyptronixcare/users/admin/admin_projects/widgets/project_view_widgets/add_members_dialog.dart';

import '../../../../model/user_model.dart';
import 'animate_card.dart';
import 'color_palette.dart';
import 'section_card.dart';

class TeamTab extends StatefulWidget {
  final bool isDark;
  final List<UserModel> developersDetails, managerDetails;
  final String projectId;

  const TeamTab({
    super.key,
    required this.isDark,
    required this.developersDetails,
    required this.managerDetails,
    required this.projectId,
  });

  @override
  State<TeamTab> createState() => _TeamTabState();
}

class _TeamTabState extends State<TeamTab> {
  // final TextEditingController _clientId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AnimateCard(
          child: SectionCard(
            isDark: widget.isDark,
            title: 'Project Manager',
            icon: Icons.person,
            iconColor: widget.isDark
                ? ColorPalette.darkAccent2
                : ColorPalette.lightAccent2,
            customWidget: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddMembersDialog(
                      isDarkMode: widget.isDark,
                      role: 'Manager',
                      projectID: widget.projectId,
                    );
                  },
                ).then((result) {
                  if (result != null) {
                    // Handle the added developer
                    // print('Added Developer: $result');
                  }
                });
              },
              icon: const Icon(Icons.add),
            ),
            /*  child: _buildTeamMember(
              name: 'John Doe',
              role: 'Project Manager',
              color: widget.isDark
                  ? ColorPalette.darkAccent2
                  : ColorPalette.lightAccent2,
            ), */
            child: (widget.managerDetails.isEmpty)
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Unfortunately, no manager has been assigned yet.',
                        style: theme.textTheme.bodyLarge!.copyWith(),
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.managerDetails.length,
                    itemBuilder: (context, index) {
                      return _buildTeamMember(
                        name: widget.managerDetails[index].name,
                        role: 'Project Manager',
                        color: widget.isDark
                            ? ColorPalette.darkAccent2
                            : ColorPalette.lightAccent2,
                      );
                    },
                  ),
          ),
        ),
        const SizedBox(height: 16),
        AnimateCard(
          child: SectionCard(
            isDark: widget.isDark,
            title: 'Team Members',
            icon: Icons.groups,
            iconColor: widget.isDark
                ? ColorPalette.darkAccent3
                : ColorPalette.lightAccent3,
            customWidget: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddMembersDialog(
                      isDarkMode: widget.isDark,
                      role: 'Developer',
                      projectID: widget.projectId,
                    );
                  },
                ).then((result) {
                  if (result != null) {
                    // Handle the added developer
                    print('Added Developer: $result');
                  }
                });
              },
              icon: const Icon(Icons.add),
            ),
            child: (widget.developersDetails.isEmpty)
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Unfortunately, no Developer has been assigned yet.',
                        style: theme.textTheme.bodyLarge!.copyWith(),
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.developersDetails.length,
                    itemBuilder: (context, index) {
                      return _buildTeamMember(
                        name: widget.developersDetails[index].name,
                        role: 'Developer',
                        color: widget.isDark
                            ? ColorPalette.darkAccent2
                            : ColorPalette.lightAccent2,
                      );
                    },
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
}
