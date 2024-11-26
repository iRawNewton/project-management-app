import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kyptronixcare/users/admin/admin_accounts/bloc/admin_crud_bloc.dart';
import 'package:shimmer/shimmer.dart';

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

// class Developer {
//   final String name;
//   final String email;
//   final String role;
//   final String photoUrl;

//   Developer({
//     required this.name,
//     required this.email,
//     required this.role,
//     required this.photoUrl,
//   });
// }

// final List<Developer> developers = [
//   Developer(
//     name: 'John Doe',
//     email: 'john.doe@example.com',
//     role: 'Flutter Developer',
//     photoUrl: 'https://via.placeholder.com/150',
//   ),
//   Developer(
//     name: 'Jane Smith',
//     email: 'jane.smith@example.com',
//     role: 'Backend Developer',
//     photoUrl: 'https://via.placeholder.com/150',
//   ),
//   Developer(
//     name: 'Jane Smith',
//     email: 'jane.smith@example.com',
//     role: 'Backend Developer',
//     photoUrl: 'https://via.placeholder.com/150',
//   ),
//   Developer(
//     name: 'Jane Smith',
//     email: 'jane.smith@example.com',
//     role: 'Backend Developer',
//     photoUrl: 'https://via.placeholder.com/150',
//   ),
//   Developer(
//     name: 'John Doe',
//     email: 'john.doe@example.com',
//     role: 'Flutter Developer',
//     photoUrl: 'https://via.placeholder.com/150',
//   ),
//   Developer(
//     name: 'Jane Smith',
//     email: 'jane.smith@example.com',
//     role: 'Backend Developer',
//     photoUrl: 'https://via.placeholder.com/150',
//   ),
//   Developer(
//     name: 'Jane Smith',
//     email: 'jane.smith@example.com',
//     role: 'Backend Developer',
//     photoUrl: 'https://via.placeholder.com/150',
//   ),
//   Developer(
//     name: 'Jane Smith',
//     email: 'jane.smith@example.com',
//     role: 'Backend Developer',
//     photoUrl: 'https://via.placeholder.com/150',
//   ),
//   // Add more developers here
// ];

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
