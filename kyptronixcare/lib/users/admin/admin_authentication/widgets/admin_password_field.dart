import 'package:flutter/material.dart';

class AdminPasswordField extends StatefulWidget {
  const AdminPasswordField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.borderRadius,
    required this.textTheme,
    required this.isDarkMode,
  });
  final String hintText;
  final TextEditingController controller;
  final BorderRadiusGeometry borderRadius;
  final TextTheme textTheme;
  final bool isDarkMode;

  @override
  State<AdminPasswordField> createState() => _AdminPasswordFieldState();
}

class _AdminPasswordFieldState extends State<AdminPasswordField> {
  bool _obscureText = true;

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
      child: TextFormField(
        obscureText: _obscureText,
        controller: widget.controller,
        style: widget.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              // color: AppColor.kGrayscaleDark100,
              size: 17,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: widget.isDarkMode ? Colors.white54 : Colors.grey),
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
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
        ),
      ),
    );
  }
}
