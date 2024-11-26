import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomDivider extends StatelessWidget {
  final String title;
  const CustomDivider({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
    );
  }
}
