import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyptronixcare/users/dev/dashboard/presentation/dev_dashboard.dart';

import '../../../users/admin/admin_authentication/presentation/admin_login.dart';
import '../../../users/client/dashboard/presentation/client_dashboard.dart';

class UserRoleSelector extends StatefulWidget {
  const UserRoleSelector({super.key});

  @override
  State<UserRoleSelector> createState() => _UserRoleSelectorState();
}

class _UserRoleSelectorState extends State<UserRoleSelector> {
  String? selectedRole;

  final List<Map<String, dynamic>> roles = [
    {
      'title': 'Admin',
      'icon': Icons.admin_panel_settings,
      'colors': [
        const Color(0xFFC33764),
        const Color(0xFF1D2671),
      ], // Admin colors
    },
    {
      'title': 'Manager',
      'icon': Icons.manage_accounts,
      'colors': [
        const Color(0xFF02AABD),
        const Color(0xFF00CDAC),
      ], // Manager colors
    },
    {
      'title': 'Client',
      'icon': Icons.person,
      'colors': [
        const Color(0xFFFF512F),
        const Color(0xFFDD2476),
      ], // Client colors
    },
    {
      'title': 'Developer',
      'icon': Icons.code,
      'colors': [
        const Color(0xFF2E3192),
        const Color(0xFF1BFFFF),
      ], // Developer colors
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[800] : Colors.white;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Your Role',
          style: textTheme.bodyLarge!.copyWith(
            fontSize: 24.0,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select your role',
                style: textTheme.headlineLarge!
                    .copyWith(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const Gap(24.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: roles.length,
                  itemBuilder: (context, index) {
                    return _buildRoleCard(
                        roles[index], Colors.white, cardColor ?? Colors.white);
                  },
                ),
              ),
              const Gap(24.0),
              ElevatedButton(
                onPressed: selectedRole != null
                    ? () {
                        if (selectedRole == "Developer") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DevDashboardPage(),
                            ),
                          );
                        } else if (selectedRole == "Admin") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminLogin()));
                        } else if (selectedRole == "Client") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ClientDashboard(),
                            ),
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Next',
                    style: textTheme.bodyLarge!.copyWith(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
      Map<String, dynamic> role, Color selectedColor, Color cardColor) {
    final isSelected = selectedRole == role['title'];
    final List<Color> roleColors = role['colors'] != null
        ? List<Color>.from(role['colors'] as List<dynamic>)
        : [Colors.grey, Colors.grey]; // Default colors if none provided

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role['title'];
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: roleColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? cardColor : cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.white38 : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.3 : 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              role['icon'],
              size: 48,
              color: isSelected
                  ? selectedColor
                  : (cardColor.computeLuminance() > 0.5
                      ? Colors.grey[700]
                      : Colors.grey[400]),
            ),
            const SizedBox(height: 8),
            Text(
              role['title'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? selectedColor
                    : (cardColor.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
