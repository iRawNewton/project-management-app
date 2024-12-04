import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectLinks extends StatelessWidget {
  final String githubUrl;
  final String liveUrl;
  final String demoUrl;
  const ProjectLinks({
    super.key,
    required this.githubUrl,
    required this.liveUrl,
    required this.demoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: [
        _buildLinkButton(
          url: githubUrl,
          icon: FontAwesomeIcons.github,
          label: 'Source Code',
        ),
        _buildLinkButton(
          url: liveUrl,
          icon: Icons.public,
          label: 'Live Site',
        ),
        _buildLinkButton(
          url: demoUrl,
          icon: Icons.play_circle_outline,
          label: 'Live Demo',
        ),
      ],
    );
  }

  Widget _buildLinkButton({
    required String url,
    required IconData icon,
    required String label,
  }) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
