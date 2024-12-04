import 'package:flutter/material.dart';

class AdminProjectTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? textInputType;
  final bool readOnly;
  final int maxLines;
  final VoidCallback? onTap;

  const AdminProjectTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.textInputType,
    this.readOnly = false, // Fixed assignment
    this.maxLines = 1, // Fixed assignment
    this.onTap, // Fixed assignment
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
