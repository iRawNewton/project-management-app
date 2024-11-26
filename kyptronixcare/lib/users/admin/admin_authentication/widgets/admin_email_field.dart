import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminEmailField extends StatefulWidget {
  const AdminEmailField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.hintTextColor,
    this.prefixIcon,
    this.borderRadius,
    this.onChanged,
    this.onTapOutside,
    this.prefixIconColor,
    this.inputFormatters,
    this.maxLines,
    required this.isDarkMode,
    required this.textTheme,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Color? hintTextColor;
  final Widget? prefixIcon;
  final BorderRadiusGeometry? borderRadius;
  final Function(String)? onChanged;
  final Function(PointerDownEvent)? onTapOutside;
  final Color? prefixIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool isDarkMode;
  final TextTheme textTheme;

  @override
  State<AdminEmailField> createState() => _AdminEmailFieldState();
}

class _AdminEmailFieldState extends State<AdminEmailField> {
  @override
  Widget build(BuildContext context) {
    InputBorder focusedErrorBorder = InputBorder.none;
    InputBorder errorBorder = InputBorder.none;

    return Container(
      decoration: BoxDecoration(
        color: widget.isDarkMode ? const Color(0xFF2A2D3E) : Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 0,
            color: widget.isDarkMode
                ? Colors.black.withOpacity(0.5)
                : Colors.grey.withOpacity(0.1),
          ),
        ],
      ),

      // ---------------
      child: TextFormField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        style: widget.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
          filled: true,
          fillColor: Colors.transparent,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: widget.isDarkMode ? Colors.white54 : Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          suffixIcon: const Icon(
            Icons.mail_outline,
            size: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
        onTapOutside: widget.onTapOutside,
      ),
    );
  }
}
