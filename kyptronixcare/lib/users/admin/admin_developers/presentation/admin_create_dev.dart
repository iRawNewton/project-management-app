import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kyptronixcare/core/widgets/custom_appbar.dart';
import 'package:kyptronixcare/users/admin/admin_projects/presentation/admin_project_view.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../bloc/admin_crud_dev_bloc.dart';

class AdminCreateDev extends StatefulWidget {
  const AdminCreateDev({super.key});

  @override
  State<AdminCreateDev> createState() => _AdminCreateDevState();
}

class _AdminCreateDevState extends State<AdminCreateDev> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  // Form field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleTypeController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _roleTypeController.dispose();
    _roleController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    StylishDialog? currentDialog;

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AdminCrudDevBloc, AdminCrudDevState>(
          listener: (context, state) {
            // Dismiss the current dialog if it exists
            if (currentDialog != null) {
              currentDialog!.dismiss();
              currentDialog = null; // Clear the reference
            }

            /* --------------------------- User Loading State --------------------------- */
            if (state is AdminCrudDevLoading) {
              currentDialog = StylishDialog(
                context: context,
                controller: DialogController(
                  listener: (status) {},
                ),
                alertType: StylishDialogType.PROGRESS,
                style: DefaultStyle(
                  progressColor: Colors.teal,
                  animationLoop: true,
                  backgroundColor: isDarkMode ? Colors.black : Colors.white,
                ),
                dismissOnTouchOutside: false,
                title: Text(
                  'Hold Tight! 🎢',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  'Your account is taking a thrilling ride. Enjoy the wait!',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );
              currentDialog!.show(); // Show the loading dialog
            }

            /* --------------------------- User Success State --------------------------- */
            else if (state is AdminCrudDevSuccess) {
              _nameController.clear();
              _emailController.clear();
              _roleController.clear();
              _dobController.clear();
              _passwordController.clear();
              _phoneController.clear();
              _whatsappController.clear();
              Navigator.pop(context);
              currentDialog = StylishDialog(
                context: context,
                alertType: StylishDialogType.SUCCESS,
                style: DefaultStyle(
                  progressColor: Colors.teal,
                  animationLoop: true,
                  backgroundColor: isDarkMode ? Colors.black : Colors.white,
                ),
                title: Text(
                  'All Set! 🚀',
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
                    'Go to profile',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                content: Text(
                  'Your account is live! Time to explore!',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );
              currentDialog!.show(); // Show the success dialog
            }

            /* ------------------------ Email Already Exists State ----------------------- */
            else if (state is AdminCrudDevEmailAlreadyExists) {
              Navigator.pop(context);
              currentDialog = StylishDialog(
                context: context,
                alertType: StylishDialogType.ERROR,
                style: DefaultStyle(
                  backgroundColor: isDarkMode ? Colors.black : Colors.white,
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
                  'This email is already registered. Time to get creative!',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );
              currentDialog!.show(); // Show the error dialog
            }
          },
          listenWhen: (previous, current) {
            // Listen only for UserSuccess or EmailAlreadyExists states after CreateUserEvent
            return current is AdminCrudDevLoading ||
                current is AdminCrudDevSuccess ||
                current is AdminCrudDevEmailAlreadyExists ||
                current is AdminCrudDevError;
            // return current is UserSuccess || current is UserFailure;
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Custom AppBar
                  const CustomAppbar(
                    title: 'Developer Form',
                  ),

                  // Form
                  const Gap(20.0),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProjectPage()));
                      },
                      child: Text('data')),

                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(36.0),
                                _buildTextField(
                                  controller: _nameController,
                                  label: 'Name',
                                  icon: Icons.person,
                                  keyboardType: TextInputType.name,
                                ),
                                const SizedBox(height: 16.0),
                                _buildTextField(
                                  controller: _emailController,
                                  label: 'Email',
                                  icon: Icons.email,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 16.0),
                                // _buildRoleDropdown(),
                                RoleDropdown(
                                  roleCategoryController: _roleTypeController,
                                  roleController: _roleController,
                                ),
                                const SizedBox(height: 16.0),
                                _buildTextField(
                                  controller: _dobController,
                                  label: 'Date of Birth',
                                  icon: Icons.calendar_today,
                                  keyboardType: TextInputType.datetime,
                                  readOnly: true,
                                  onTap: _selectDate,
                                ),
                                const SizedBox(height: 16.0),
                                _buildTextField(
                                  controller: _passwordController,
                                  label: 'Password',
                                  icon: Icons.lock,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !_passwordVisible,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                _buildTextField(
                                  controller: _phoneController,
                                  label: 'Phone Number',
                                  icon: Icons.phone,
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: 16.0),
                                _buildTextField(
                                  controller: _whatsappController,
                                  label: 'WhatsApp Number',
                                  icon: Icons.message,
                                  keyboardType: TextInputType.phone,
                                ),
                                const SizedBox(height: 30.0),
                                _buildRegisterButton(),
                                const SizedBox(height: 16.0),
                                _buildSignInOption(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    bool readOnly = false,
    void Function()? onTap,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

/* 
  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      // controller: _roleController,
      decoration: InputDecoration(
        labelText: 'Role',
        prefixIcon: const Icon(Icons.work),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      items: ['Admin', 'Manager', 'Client', 'Developer']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        _roleController.text = newValue!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a role';
        }
        return null;
      },
    );
  }
 */

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        final ThemeData theme = Theme.of(context);
        final bool isDarkMode = theme.brightness == Brightness.dark;

        return Theme(
          data: theme.copyWith(
            primaryColor: isDarkMode
                ? Colors.blueAccent
                : const Color(0xFF8CE7F1), // For older Flutter versions
            hintColor: isDarkMode ? Colors.white70 : const Color(0xFF8CE7F1),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor:
                  isDarkMode ? Colors.blueAccent : const Color(0xFF8CE7F1),
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
            ).copyWith(
                secondary:
                    isDarkMode ? Colors.blueAccent : const Color(0xFF8CE7F1)),
            // Optionally customize more aspects based on theme
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // print(_roleController.text);
          if (_formKey.currentState!.validate()) {
            // Submit form
            context.read<AdminCrudDevBloc>().add(
                  CreateUserDevEvent(
                      name: _nameController.text.trim(),
                      email: _emailController.text.trim(),
                      roleType: _roleTypeController.text.trim(),
                      role: _roleController.text.trim(),
                      password: _passwordController.text.trim(),
                      phone: _phoneController.text.trim(),
                      whatsappNumber: _whatsappController.text.trim(),
                      dateOfBirth: Timestamp.fromDate(
                          DateFormat('yyyy-MM-dd').parse(_dobController.text))),
                );
          }
          // Submit form
          // Implement form submission logic here
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Center(
        child: Text(
          'Register',
          style: GoogleFonts.montserrat(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInOption() {
    return Center(
      child: TextButton(
        onPressed: () {
          // Navigate to the sign-in page
        },
        child: Text(
          'Need help? Contact support.',
          style: GoogleFonts.montserrat(
            fontSize: 14.0,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------

class RoleDropdown extends StatefulWidget {
  final TextEditingController roleCategoryController;
  final TextEditingController roleController;

  const RoleDropdown({
    super.key,
    required this.roleCategoryController,
    required this.roleController,
  });

  @override
  State<RoleDropdown> createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String? _selectedCategory;
  String? _selectedRole;

  // Define categories and subcategories
  final Map<String, List<String>> _roleCategories = {
    'Developer': ['Mobile Developer', 'Web Developer'],
    'Digital Marketing': ['SEO', 'SMO', 'PPC Specialist'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            labelText: 'Category',
            prefixIcon: const Icon(Icons.work),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          items: _roleCategories.keys
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: _selectedCategory,
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategory = newValue;
              _selectedRole = null; // Reset role when category changes
              widget.roleCategoryController.text =
                  newValue ?? ''; // Update controller
              widget.roleController.text = ''; // Reset role controller
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a category';
            }
            return null;
          },
        ),
        const SizedBox(height: 16.0),
        DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            labelText: 'Role',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          items: (_selectedCategory != null
                  ? _roleCategories[_selectedCategory]!
                  : [])
              .map<DropdownMenuItem<String>>((dynamic value) {
            return DropdownMenuItem<String>(
              value: value as String,
              child: Text(value),
            );
          }).toList(),
          value: _selectedRole,
          onChanged: (String? newValue) {
            setState(() {
              _selectedRole = newValue;
              widget.roleController.text = newValue ?? ''; // Update controller
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a role';
            }
            return null;
          },
        ),
      ],
    );
  }
}
