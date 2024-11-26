import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DevDashboardHeader extends StatelessWidget {
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  final void Function()? onTap;
  const DevDashboardHeader({
    super.key,
    required this.textTheme,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome Back',
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 24.0,
                  // color: colorScheme.surface,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: const Icon(
                  Icons.menu,
                  // color: colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
        const Gap(4.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'iRawNewton',
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 44.0,
                    // color: colorScheme.surface,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 8.0), // Spacing between text and avatar
              const ActiveProfileAvatar(),
            ],
          ),
        ),
      ],
    );
  }
}

class ActiveProfileAvatar extends StatelessWidget {
  const ActiveProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    double avatarSize = MediaQuery.of(context).size.width * 0.1;

    return SizedBox(
      height: avatarSize,
      width: avatarSize,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(avatarSize / 2),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1458071103673-6a6e4c4a3413?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: avatarSize * 0.3,
              width: avatarSize * 0.3,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
