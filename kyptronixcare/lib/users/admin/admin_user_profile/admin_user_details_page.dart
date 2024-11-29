import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:kyptronixcare/core/widgets/custom_appbar.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage>
    with SingleTickerProviderStateMixin {
  bool showPassword = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Color Palette
  // final Color _primaryColor = const Color(0xFF6A5ACD); // Slate Blue
  // final Color _accentColor = const Color(0xFFFF6B6B); // Pastel Red
  // final Color _backgroundColor = const Color(0xFFF4F4F8); // Soft Lavender
  // final Color _darkBackgroundColor =
  //     const Color(0xFF1E1E2C); // Dark Midnight Blue

  final Color _primaryColor = Colors.white;
  final Color _accentColor = Colors.blue.shade900;
  final Color _backgroundColor = const Color(0xFFF9F9F9); // Soft Gray
  final Color _darkBackgroundColor = const Color(0xFF2C2C34); // Dark Charcoal

  // User details
  final String name = "John Doe";
  final String email = "john.doe@example.com";
  final String role = "Senior Manager";
  final String? profilePictureUrl = "https://via.placeholder.com/150";
  final List<String> assignedProjects = ["Project A", "Project B", "Project C"];
  final List<String> emergencyTasks = ["Task 1", "Task 2", "Task 3"];
  final String phone = "123-456-7890";
  final String whatsappNumber = "123-456-7890";
  final String password = "securePassword123";
  final String dateOfBirth = "1990-01-01";
  final String createdAt = "2024-01-01";
  final String updatedAt = "2024-11-28";

  @override
  void initState() {
    super.initState();
    // Setup animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuart,
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor =
        isDarkMode ? _darkBackgroundColor : _backgroundColor;
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform.scale(
            scale: 0.9 + (_animation.value * 0.1),
            child: Opacity(
              opacity: _animation.value,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    FadeIn(
                      child: const CustomAppbar(title: 'Profile'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Animated Profile Header
                          Center(
                            child: FadeInDown(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      _primaryColor.withOpacity(0.7),
                                      _accentColor.withOpacity(0.7),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _primaryColor.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(6),
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: profilePictureUrl ?? '',
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(
                                        color: _primaryColor,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.account_circle,
                                        size: 120,
                                        color: _primaryColor,
                                      ),
                                      fit: BoxFit.cover,
                                      width: 130,
                                      height: 130,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Animated Name and Role
                          Center(
                            child: FadeInUp(
                              child: Column(
                                children: [
                                  Text(
                                    name,
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      color: textColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    role,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.yellow.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Sections with Animated Entrance
                          _buildAnimatedSection(
                            "Personal Information",
                            _buildInfoCard(context, [
                              {
                                "label": "Email",
                                "value": email,
                                "icon": Icons.email
                              },
                              {
                                "label": "Phone",
                                "value": phone,
                                "icon": Icons.phone
                              },
                              {
                                "label": "WhatsApp",
                                "value": whatsappNumber,
                                "icon": Icons.chat
                              },
                              {
                                "label": "Date of Birth",
                                "value": dateOfBirth,
                                "icon": Icons.cake
                              },
                            ]),
                          ),

                          const SizedBox(height: 20),

                          _buildAnimatedSection(
                            "Account Details",
                            _buildInfoCard(context, [
                              {
                                "label": "Account Created",
                                "value": createdAt,
                                "icon": Icons.calendar_today
                              },
                              {
                                "label": "Last Updated",
                                "value": updatedAt,
                                "icon": Icons.update
                              },
                            ]),
                          ),

                          const SizedBox(height: 20),

                          _buildAnimatedSection(
                            "Assigned Projects",
                            _buildListCard(context, assignedProjects,
                                Icons.work, _primaryColor),
                          ),

                          const SizedBox(height: 20),

                          _buildAnimatedSection(
                            "Emergency Tasks",
                            _buildListCard(context, emergencyTasks,
                                Icons.warning, _accentColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Animated Section Builder
  Widget _buildAnimatedSection(String title, Widget content) {
    return FadeInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _primaryColor,
              ),
            ),
          ),
          content,
        ],
      ),
    );
  }

  // Information Card Widget
  Widget _buildInfoCard(
      BuildContext context, List<Map<String, dynamic>> items) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF296FF9).withOpacity(0.3),
            const Color(0xFF296FF9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: _primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Icon(
                        item['icon'],
                        color: _primaryColor,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['label'],
                              style: TextStyle(
                                color: _primaryColor.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              item['value'],
                              style: TextStyle(
                                color: _primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  // List Card Widget
  Widget _buildListCard(
      BuildContext context, List<String> items, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: items
            .map((item) => ListTile(
                  leading: Icon(icon, color: color),
                  title: Text(
                    item,
                    style: TextStyle(color: _primaryColor),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: color,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
