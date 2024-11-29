import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kyptronixcare/core/widgets/custom_appbar.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../bloc/admin_crud_client_bloc.dart';

class AdminCreateClient extends StatefulWidget {
  const AdminCreateClient({super.key});

  @override
  State<AdminCreateClient> createState() => _AdminCreateClientState();
}

class _AdminCreateClientState extends State<AdminCreateClient> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  // Form field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
        body: BlocConsumer<AdminCrudClientBloc, AdminCrudClientState>(
          listener: (context, state) {
            // Dismiss the current dialog if it exists
            if (currentDialog != null) {
              currentDialog!.dismiss();
              currentDialog = null; // Clear the reference
            }

            /* --------------------------- User Loading State --------------------------- */
            if (state is AdminCrudClientLoading) {
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
            else if (state is AdminCrudClientSuccess) {
              _nameController.clear();
              _emailController.clear();
              _dobController.clear();
              _passwordController.clear();
              _phoneController.clear();
              _whatsappController.clear();

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
            else if (state is AdminCrudClientEmailAlreadyExists) {
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
            return current is AdminCrudClientLoading ||
                current is AdminCrudClientSuccess ||
                current is AdminCrudClientEmailAlreadyExists ||
                current is AdminCrudClientError;
            // return current is UserSuccess || current is UserFailure;
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Custom AppBar
                  const CustomAppbar(
                    title: 'Manager Form',
                  ),

                  // Form

                  Center(
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
      decoration: _inputDecoration(
          labelText: label,
          hintText: label,
          prefixIcon: icon,
          suffixIcon: suffixIcon),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration({
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF296FF9)),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF296FF9), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

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
            context.read<AdminCrudClientBloc>().add(
                  CreateUserClientEvent(
                      name: _nameController.text.trim(),
                      email: _emailController.text.trim(),
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
