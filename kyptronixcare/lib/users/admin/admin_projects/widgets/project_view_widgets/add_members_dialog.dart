import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyptronixcare/users/admin/admin_projects/bloc/admin_projects_bloc.dart';

import '../../../../model/user_model.dart';

class AddMembersDialog extends StatefulWidget {
  const AddMembersDialog(
      {super.key,
      required this.isDarkMode,
      required this.role,
      required this.projectID});
  final bool isDarkMode;
  final String role;
  final String projectID;
  @override
  State<AddMembersDialog> createState() => _AddMembersDialogState();
}

class _AddMembersDialogState extends State<AddMembersDialog> {
  final TextEditingController _idController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.isDarkMode
                ? [const Color(0xFF2C3E50), const Color(0xFF000000)]
                : [const Color(0xFFB0C4DE), const Color(0xFFFFFFFF)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add ${widget.role}',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.person_add,
                  color: Colors.blue.shade800,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildClientDropdown(theme, widget.role),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red.shade600,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // print(widget.role == 'Developer');
                    context.read<AdminProjectsBloc>().add(
                          AdminProjectsAssignTeamEvent(
                            _idController.text.trim(),
                            (widget.role == 'Developer'),
                            widget.projectID,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  /* -------------------------------- DropDown -------------------------------- */
  Widget _buildClientDropdown(ThemeData theme, String role) {
    return FutureBuilder<QuerySnapshot>(
      future:
          _firestore.collection('users').where('role', isEqualTo: role).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while waiting for the data
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          // Handle any errors
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          // If no data is found
          return Text('No $role available');
        }

        // Convert the Firestore documents to a list of UserModel
        final List<UserModel> clients = snapshot.data!.docs
            .map((doc) =>
                UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
            .toList();

        return DropdownSearch<String>(
          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Search $role...',
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            textAlign: TextAlign.start,
            baseStyle: theme.textTheme.bodyLarge,
            decoration: _inputDecoration(
              labelText: '$role Name',
              hintText: 'Select $role',
              prefixIcon: Icons.business_outlined,
            ),
          ),
          items: (String filter, loadProps) {
            // Filter the clients based on the search query
            final filteredClients = clients
                .where((client) =>
                    client.name.toLowerCase().contains(filter.toLowerCase()))
                .map((client) => client.name)
                .toList();

            return filteredClients;
          },
          onChanged: (value) {
            // Find the client from the list based on the selected name
            final selectedClient = clients.firstWhere(
              (client) => client.name == value,
              orElse: () => UserModel(
                  id: '',
                  name: '',
                  email: '',
                  role: '',
                  profilePictureUrl: '',
                  assignedProjects: [],
                  emergencyTasks: [],
                  notifications: [],
                  phone: '',
                  whatsappNumber: '',
                  password: '',
                  firstLogin: Timestamp.now(),
                  lastLogin: Timestamp.now(),
                  dateOfBirth: Timestamp.now(),
                  createdAt: Timestamp.now(),
                  updatedAt: Timestamp.now()),
            );

            // Print the selected client's document ID
            if (selectedClient.id.isNotEmpty) {
              // print('Selected Client Document ID: ${selectedClient.id}');

              // _clientId.text = selectedClient.id;
              _idController.text = selectedClient.id;
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a $role';
            }
            return null;
          },
        );
      },
    );
  }

  InputDecoration _inputDecoration({
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF4A6CF7)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF4A6CF7), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}
