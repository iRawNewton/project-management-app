import 'package:flutter/material.dart';

class DevSearchTextField extends StatelessWidget {
  const DevSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(0xFF2A2D3E)
              : Colors.white, // Slightly darker color for dark mode
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 10,
              spreadRadius: 0,
              color: isDarkMode
                  ? Colors.black.withOpacity(0.5)
                  : Colors.grey.withOpacity(0.1),
            ),
          ],
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          onChanged: (value) {
            // Handle text change
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search,
                color: isDarkMode ? Colors.white : Colors.black),
            filled: true,
            fillColor: Colors.transparent,
            hintText: 'Search',
            hintStyle:
                TextStyle(color: isDarkMode ? Colors.white54 : Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isDarkMode ? Colors.white : Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
}
