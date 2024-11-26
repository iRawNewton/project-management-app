import 'package:flutter/material.dart';

class ClientProjectDetails extends StatelessWidget {
  // Example data
  final String projectName = "Project A";
  final String description = "This is a description of Project A.";
  final String managerName = "John Doe";
  final String clientName = "Client XYZ";
  final String startDate = "2024-01-01";
  final String endDate = "2024-12-31";
  final double progress = 0.75;
  final List<String> tags = ["Urgent", "High Priority"];
  final List<String> developers = ["Alice", "Bob", "Charlie"];
  final List<Map<String, dynamic>> subProjects = [
    {
      "subProjectName": "Sub-Project 1",
      "startDate": "2024-02-01",
      "endDate": "2024-06-30",
      "progress": 0.6,
      "tags": ["Design", "Prototype"]
    },
    {
      "subProjectName": "Sub-Project 2",
      "startDate": "2024-07-01",
      "endDate": "2024-12-01",
      "progress": 0.4,
      "tags": ["Development", "Backend"]
    },
  ];
  final List<Map<String, dynamic>> tasks = [
    {"taskName": "Task 1", "assignedTo": "Alice", "progress": 0.8},
    {"taskName": "Task 2", "assignedTo": "Bob", "progress": 0.5},
  ];
  final List<Map<String, dynamic>> payments = [
    {
      "amountReceived": 50000,
      "receivedOn": "2024-03-01",
      "paymentMethod": "Bank Transfer"
    },
    {
      "amountReceived": 70000,
      "receivedOn": "2024-06-01",
      "paymentMethod": "Credit Card"
    },
  ];
  final List<Map<String, dynamic>> dueDates = [
    {"dueDate": "2024-04-01", "cleared": true, "missedCount": 0},
    {"dueDate": "2024-07-01", "cleared": false, "missedCount": 1},
  ];
  final List<Map<String, String>> siteLinks = [
    {"siteUrl": "https://example.com", "userId": "projectUser123"},
  ];
  final List<Map<String, String>> remarks = [
    {
      "userRole": "Manager",
      "userId": "John Doe",
      "remarkText": "Initial planning completed."
    },
  ];
  final List<Map<String, String>> projectHistory = [
    {
      "changeType": "Update",
      "changeDescription": "Changed the project deadline."
    },
  ];
  final List<Map<String, dynamic>> chats = [
    {
      "participants": ["John Doe", "Client XYZ"],
      "messages": ["Message 1", "Message 2"]
    },
  ];
  final List<Map<String, dynamic>> notifications = [
    {"message": "New task assigned", "read": true},
    {"message": "Project deadline approaching", "read": false},
  ];

  ClientProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(projectName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProjectOverview(),
            const SizedBox(height: 20),
            _buildProjectTeam(),
            if (subProjects.isNotEmpty) _buildSubProjects(),
            const SizedBox(height: 20),
            _buildTasks(),
            const SizedBox(height: 20),
            _buildPaymentDetails(),
            const SizedBox(height: 20),
            _buildSiteLinks(),
            const SizedBox(height: 20),
            _buildRemarks(),
            const SizedBox(height: 20),
            _buildProjectHistory(),
            const SizedBox(height: 20),
            _buildChats(),
            const SizedBox(height: 20),
            _buildNotifications(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectOverview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Project Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Project Name: $projectName'),
            Text('Description: $description'),
            Text('Manager: $managerName'),
            Text('Client: $clientName'),
            Text('Start Date: $startDate'),
            Text('End Date: $endDate'),
            LinearProgressIndicator(value: progress),
            Wrap(
              spacing: 8.0,
              children: tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectTeam() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Project Team',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text('Developers:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: developers.map((dev) => Text(dev)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubProjects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sub-Projects',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Column(
          children: subProjects.map((subProject) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sub-Project Name: ${subProject['subProjectName']}'),
                    Text('Start Date: ${subProject['startDate']}'),
                    Text('End Date: ${subProject['endDate']}'),
                    LinearProgressIndicator(value: subProject['progress']),
                    Wrap(
                      spacing: 8.0,
                      children: subProject['tags']
                          .map<Widget>((tag) => Chip(label: Text(tag)))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTasks() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: tasks.map((task) {
                return ListTile(
                  title: Text(task['taskName']),
                  subtitle: Text('Assigned to: ${task['assignedTo']}'),
                  trailing: SizedBox(
                    width: 100, // You can adjust this width as needed
                    child: LinearProgressIndicator(value: task['progress']),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Payment Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: payments.map((payment) {
                return ListTile(
                  title: Text('Amount: ₹${payment['amountReceived']}'),
                  subtitle: Text('Received on: ${payment['receivedOn']}'),
                  trailing: Text(payment['paymentMethod']),
                );
              }).toList(),
            ),
            const Divider(),
            const Text('Due Dates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(
              children: dueDates.map((dueDate) {
                return ListTile(
                  title: Text('Due Date: ${dueDate['dueDate']}'),
                  trailing: dueDate['cleared']
                      ? const Text('Cleared')
                      : Text('Missed ${dueDate['missedCount']} times'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSiteLinks() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Site Links',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: siteLinks.map((siteLink) {
                return ListTile(
                  title: Text(siteLink['siteUrl']!),
                  subtitle: Text('User: ${siteLink['userId']}'),
                  trailing: const Icon(Icons.link),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemarks() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Remarks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: remarks.map((remark) {
                return ListTile(
                  title: Text('${remark['userRole']}: ${remark['userId']}'),
                  subtitle: Text(remark['remarkText']!),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectHistory() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Project History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: projectHistory.map((history) {
                return ListTile(
                  title: Text(history['changeType']!),
                  subtitle: Text(history['changeDescription']!),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChats() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Chats',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: chats.map((chat) {
                return ListTile(
                  title:
                      Text('Participants: ${chat['participants'].join(", ")}'),
                  subtitle: Text(chat['messages'].join("\n")),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifications() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Notifications',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: notifications.map((notification) {
                return ListTile(
                  title: Text(notification['message']),
                  trailing: notification['read']
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.error, color: Colors.red),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
