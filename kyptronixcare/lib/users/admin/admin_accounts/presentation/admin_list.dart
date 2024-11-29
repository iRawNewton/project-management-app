import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyptronixcare/users/admin/admin_accounts/bloc/admin_crud_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../../core/widgets/custom_appbar.dart';
import '../widgets/developer_card.dart';
import 'admin_create_admin.dart';

class AdminList extends StatefulWidget {
  const AdminList({super.key});

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  @override
  void initState() {
    context.read<AdminCrudBloc>().add(GetUserAdminEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StylishDialog? currentDialog;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Custom AppBar

              const CustomAppbar(title: 'Admins'),
              const Gap(20.0),

              BlocConsumer<AdminCrudBloc, AdminCrudState>(
                listener: (context, state) {
                  // Handle any specific state changes (like showing a snackbar on error)

                  if (state is AdminCrudError) {
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
                        'Uh-oh! ⚠️',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        state.message,
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    );
                    currentDialog!.show(); // Show the loading dialog
                  }
                },
                listenWhen: (previous, current) {
                  return current is GetUserAdminEvent;
                },
                builder: (context, state) {
                  if (state is AdminCrudUserFetched) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        children: state.adminUsers.map((adminUsersList) {
                          return DeveloperCard(adminUsers: adminUsersList);
                        }).toList(),
                      ),
                    );
                  } else if (state is AdminCrudLoading) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: 10, // Set the number of shimmer items
                      itemBuilder: (context, index) {
                        return _buildShimmerImage();
                      },
                    );
                  } else if (state is AdminCrudError) {
                    return const Text(
                        'An error occurred'); // Handle error state
                  }
                  return const Text('Loading...'); // Default loading state
                },
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
                builder: (context) => const AdminCreateAdmin(),
              ),
            );
          },
          tooltip: 'Add Admin',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

Widget _buildShimmerImage() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 150.0,
        child: ColoredBox(
          color: Colors.white,
        ),
      ),
    ),
  );
}
