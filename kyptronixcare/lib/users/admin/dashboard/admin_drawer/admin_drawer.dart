import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyptronixcare/users/admin/admin_add_role/presentation/add_role.dart';

import '../../../../core/themes/theme_cubit.dart';
import '../../admin_accounts/presentation/admin_list.dart';
import '../../admin_client/presentation/admin_client_listview.dart';
import '../../admin_developers/presentation/admin_developers.dart';
import '../../admin_managers/presentation/admin_manager_listview.dart';
import '../../admin_projects/presentation/admin_project_listview.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).colorScheme.onSurface;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // _buildHeader(context, textTheme),
          const Gap(20.0),
          SizedBox(
            height: 160.0,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 40.0,
                    // backgroundImage:
                    //     NetworkImage('https://via.placeholder.com/150'),
                  ),
                  const Gap(8.0),
                  Text(
                    'Good Morning,\nAdmin',
                    style: textTheme.bodyLarge!.copyWith(),
                  ),
                ],
              ),
            ),
          ),
          // const Divider(),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.dashboard,
            text: 'Dashboard',
            iconColor: iconColor,
            onTap: () => _onItemTapped(context, 'Dashboard'),
          ),
          _buildDrawerItem(
            icon: Icons.supervisor_account,
            text: 'Managers',
            iconColor: iconColor,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminManagerListview(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.code,
            text: 'Development Team',
            iconColor: iconColor,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DevelopersPage(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.groups,
            text: 'Clients',
            iconColor: iconColor,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminClientListview(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.mail,
            text: 'New Sales',
            iconColor: iconColor,
            onTap: () => _onItemTapped(context, 'New Sales'),
          ),
          _buildDrawerItem(
            icon: Icons.message,
            text: 'Projects',
            iconColor: iconColor,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (context) => const AdminCreateProject(),
                  builder: (context) => const AdminProjectListview(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.account_circle,
            text: 'Daily Tasks',
            iconColor: iconColor,
            onTap: () => _onItemTapped(context, 'Daily Tasks'),
          ),
          _buildDrawerItem(
            icon: Icons.chat,
            text: 'Chat',
            iconColor: iconColor,
            onTap: () => _onItemTapped(context, 'Chat'),
          ),
          _buildDrawerItem(
            icon: Icons.email,
            text: 'Email',
            iconColor: iconColor,
            onTap: () => _onItemTapped(context, 'Email'),
          ),
          _buildDrawerItem(
            icon: Icons.campaign,
            text: 'Broadcast',
            iconColor: iconColor,
            onTap: () => _onItemTapped(context, 'Broadcast'),
          ),
          _buildDrawerItem(
            icon: Icons.campaign,
            text: 'Add Role',
            iconColor: iconColor,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddRole(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.dark_mode,
            text: 'Dark Mode',
            iconColor: iconColor,
            trailing: const CustomAdvanceSwitch(),
          ),
          _buildDrawerItem(
            icon: Icons.person_add,
            text: 'Add Admin',
            iconColor: iconColor,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminList(),
                ),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            iconColor: iconColor,
            onTap: () => _onItemTapped(context, 'Logout'),
          ),
        ],
      ),
    );
  }

/*
  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40.0,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const Gap(8.0),
          Text(
            'Good Morning,\nGaurab',
            style: textTheme.bodyLarge!.copyWith(),
          ),
        ],
      ),
    );
  }
*/

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required Color iconColor,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text),
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _onItemTapped(BuildContext context, String title) {
    // Handle navigation logic here
    Navigator.pop(context);
  }
}

class CustomAdvanceSwitch extends StatefulWidget {
  const CustomAdvanceSwitch({super.key});

  @override
  State<CustomAdvanceSwitch> createState() => _CustomAdvanceSwitchState();
}

class _CustomAdvanceSwitchState extends State<CustomAdvanceSwitch> {
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return AdvancedSwitch(
      activeColor: colorScheme.primary,
      inactiveColor: Colors.grey,
      activeChild: const Text('ON'),
      inactiveChild: const Text('OFF'),
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      width: 60.0,
      height: 28.0,
      thumb: Container(
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      controller: _controller,
      onChanged: (value) {
        _controller.value = value; // Update the controller value
        themeCubit.toggleTheme(); // Toggle the theme
      },
    );
  }
}
