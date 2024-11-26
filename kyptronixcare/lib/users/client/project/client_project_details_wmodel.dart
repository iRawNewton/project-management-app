// import 'package:flutter/material.dart';

// class ProjectPage extends StatelessWidget {
//   final Project project; // Assuming you have a Project model

//   ProjectPage({required this.project});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(project.projectName),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildProjectOverview(),
//             SizedBox(height: 20),
//             _buildProjectTeam(),
//             if (project.subProjects.isNotEmpty) _buildSubProjects(),
//             SizedBox(height: 20),
//             _buildTasks(),
//             SizedBox(height: 20),
//             _buildPaymentDetails(),
//             SizedBox(height: 20),
//             _buildSiteLinks(),
//             SizedBox(height: 20),
//             _buildRemarks(),
//             SizedBox(height: 20),
//             _buildProjectHistory(),
//             SizedBox(height: 20),
//             _buildChats(),
//             SizedBox(height: 20),
//             _buildNotifications(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProjectOverview() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Project Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text('Project Name: ${project.projectName}'),
//             Text('Description: ${project.description}'),
//             Text('Manager: ${project.managerName}'),
//             Text('Client: ${project.clientName}'),
//             Text('Start Date: ${project.startDate}'),
//             Text('End Date: ${project.endDate}'),
//             LinearProgressIndicator(value: project.progress / 100),
//             Wrap(
//               spacing: 8.0,
//               children: project.tags.map((tag) => Chip(label: Text(tag))).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProjectTeam() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Project Team', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text('Developers:'),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: project.developers.map((dev) => Text(dev.name)).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSubProjects() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Sub-Projects', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//         SizedBox(height: 10),
//         Column(
//           children: project.subProjects.map((subProject) {
//             return Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Sub-Project Name: ${subProject.subProjectName}'),
//                     Text('Start Date: ${subProject.startDate}'),
//                     Text('End Date: ${subProject.endDate}'),
//                     LinearProgressIndicator(value: subProject.progress / 100),
//                     Wrap(
//                       spacing: 8.0,
//                       children: subProject.tags.map((tag) => Chip(label: Text(tag))).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildTasks() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Column(
//               children: project.tasks.map((task) {
//                 return ListTile(
//                   title: Text(task.taskName),
//                   subtitle: Text('Assigned to: ${task.assignedTo}'),
//                   trailing: LinearProgressIndicator(value: task.progress / 100),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentDetails() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Payment Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Column(
//               children: project.payments.map((payment) {
//                 return ListTile(
//                   title: Text('Amount: ₹${payment.amountReceived}'),
//                   subtitle: Text('Received on: ${payment.receivedOn}'),
//                   trailing: Text(payment.paymentMethod),
//                 );
//               }).toList(),
//             ),
//             Divider(),
//             Text('Due Dates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Column(
//               children: project.dueDates.map((dueDate) {
//                 return ListTile(
//                   title: Text('Due Date: ${dueDate.dueDate}'),
//                   trailing: dueDate.cleared ? Text('Cleared') : Text('Missed ${dueDate.missedCount} times'),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSiteLinks() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Site Links', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Column(
//               children: project.siteLinks.map((siteLink) {
//                 return ListTile(
//                   title: Text(siteLink.siteUrl),
//                   subtitle: Text('User: ${siteLink.userId}'),
//                   trailing: Icon(Icons.link),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRemarks() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Remarks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Column(
//               children: project.remarks.map((remark) {
//                 return ListTile(
//                   title: Text('${remark.userRole}: ${remark.userId}'),
//                   subtitle: Text(remark.remarkText),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProjectHistory() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Project History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Column(
//               children: project.projectHistory.map((history) {
//                 return ListTile(
//                   title: Text(history.changeType),
//                   subtitle: Text(history.changeDescription),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildChats() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Chats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Column(
//               children: project.chats.map((chat) {
//                 return ListTile(
//                   title: Text('Chat between: ${chat.participants.join(', ')}'),
//                   subtitle: Text('Messages: ${chat.messages.length}'),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNotifications() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Notifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Column(
//               children: project.notifications.map((notification) {
//                 return ListTile(
//                   title: Text(notification.message),
//                   trailing: notification.read ? Icon(Icons.check) : Icon(Icons.new_releases),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
