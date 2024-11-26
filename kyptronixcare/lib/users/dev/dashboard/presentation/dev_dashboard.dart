import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyptronixcare/core/constants/app_constants.dart';
import 'package:kyptronixcare/users/dev/dashboard/widgets/dashboard_header.dart';
import 'package:kyptronixcare/users/dev/dashboard/widgets/project_stats_card.dart';
import 'package:kyptronixcare/users/dev/drawer/dev_drawer.dart';

import '../widgets/project_card.dart';
import '../widgets/search_textfield.dart';

class DevDashboardPage extends StatefulWidget {
  const DevDashboardPage({super.key});

  @override
  State<DevDashboardPage> createState() => _DevDashboardPageState();
}

class _DevDashboardPageState extends State<DevDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final CardColors cardColors = CardColors();

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const DevDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(20.0),

              /* ---------------------------- Dashboard Header ---------------------------- */
              DevDashboardHeader(
                textTheme: textTheme,
                colorScheme: colorScheme,
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),

              /* ------------------------------- Search bar ------------------------------- */
              const Gap(24.0),
              const DevSearchTextField(),

              /* ------------------------------- Your Stats ------------------------------- */
              const Gap(28.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Text(
                      'Your Stats',
                      style: textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    const Gap(12.0),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProjectStatsCard(
                        title: 'Pending',
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        gradientColors: cardColors.pending,
                      ),
                      ProjectStatsCard(
                        title: 'Ongoing',
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        gradientColors: cardColors.ongoing,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProjectStatsCard(
                        title: 'Approval',
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        gradientColors: cardColors.approval,
                      ),
                      ProjectStatsCard(
                        title: 'Completed',
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        gradientColors: cardColors.completed,
                      ),
                    ],
                  ),
                  ProjectStatsCard(
                    title: 'Paused',
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    width: MediaQuery.sizeOf(context).width,
                    gradientColors: cardColors.paused,
                  ),
                ],
              ),

              /* ------------------------------ Projects List ----------------------------- */
              const Gap(20.0),
              /*
              In case of urgent action required in any project show this list
              or else don't show this.
              */
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Text(
                      '',
                      // 'Urgent Action Required',
                      style: textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    const Gap(12.0),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),

              /* ----------------------------- Recent Projects ---------------------------- */
              const Gap(20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Text(
                      'Projects',
                      style: textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    const Gap(12.0),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),
              ProjectSummaryCard(
                projectName: 'Project Alpha',
                category: 'Development',
                status: 'Ongoing',
                progress: 0.7,
                startDate: DateTime(2024, 1, 15),
                endDate: DateTime(2024, 12, 15),
                onDetailsPressed: () {
                  // Navigate to project details
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

// Color(0xFF2C62FF),
}
