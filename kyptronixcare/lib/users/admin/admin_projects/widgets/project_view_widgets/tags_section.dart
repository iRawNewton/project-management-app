import 'package:flutter/material.dart';

class TagsSection extends StatelessWidget {
  final List<String>? tags;
  const TagsSection({super.key, this.tags});

  @override
  Widget build(BuildContext context) {
    if (tags == null || tags!.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: tags!.map((tag) => _buildTag(tag)).toList(),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.blue[700],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Widget _buildTagsSection(List<String>? tags) {
//   if (tags == null || tags.isEmpty) return const SizedBox.shrink();

//   return Wrap(
//     spacing: 8.0,
//     runSpacing: 8.0,
//     children: tags.map((tag) => _buildTag(tag)).toList(),
//   );
// }


