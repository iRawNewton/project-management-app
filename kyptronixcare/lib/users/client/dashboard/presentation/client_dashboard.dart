import 'package:flutter/material.dart';
import 'package:kyptronixcare/users/client/dashboard/widgets/client_payment_history.dart';
import 'package:kyptronixcare/users/client/services/presentation/client_services.dart';

import '../widgets/client_project_overview.dart';

class ClientDashboard extends StatelessWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Client Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Handle logout
              },
            ),
          ],
        ),
        drawer: const _NavigationDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 20),
              _buildSectionTitle('Project Overview'),
              const ClientProjectOverview(),
              const SizedBox(height: 20),
              _buildSectionTitle('Payments'),
              const ClientPaymentHistory(),
              const SizedBox(height: 20),
              _buildSectionTitle('Communication'),
              _buildCommunicationSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              'https://picsum.photos/200/300'), // Replace with actual image
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Client Name',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Client Role or Company',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCommunicationSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.chat_bubble, color: Colors.blue),
        title: const Text('In-App Chat with Managers'),
        subtitle: const Text('You have 3 unread messages'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Handle navigation to chat
        },
      ),
    );
  }
}

class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://picsum.photos/200/300'), // Replace with actual image
                ),
                SizedBox(height: 10),
                Text(
                  'Client Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Client Role or Company',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', () {
            // Handle navigation to Dashboard
          }),
          _buildDrawerItem(Icons.view_list, 'Project Overview', () {
            // Handle navigation to Project Overview
          }),
          _buildDrawerItem(Icons.payment, 'Payments', () {
            // Handle navigation to Payments
          }),
          _buildDrawerItem(Icons.update, 'Updates', () {
            // Handle navigation to Updates
          }),
          _buildDrawerItem(Icons.chat, 'Communication', () {
            // Handle navigation to Communication
          }),
          _buildDrawerItem(Icons.history, 'History', () {
            // Handle navigation to History
          }),
          _buildDrawerItem(Icons.room_service, 'Services', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ClientServicesPage(),
              ),
            );
            // Handle navigation to History
          }),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
