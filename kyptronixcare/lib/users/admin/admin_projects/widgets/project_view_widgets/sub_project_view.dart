import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

class ProjectThemeColors {
  // Refined color palette that works well in both light and dark modes
  static final List<Color> projectColors = [
    const Color(0xFF00796B), // Teal
    const Color(0xFF7E57C2), // Deep Purple
    const Color(0xFFFF6F61), // Coral
    const Color(0xFF388E3C), // Emerald Green
    const Color(0xFFFFB300), // Gold
    const Color(0xFF1976D2), // Royal Blue
    const Color(0xFFFF7043), // Burnt Orange
    const Color(0xFFDC143C), // Crimson Red
    const Color(0xFF4682B4), // Steel Blue
    const Color(0xFF708090), // Slate Gray
  ];

  // Get a color with good contrast for both light and dark modes
  static Color getAdaptiveColor(BuildContext context, Color baseColor) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode) {
      // For dark mode, lighten the color slightly
      return Color.lerp(baseColor, Colors.white, 0.2)!;
    } else {
      // For light mode, darken the color slightly
      return Color.lerp(baseColor, Colors.black, 0.2)!;
    }
  }

  // Generate a gradient based on the base color
  static List<Color> generateGradient(BuildContext context, Color baseColor) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (isDarkMode) {
      // Dark mode: Gradient will be lighter with reduced opacity
      return [baseColor.withOpacity(0.7), baseColor.withOpacity(0.5)];
    } else {
      // Light mode: Gradient will be more solid with lighter opacity
      return [baseColor, baseColor.withOpacity(0.7)];
    }
  }
}

class ProjectTestModel {
  final String title;
  final String description;
  final String? imagePath;
  final Color primaryColor;

  ProjectTestModel({
    required this.title,
    required this.description,
    this.imagePath,
    required int index, // Add an index to select the color from the array
  }) : primaryColor = ProjectThemeColors.projectColors[index %
            ProjectThemeColors
                .projectColors.length]; // Cycles through the colors
}

class ProjectsPage extends StatelessWidget {
  final List<ProjectTestModel> projects;

  const ProjectsPage({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    // Define background colors for different modes
    // Color backgroundColor = Theme.of(context).brightness == Brightness.dark
    //     ? const Color(0xFF1F1D2B)
    //     : const Color(0xFFF3F3F8);

    return Scaffold(
      // backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: projects.isEmpty
            ? _buildEmptyState(context)
            : ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return _buildProjectCard(context, projects[index]);
                },
              ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, ProjectTestModel project) {
    // Adaptive color handling
    Color adaptiveColor =
        ProjectThemeColors.getAdaptiveColor(context, project.primaryColor);
    List<Color> gradientColors =
        ProjectThemeColors.generateGradient(context, project.primaryColor);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: adaptiveColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showProjectDetails(context, project);
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                _buildProjectIcon(context, project),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectIcon(BuildContext context, ProjectTestModel project) {
    // Flexible icon/image handling
    if (project.imagePath != null) {
      return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(project.imagePath!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // Fallback to first letters of project title if no image
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          project.title.substring(0, 2).toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showProjectDetails(BuildContext context, ProjectTestModel project) {
    // Example of a modal bottom sheet for project details
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF2C2B3A)
          : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              project.description,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 100,
            color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No projects found',
            style: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
