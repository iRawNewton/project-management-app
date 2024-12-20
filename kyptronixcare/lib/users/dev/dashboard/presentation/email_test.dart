import 'dart:math';

import 'package:flutter/material.dart';

class DailyWorkReportScreen extends StatefulWidget {
  const DailyWorkReportScreen({super.key});

  @override
  State<DailyWorkReportScreen> createState() => _DailyWorkReportScreenState();
}

class _DailyWorkReportScreenState extends State<DailyWorkReportScreen> {
  TextEditingController tasksController = TextEditingController();
  TextEditingController planController = TextEditingController();
  TextEditingController challengesController = TextEditingController();
  TextEditingController complaintsController = TextEditingController();
  TextEditingController hoursController = TextEditingController();

  String selectedDate = "2024-12-19";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Work Report"),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Implement email sending logic here
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Section
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                title: const Text("Date",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(selectedDate),
              ),
            ),

            // Tasks Completed Today
            _buildTextInputSection("Tasks Completed Today", tasksController),
            const SizedBox(height: 20),

            // Next Day's Plan
            _buildTextInputSection("Plan for Tomorrow", planController),
            const SizedBox(height: 20),

            // Challenges Encountered
            _buildTextInputSection(
                "Challenges Encountered", challengesController),
            const SizedBox(height: 20),

            // Complaints or Feedback
            _buildTextInputSection("Complaints/Feedback", complaintsController),
            const SizedBox(height: 20),

            // Time Spent
            _buildTextInputSection("Time Spent (Optional)", hoursController,
                hintText: "Total Hours Worked"),
            const SizedBox(height: 30),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton("Cancel", Colors.red, () {
                  // Logic to discard changes
                }),
                _buildActionButton("Send Report", Colors.green, () {
                  // Logic to send the report
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInputSection(String title, TextEditingController controller,
      {String hintText = "Enter details here..."}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // primary: color,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: Text(label),
    );
  }
}

/*
class HeatmapWidget extends StatelessWidget {
  // Sample data for heatmap: Intensity values for each hour for each day (24 hours for 7 days)
  final List<List<double>> heatmapData = [
    List.generate(24, (index) => (index / 23).clamp(0.0, 1.0)), // Day 1
    List.generate(24, (index) => (index / 15).clamp(0.0, 1.0)), // Day 2
    List.generate(24, (index) => (index / 18).clamp(0.0, 1.0)), // Day 3
    List.generate(24, (index) => (index / 12).clamp(0.0, 1.0)), // Day 4
    List.generate(24, (index) => (index / 10).clamp(0.0, 1.0)), // Day 5
    List.generate(24, (index) => (index / 20).clamp(0.0, 1.0)), // Day 6
    List.generate(24, (index) => (index / 8).clamp(0.0, 1.0)), // Day 7
  ];

  HeatmapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Header for days of the week
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                return Expanded(
                  child: Center(
                    child: Text(
                      _getDayName(index),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            // Heatmap grid
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(7, (dayIndex) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(24, (hourIndex) {
                        double intensity = heatmapData[dayIndex][hourIndex];
                        return Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.symmetric(vertical: 1.0),
                          color: _getHeatmapColor(intensity),
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayName(int index) {
    switch (index) {
      case 0:
        return 'M'; // Monday
      case 1:
        return 'T'; // Tuesday
      case 2:
        return 'W'; // Wednesday
      case 3:
        return 'T'; // Thursday
      case 4:
        return 'F'; // Friday
      case 5:
        return 'S'; // Saturday
      case 6:
        return 'S'; // Sunday
      default:
        return '';
    }
  }

  // Function to map intensity value to shades of green
  Color _getHeatmapColor(double intensity) {
    // Map intensity to shades of green (light green for low, dark green for high intensity)
    return Color.lerp(Colors.green[100]!, Colors.green[900]!, intensity)!;
  }
}
*/

