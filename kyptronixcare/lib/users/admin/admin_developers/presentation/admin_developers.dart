import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

import '../../../../core/widgets/custom_appbar.dart';
import '../../admin_accounts/widgets/developer_card.dart';
import '../bloc/admin_crud_dev_bloc.dart';
import 'admin_create_dev.dart';

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({super.key});

  @override
  State<DevelopersPage> createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  @override
  void initState() {
    context.read<AdminCrudDevBloc>().add(GetUserDevEvent());
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

              const CustomAppbar(title: 'Developers'),
              const Gap(20.0),

              BlocConsumer<AdminCrudDevBloc, AdminCrudDevState>(
                listener: (context, state) {
                  // Handle any specific state changes (like showing a snackbar on error)

                  if (state is AdminCrudDevError) {
                    if (state.message == "No users found.") {
                      currentDialog = StylishDialog(
                        context: context,
                        controller: DialogController(
                          listener: (status) {},
                        ),
                        alertType: StylishDialogType.NORMAL,
                        style: DefaultStyle(
                          progressColor: Colors.teal,
                          animationLoop: true,
                          backgroundColor:
                              isDarkMode ? Colors.black : Colors.white,
                        ),
                        dismissOnTouchOutside: true,
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
                        confirmButton: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdminCreateDev(),
                              ),
                            );
                          },
                          child: Text(
                            'Add Developer',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                      );
                      currentDialog!.show();
                    } else {
                      currentDialog = StylishDialog(
                        context: context,
                        controller: DialogController(
                          listener: (status) {},
                        ),
                        alertType: StylishDialogType.ERROR,
                        style: DefaultStyle(
                          progressColor: Colors.teal,
                          animationLoop: true,
                          backgroundColor:
                              isDarkMode ? Colors.black : Colors.white,
                        ),
                        dismissOnTouchOutside: true,
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
                      currentDialog!.show();
                    }
                  }
                },
                // listenWhen: (previous, current) {
                //   return current is GetUserDevEvent;
                // },
                builder: (context, state) {
                  if (state is AdminCrudDevUserFetched) {
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
                  } else if (state is AdminCrudDevLoading) {
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
                  } else if (state is AdminCrudDevError) {
                    return const Text(
                        'Looks like we hit a snag. Give it another shot!'); // Handle error state
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
                builder: (context) => const AdminCreateDev(),
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
