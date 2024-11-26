import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius, elevation;
  final double? fontSize;
  final IconData? iconData;
  final Color? textColor, bgColor;
  final TextTheme textTheme;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.elevation = 5,
    this.borderRadius,
    this.fontSize,
    required this.textColor,
    required this.bgColor,
    required this.textTheme,
    this.iconData,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
        reverseCurve: const Interval(0.2, 0.4, curve: Curves.easeIn),
      ),
    );

    _glowAnimation = Tween<double>(begin: 2.0, end: 8.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                boxShadow: [
                  BoxShadow(
                    color: widget.bgColor!.withOpacity(0.5),
                    blurRadius: _glowAnimation.value,
                    spreadRadius: _glowAnimation.value / 2,
                  ),
                ],
              ),
              child: Card(
                elevation: widget.elevation ?? 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                ),
                child: Container(
                  height: widget.height ?? 55,
                  alignment: Alignment.center,
                  width: widget.width ?? double.maxFinite,
                  decoration: BoxDecoration(
                    color: widget.bgColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius!),
                  ),
                  child: Text(
                    widget.text,
                    style: widget.textTheme.bodyLarge!.copyWith(
                      color: widget.textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: widget.fontSize,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
