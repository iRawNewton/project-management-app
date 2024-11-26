import 'package:flutter/material.dart';

class AdminProjectStatsCard extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final List<Color> gradientColors;
  final IconData icon;
  final String count; // Add a count parameter to display numbers

  const AdminProjectStatsCard({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.gradientColors,
    required this.icon,
    required this.count,
  });

  @override
  State<AdminProjectStatsCard> createState() => _AdminProjectStatsCardState();
}

class _AdminProjectStatsCardState extends State<AdminProjectStatsCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedScale(
        scale: _scaleAnimation.value,
        duration: const Duration(milliseconds: 200),
        child: Container(
          height: widget.height,
          width: widget.width,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.6)
                    : Colors.grey.withOpacity(0.5),
                blurRadius: 20.0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Glossy effect overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.15)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Positioned(
              //   left: 16.0,
              //   top: 16.0,
              //   child: Icon(
              //     widget.icon,
              //     size: 40.0,
              //     color: isDarkMode ? Colors.white : Colors.black87,
              //   ),
              // ),
              // Positioned(
              //   left: 16.0,
              //   bottom: 16.0,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         widget.title,
              //         style: TextStyle(
              //           color: isDarkMode ? Colors.white : Colors.black87,
              //           fontSize: 18.0,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const Gap(4.0),
              //       Text(
              //         widget.count,
              //         style: TextStyle(
              //           color: isDarkMode ? Colors.white70 : Colors.black54,
              //           fontSize: 24.0,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
