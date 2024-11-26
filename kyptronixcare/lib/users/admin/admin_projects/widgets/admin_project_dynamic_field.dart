import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminProjectDynamicField extends StatelessWidget {
  final String title;
  final List<TextEditingController> controllers;
  final VoidCallback onAdd;
  final Function(int) onRemove;
  final Function(int)? additionalWidgetBuilder;

  const AdminProjectDynamicField({
    super.key,
    required this.title,
    required this.controllers,
    required this.onAdd,
    required this.onRemove,
    this.additionalWidgetBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Gap(8.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controllers.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controllers[index],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: '$title ${index + 1}',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter $title ${index + 1}';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () => onRemove(index),
                      ),
                    ],
                  ),
                  if (additionalWidgetBuilder != null)
                    additionalWidgetBuilder!(index),
                ],
              );
            },
          ),
          const Gap(8.0),
          Center(
            child: TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle),
              label: Text('Add $title'),
            ),
          ),
        ],
      ),
    );
  }
}