/**/
/*
class HeatmapWidget extends StatelessWidget {
  // Sample data for heatmap
  final List<List<double>> heatmapData = List.generate(7, (dayIndex) {
    return List.generate(24, (hourIndex) {
      double baseIntensity =
          (hourIndex / (Random().nextInt(24) + 1)).clamp(0.0, 1.0);
      double randomVariation = Random().nextDouble() * 0.3;
      double finalIntensity = (baseIntensity + randomVariation).clamp(0.0, 1.0);
      return finalIntensity;
    });
  });

  HeatmapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // Main heatmap content
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cellWidth =
                      (constraints.maxWidth - 40) / 7; // 40 for hour labels
                  final cellHeight =
                      (constraints.maxHeight - 30) / 24; // 30 for day labels

                  return Column(
                    children: [
                      // Day labels row
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            // Space for hour labels
                            SizedBox(width: 40),
                            // Day labels
                            ...List.generate(7, (index) {
                              return SizedBox(
                                width: cellWidth,
                                child: Center(
                                  child: Text(
                                    _getDayName(index),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      // Heatmap grid
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hour labels column
                            SizedBox(
                              width: 40,
                              child: Column(
                                children: List.generate(24, (hourIndex) {
                                  return SizedBox(
                                    height: cellHeight,
                                    child: Center(
                                      child: Text(
                                        hourIndex.toString().padLeft(2, '0'),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            // Heatmap cells
                            ...List.generate(7, (dayIndex) {
                              return SizedBox(
                                width: cellWidth,
                                child: Column(
                                  children: List.generate(24, (hourIndex) {
                                    double intensity =
                                        heatmapData[dayIndex][hourIndex];
                                    return Container(
                                      height: cellHeight,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: _getHeatmapColor(intensity),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      // Legend
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Less Active',
                              style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 8),
                          ...List.generate(5, (index) {
                            return Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: _getHeatmapColor(index / 4),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                          const SizedBox(width: 8),
                          const Text('More Active',
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayName(int index) {
    switch (index) {
      case 0:
        return 'M';
      case 1:
        return 'T';
      case 2:
        return 'W';
      case 3:
        return 'T';
      case 4:
        return 'F';
      case 5:
        return 'S';
      case 6:
        return 'S';
      default:
        return '';
    }
  }

  Color _getHeatmapColor(double intensity) {
    if (intensity == 0.0) {
      return Colors.transparent;
    }
    // Using different shades of green for better visualization
    final List<Color> colorScale = [
      Colors.green[50]!,
      Colors.green[100]!,
      Colors.green[200]!,
      Colors.green[300]!,
      Colors.green[400]!,
      Colors.green[500]!,
      Colors.green[600]!,
      Colors.green[700]!,
      Colors.green[800]!,
      Colors.green[900]!,
    ];

    final int index = (intensity * (colorScale.length - 1)).round();
    return colorScale[index];
  }
}
*/

class HeatmapWidget extends StatelessWidget {
  // Sample data for heatmap
  final List<List<double>> heatmapData = List.generate(7, (dayIndex) {
    return List.generate(24, (hourIndex) {
      double baseIntensity =
          (hourIndex / (Random().nextInt(24) + 1)).clamp(0.0, 1.0);
      double randomVariation = Random().nextDouble() * 0.3;
      double finalIntensity = (baseIntensity + randomVariation).clamp(0.0, 1.0);
      return finalIntensity;
    });
  });

  HeatmapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weekly Activity Heatmap',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                // Main heatmap content
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cellWidth =
                          (constraints.maxWidth - 40) / 7; // 40 for hour labels
                      final cellHeight = (constraints.maxHeight - 30) /
                          24; // 30 for day labels

                      return Column(
                        children: [
                          // Day labels row
                          SizedBox(
                            height: 30,
                            child: Row(
                              children: [
                                // Space for hour labels
                                SizedBox(width: 40),
                                // Day labels
                                ...List.generate(7, (index) {
                                  return SizedBox(
                                    width: cellWidth,
                                    child: Center(
                                      child: Text(
                                        _getDayName(index),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          // Heatmap grid
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Hour labels column
                                SizedBox(
                                  width: 40,
                                  child: Column(
                                    children: List.generate(24, (hourIndex) {
                                      return SizedBox(
                                        height: cellHeight,
                                        child: Center(
                                          child: Text(
                                            hourIndex
                                                .toString()
                                                .padLeft(2, '0'),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                // Heatmap cells
                                ...List.generate(7, (dayIndex) {
                                  return SizedBox(
                                    width: cellWidth,
                                    child: Column(
                                      children: List.generate(24, (hourIndex) {
                                        double intensity =
                                            heatmapData[dayIndex][hourIndex];
                                        return Container(
                                          height: cellHeight,
                                          margin: const EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                            color: _getHeatmapColor(intensity),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          // Legend
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Less Active',
                                  style: TextStyle(fontSize: 12)),
                              const SizedBox(width: 8),
                              ...List.generate(5, (index) {
                                return Container(
                                  width: 20,
                                  height: 20,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    color: _getHeatmapColor(index / 4),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              }),
                              const SizedBox(width: 8),
                              const Text('More Active',
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDayName(int index) {
    switch (index) {
      case 0:
        return 'M';
      case 1:
        return 'T';
      case 2:
        return 'W';
      case 3:
        return 'T';
      case 4:
        return 'F';
      case 5:
        return 'S';
      case 6:
        return 'S';
      default:
        return '';
    }
  }

  Color _getHeatmapColor(double intensity) {
    if (intensity == 0.0) {
      return Colors.transparent;
    }
    // Using different shades of green for better visualization
    final List<Color> colorScale = [
      Colors.green[50]!,
      Colors.green[100]!,
      Colors.green[200]!,
      Colors.green[300]!,
      Colors.green[400]!,
      Colors.green[500]!,
      Colors.green[600]!,
      Colors.green[700]!,
      Colors.green[800]!,
      Colors.green[900]!,
    ];

    final int index = (intensity * (colorScale.length - 1)).round();
    return colorScale[index];
  }
}
