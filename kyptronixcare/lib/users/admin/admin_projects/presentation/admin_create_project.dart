import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../../core/widgets/custom_appbar.dart';
import '../../../model/user_model.dart';
import '../bloc/admin_projects_bloc.dart';

class AdminCreateProject extends StatefulWidget {
  const AdminCreateProject({super.key});

  @override
  State<AdminCreateProject> createState() => _AdminCreateProjectState();
}

class _AdminCreateProjectState extends State<AdminCreateProject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _clientId = TextEditingController();

  String? selectedClient;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _clientId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    StylishDialog? currentDialog;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppbar(title: 'Create Project'),
                BlocListener<AdminProjectsBloc, AdminProjectsState>(
                  listener: (context, state) {
                    if (currentDialog != null) {
                      currentDialog!.dismiss();
                      currentDialog = null; // Clear the reference
                    }
                    if (state is AdminProjectsLoading) {
                      currentDialog = StylishDialog(
                        context: context,
                        controller: DialogController(
                          listener: (status) {},
                        ),
                        alertType: StylishDialogType.PROGRESS,
                        style: DefaultStyle(
                          progressColor: Colors.teal,
                          animationLoop: true,
                          backgroundColor:
                              isDarkMode ? Colors.black : Colors.white,
                        ),
                        dismissOnTouchOutside: false,
                        title: Text(
                          'Hold Tight! 🚀',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'Your project is on the launch pad, ready to blast off!',
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      );
                      currentDialog!.show(); // Show the loading dialog
                    }
                    if (state is AdminProjectsCreatedSuccessfully) {
                      _nameController.clear();
                      _descriptionController.clear();
                      _clientId.clear();
                      currentDialog = StylishDialog(
                        context: context,
                        alertType: StylishDialogType.SUCCESS,
                        style: DefaultStyle(
                          progressColor: Colors.teal,
                          animationLoop: true,
                          backgroundColor:
                              isDarkMode ? Colors.black : Colors.white,
                        ),
                        title: Text(
                          'All Systems Go! 🚀',
                          style: theme.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        cancelButton: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        confirmButton: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () {
                            // Navigate to profile or perform an action
                          },
                          child: Text(
                            'Go to Project',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        content: Text(
                          'Your project is live. The world is waiting. Don’t mess it up!',
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      );
                      currentDialog!.show(); // Show the success dialog
                    }
                    if (state is AdminProjectsCreateFailed) {
                      Navigator.pop(context);
                      currentDialog = StylishDialog(
                        context: context,
                        alertType: StylishDialogType.ERROR,
                        style: DefaultStyle(
                          backgroundColor:
                              isDarkMode ? Colors.black : Colors.white,
                          progressColor: Colors.teal,
                          animationLoop: true,
                        ),
                        title: Text(
                          'Whoopsie! 😅',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'Looks like we hit a snag. Give it another shot!',
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      );
                      currentDialog!.show();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(24.0),
                        _buildProjectNameField(),
                        const SizedBox(height: 20),
                        _buildDescriptionField(),
                        const SizedBox(height: 20),
                        _buildClientDropdown(theme),
                        const SizedBox(height: 30),
                        _buildSubmitButton(theme),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectNameField() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: _inputDecoration(
        labelText: 'Project Name',
        hintText: 'Enter project name',
        prefixIcon: Icons.work_outline,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Project name is required';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 4,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      decoration: _inputDecoration(
        labelText: 'Description',
        hintText: 'Provide project details',
        prefixIcon: Icons.description_outlined,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Project description is required';
        }
        return null;
      },
    );
  }

  Widget _buildClientDropdown(ThemeData theme) {
    return FutureBuilder<QuerySnapshot>(
      future: _firestore
          .collection('users')
          .where('role', isEqualTo: 'Client')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while waiting for the data
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          // Handle any errors
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          // If no data is found
          return const Text('No clients available');
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
                hintText: 'Search clients...',
              ),
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            textAlign: TextAlign.start,
            baseStyle: theme.textTheme.bodyLarge,
            decoration: _inputDecoration(
              labelText: 'Client Name',
              hintText: 'Select client',
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

              _clientId.text = selectedClient.id;
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a client';
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

  Widget _buildSubmitButton(ThemeData theme) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<AdminProjectsBloc>().add(
                AdminProjectsCreateEvent(
                  _nameController.text.trim(),
                  _descriptionController.text.trim(),
                  _clientId.text.trim(),
                  '',
                  const [],
                  const [],
                  const [],
                  const [],
                  const [],
                  const [],
                  const [],
                  const [],
                  const [],
                  0,
                  DateTime.now(),
                  DateTime.now(),
                  DateTime.now(),
                  DateTime.now(),
                  const [],
                ),
              );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF296FF9),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        'Create Project',
        style: theme.textTheme.bodyLarge!.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
