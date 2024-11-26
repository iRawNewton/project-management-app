import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyptronixcare/core/widgets/custom_divider.dart';
import 'package:kyptronixcare/users/admin/dashboard/widgets/admin_header.dart';
import 'package:kyptronixcare/users/admin/dashboard/widgets/admin_missed_payments.dart';
import 'package:kyptronixcare/users/admin/dashboard/widgets/admin_payment_history.dart';
import 'package:kyptronixcare/users/admin/dashboard/widgets/admin_payment_status.dart';

import '../../../../core/constants/app_constants.dart';
import '../admin_drawer/admin_drawer.dart';
import '../widgets/admin_finance_chart.dart';
import '../widgets/admin_manager_stats.dart';
import '../widgets/admin_project_stats_card.dart';
import '../widgets/admin_search_textfield.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final CardColors cardColors = CardColors();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const AdminDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(20.0),

              /* ---------------------------- Dashboard Header ---------------------------- */
              AdminDashboardHeader(
                textTheme: textTheme,
                colorScheme: colorScheme,
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),

              /* ------------------------------- Search bar ------------------------------- */
              const Gap(24.0),
              const AdminSearchTextField(),

              /* ------------------------------- Your Stats ------------------------------- */
              const Gap(28.0),
              const CustomDivider(title: 'Project Stats'),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdminProjectStatsCard(
                        title: 'Pending',
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        gradientColors: cardColors.pending,
                        icon: Icons.hourglass_empty,
                        count: '5',
                      ),
                      AdminProjectStatsCard(
                        title: 'Ongoing',
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        gradientColors: cardColors.ongoing,
                        icon: Icons.sync,
                        count: '5',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdminProjectStatsCard(
                        title: 'Approval',
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        gradientColors: cardColors.approval,
                        icon: Icons.check_box,
                        count: '5',
                      ),
                      AdminProjectStatsCard(
                        title: 'Completed',
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        gradientColors: cardColors.completed,
                        icon: Icons.done_all,
                        count: '5',
                      ),
                    ],
                  ),
                  AdminProjectStatsCard(
                    title: 'Paused',
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    width: MediaQuery.sizeOf(context).width,
                    gradientColors: cardColors.paused,
                    icon: Icons.pause,
                    count: '5',
                  ),
                ],
              ),

              /* --------------------------- Manager Performance -------------------------- */
              const Gap(24.0),
              const CustomDivider(title: 'Manager Performance'),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ManagerPerformanceCard(
                      managerName: 'John Doe',
                      projectsManaged: 5,
                      ongoingProjects: ['Project A', 'Project B', 'Project C'],
                      gradientColor: [Color(0xFF6717CD), Color(0xFF296FF9)],
                      currentMonthCollection: 25000.50,
                    ),
                    ManagerPerformanceCard(
                      managerName: 'John Doe',
                      projectsManaged: 5,
                      ongoingProjects: ['Project A', 'Project B', 'Project C'],
                      gradientColor: [Color(0xFF6717CD), Color(0xFF296FF9)],
                      currentMonthCollection: 25000.50,
                    ),
                    ManagerPerformanceCard(
                      managerName: 'John Doe',
                      projectsManaged: 5,
                      ongoingProjects: ['Project A', 'Project B', 'Project C'],
                      gradientColor: [Color(0xFFF237EF), Color(0xFFFC5252)],
                      currentMonthCollection: 25000.50,
                    ),
                  ],
                ),
              ),
              const Gap(24.0),

              const CustomDivider(title: 'Financial Summary'),
              AdminPaymentStatus(
                  textTheme: textTheme, colorScheme: colorScheme),

              // Financial Chart
              const Gap(24.0),
              const CustomDivider(title: 'Quaterly Performance'),
              const FinancesChart(
                earnings: [
                  5000,
                  7500,
                  8000,
                  5000
                ], // Replace with your earnings data
              ),

              // Payment History Section
              const Gap(24.0),
              const CustomDivider(title: 'Payment History'),
              const AdminPaymentHistory(),

              // Revenue Reports Section
              const Gap(24.0),
              _buildRevenueReportsSection(),

              // Missed Payments Section
              const Gap(24.0),
              const CustomDivider(title: 'Missed Payments'),
              const AdminMissedPayments(),
              const Gap(12.0),
            ],
          ),
        ),
      ),
    );
  }

  // Revenue Reports Section
  Widget _buildRevenueReportsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Revenue Reports',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.analytics),
            label: const Text('Generate Report'),
            onPressed: () {
              // Logic to generate report
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
