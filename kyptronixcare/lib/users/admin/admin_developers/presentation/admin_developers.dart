import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kyptronixcare/core/widgets/custom_appbar.dart';
import 'package:kyptronixcare/users/admin/admin_developers/presentation/admin_create_dev.dart';

class DevelopersPage extends StatelessWidget {
  const DevelopersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Custom AppBar

              const CustomAppbar(title: 'Developers'),
              const Gap(20.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: developers.map((developer) {
                    return DeveloperCard(developer: developer);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to add new developer page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminCreateDev(),
              ),
            );
          },
          tooltip: 'Add Developer',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class DeveloperCard extends StatefulWidget {
  final Developer developer;

  const DeveloperCard({super.key, required this.developer});

  @override
  State<DeveloperCard> createState() => _DeveloperCardState();
}

class _DeveloperCardState extends State<DeveloperCard> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: toggleExpansion,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24, // Adjust card width
        decoration: BoxDecoration(
          gradient: isExpanded
              ? const LinearGradient(
                  colors: [
                    Color(0xFF296FF9),
                    Color(0xFF296FF9),
                    Color(0xFF6717CD),
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                )
              : const LinearGradient(
                  colors: [Color(0xFF296FF9), Color(0xFF296FF9)]),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.network(
                widget.developer.photoUrl,
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.developer.name,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  AnimatedCrossFade(
                    firstChild: Container(),
                    secondChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.developer.email,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 14.0,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          widget.developer.role,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to detailed view
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'View More',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Developer {
  final String name;
  final String email;
  final String role;
  final String photoUrl;

  Developer({
    required this.name,
    required this.email,
    required this.role,
    required this.photoUrl,
  });
}

final List<Developer> developers = [
  Developer(
    name: 'John Doe',
    email: 'john.doe@example.com',
    role: 'Flutter Developer',
    photoUrl: 'https://via.placeholder.com/150',
  ),
  Developer(
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    role: 'Backend Developer',
    photoUrl: 'https://via.placeholder.com/150',
  ),
  Developer(
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    role: 'Backend Developer',
    photoUrl: 'https://via.placeholder.com/150',
  ),
  Developer(
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    role: 'Backend Developer',
    photoUrl: 'https://via.placeholder.com/150',
  ),
  Developer(
    name: 'John Doe',
    email: 'john.doe@example.com',
    role: 'Flutter Developer',
    photoUrl: 'https://via.placeholder.com/150',
  ),
  Developer(
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    role: 'Backend Developer',
    photoUrl: 'https://via.placeholder.com/150',
  ),
  Developer(
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    role: 'Backend Developer',
    photoUrl: 'https://via.placeholder.com/150',
  ),
  Developer(
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
    role: 'Backend Developer',
    photoUrl: 'https://via.placeholder.com/150',
  ),
  // Add more developers here
];
