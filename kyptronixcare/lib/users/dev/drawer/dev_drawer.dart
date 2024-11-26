import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyptronixcare/core/themes/theme_cubit.dart';

class DevDrawer extends StatelessWidget {
  const DevDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: ListView(
        children: [
          const Gap(40.0),
          SizedBox(
            height: 160.0,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 50.0,
                  ),
                  const Gap(12.0),
                  Text(
                    'Good Morning,\nGaurab',
                    style: textTheme.bodyLarge!.copyWith(),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          const ListTile(
            leading: Icon(Icons.task),
            title: Text('Projects'),
          ),
          const ListTile(
            leading: Icon(Icons.mail),
            title: Text('Email'),
          ),
          const ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          const ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          const ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
            trailing: CustomAdvanceSwitch(),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}

class CustomAdvanceSwitch extends StatefulWidget {
  final Widget? activeChild;
  final Widget? inactiveChild;

  const CustomAdvanceSwitch({
    super.key,
    this.activeChild,
    this.inactiveChild,
  });

  @override
  State<CustomAdvanceSwitch> createState() => _CustomAdvanceSwitchState();
}

class _CustomAdvanceSwitchState extends State<CustomAdvanceSwitch> {
  final _controller00 = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    final colorScheme = Theme.of(context).colorScheme;
    return AdvancedSwitch(
      activeColor: colorScheme.primary,
      inactiveColor: const Color(0xFF292929),
      activeChild: widget.activeChild ?? const Text('ON'),
      inactiveChild: widget.inactiveChild ?? const Text('OFF'),
      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
      width: 70.0,
      height: 30.0,
      thumb: Container(
        margin: const EdgeInsets.all(5),
        height: 24.0,
        width: 24.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onChanged: (value) {
        _controller00.value = value; // Update the controller value
        themeCubit.toggleTheme(); // Toggle the theme
      },
      controller: _controller00,
    );
  }
}
