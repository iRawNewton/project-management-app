import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../model/user_model.dart';
import '../presentation/admin_profile.dart';

class DeveloperCard extends StatefulWidget {
  final UserModel adminUsers;

  const DeveloperCard({super.key, required this.adminUsers});

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

    final profilePictureUrl = widget.adminUsers.profilePictureUrl;
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Network image

                  profilePictureUrl.isNotEmpty
                      ? Image.network(
                          profilePictureUrl,
                          width: double.infinity,
                          height: 150.0,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.blue.shade700,
                                  Colors.indigo.shade700,
                                ]),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: _buildProfileImage(),
                              ),
                            );
                          },
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.blue.shade700,
                              Colors.indigo.shade700,
                            ]),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: _buildProfileImage(),
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.adminUsers.name,
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
                          widget.adminUsers.email,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontSize: 14.0,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          widget.adminUsers.role ?? 'Not Found',
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfileScreen(
                                        name: widget.adminUsers.name,
                                        email: 'email',
                                        role: 'role',
                                        profilePictureUrl:
                                            'https://tinyurl.com/2hxnfuaj',
                                        assignedProjects: [''],
                                        emergencyTasks: ['emergencyTasks'],
                                        notifications: ['notifications'],
                                        phone: '334534543543',
                                        whatsappNumber: '3425342534',
                                        dateOfBirth: 'dateOfBirth',
                                        createdAt: DateTime.now(),
                                        lastLogin: DateTime.now())));
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

  Widget _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey.shade200,
        child: ClipOval(
          child: widget.adminUsers.profilePictureUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: widget.adminUsers.profilePictureUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.grey,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'No Image',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  color: Colors.grey.shade200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                        size: 32,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'No Photo',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
