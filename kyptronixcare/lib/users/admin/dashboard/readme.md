---

### **Admin Dashboard Content:**

1. **Project Overview**
   - **Total Projects**: The total number of all projects (active, paused, completed).
   - **Projects Pending**: Number of projects that haven't started yet or are pending client approval.
   - **Ongoing Projects**: Number of currently active projects.
   - **Paused Projects**: Number of projects that have been paused.
   - **Completed Projects**: Number of projects that have been successfully completed.
   - **Project Progress**: Visual progress indicator (e.g., bar chart or percentage) showing overall project progress.

2. **Manager Performance**
   - **Projects Managed**: Number of projects assigned to each manager.
   - **Ongoing Projects per Manager**: Breakdown of ongoing projects by manager.
   - **Collection for the Current Month**: Payment received or tracked for each manager’s projects in the current month.
   - **Task Completion Rate**: Number of tasks completed under each manager’s supervision.

3. **Developer Activity**
   - **Total Developers**: Number of developers currently working on projects.
   - **Active Developers**: Number of developers with active tasks.
   - **Daily Task Reports**: View of daily task reports submitted by developers.
   - **Task Progress**: Overview of tasks assigned to developers and their completion rate.

4. **Client Overview**
   - **Total Clients**: Number of clients using the platform.
   - **Active Clients**: Clients with ongoing projects.
   - **Clients Pending First Login**: Clients who haven’t downloaded or logged in to the app yet.

5. **Financial Summary**
   - **Total Payment Tracked**: The total amount of payments received across all projects.
   - **Monthly Payment Summary**: Payments received this month, broken down by project or client.
   - **Outstanding Payments**: Clients with overdue or pending payments.
   - **Payment Breakdown**: Show the type of payment (one-time or monthly) for each project.

6. **Notifications & Alerts**
   - **Unread Notifications**: Number of unread notifications.
   - **Emergency Tasks**: List of emergency tasks assigned to developers.

7. **Remarks & Updates**
   - **Latest Remarks**: Recent remarks added by developers, managers, or clients.
   - **Remark Status**: Number of unresolved or pending remarks.
   - **Project Remarks History**: List of remarks added on specific projects.

8. **History & Logs**
   - **Activity Logs**: Recent user activities (logins, task assignments, project updates).
   - **Task and Project History**: History of completed tasks and projects.

---


  Widget _buildProjectProgress() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Project Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = 'Q1';
                              break;
                            case 1:
                              text = 'Q2';
                              break;
                            case 2:
                              text = 'Q3';
                              break;
                            case 3:
                              text = 'Q4';
                              break;
                            default:
                              text = '';
                          }
                          return Text(text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ));
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          String text;
                          if (value == 0) {
                            text = '0%';
                          } else if (value == 50) {
                            text = '50%';
                          } else if (value == 100) {
                            text = '100%';
                          } else {
                            return Container();
                          }
                          return Text(text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ));
                        },
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _buildBarGroup(0, 65),
                    _buildBarGroup(1, 80),
                    _buildBarGroup(2, 45),
                    _buildBarGroup(3, 90),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.blue,
          width: 22,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
