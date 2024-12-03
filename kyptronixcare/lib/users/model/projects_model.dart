import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart'; // Assuming you have UserModel in a separate file

class ProjectModel {
  final String id;
  final String projectName;
  final String description;
  final String clientId;
  final List<String> developers; // List of developer IDs
  final List<String> managers; // List of manager IDs
  List<UserModel> developersDetails; // List of developer details
  List<UserModel> managersDetails; // List of manager details
  UserModel? clientDetails; // Client details (1 client per project)
  final List<String>? subProjects;
  final int? progress;
  final List<String>? payments;
  final List<String>? dueDates;
  final List<String>? siteLinks;
  final List<String>? remarks;
  final List<String>? tasks;
  final List<String>? tags;
  final List<String>? projectHistory;
  final List<String>? chats;
  final Timestamp? startDate;
  final Timestamp? endDate;
  final String? paymentModel;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  ProjectModel({
    required this.id,
    required this.projectName,
    required this.description,
    required this.clientId,
    required this.developers,
    required this.managers,
    this.developersDetails = const [],
    this.managersDetails = const [],
    this.clientDetails,
    this.subProjects,
    this.progress,
    this.payments,
    this.dueDates,
    this.siteLinks,
    this.remarks,
    this.tasks,
    this.tags,
    this.projectHistory,
    this.chats,
    this.startDate,
    this.endDate,
    this.paymentModel,
    required this.createdAt,
    required this.updatedAt,
  });

  // Method to convert ProjectModel to Map
  Map<String, dynamic> toMap() {
    return {
      'projectName': projectName,
      'description': description,
      'clientId': clientId,
      'developers': developers,
      'managers': managers,
      'subProjects': subProjects,
      'progress': progress,
      'payments': payments,
      'dueDates': dueDates,
      'siteLinks': siteLinks,
      'remarks': remarks,
      'tasks': tasks,
      'tags': tags,
      'projectHistory': projectHistory,
      'chats': chats,
      'startDate': startDate,
      'endDate': endDate,
      'paymentModel': paymentModel,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Method to create a ProjectModel from a Map
  factory ProjectModel.fromMap(String id, Map<String, dynamic> map) {
    try {
      return ProjectModel(
        id: id,
        projectName: map['projectName'] ?? '',
        description: map['description'] ?? '',
        clientId: map['clientId'] ?? '',
        developers: List<String>.from(map['developers'] ?? []),
        managers: List<String>.from(map['managers'] ?? []),
        developersDetails: [], // Start with an empty list for developer details
        managersDetails: [], // Start with an empty list for manager details
        clientDetails: null, // We will fetch the client details separately
        subProjects: List<String>.from(map['subProjects'] ?? []),
        progress: map['progress'] ?? 0,
        payments: List<String>.from(map['payments'] ?? []),
        dueDates: List<String>.from(map['dueDates'] ?? []),
        siteLinks: List<String>.from(map['siteLinks'] ?? []),
        remarks: List<String>.from(map['remarks'] ?? []),
        tasks: List<String>.from(map['tasks'] ?? []),
        tags: List<String>.from(map['tags'] ?? []),
        projectHistory: List<String>.from(map['projectHistory'] ?? []),
        chats: List<String>.from(map['chats'] ?? []),
        startDate: map['startDate'] ?? Timestamp.now(),
        endDate: map['endDate'] ?? Timestamp.now(),
        paymentModel: map['paymentModel'] ?? '',
        createdAt: map['createdAt'] ?? Timestamp.now(),
        updatedAt: map['updatedAt'] ?? Timestamp.now(),
      );
    } catch (e) {
      // Handle any errors during parsing the data
      print("Error creating ProjectModel from map: $e");
      rethrow;
    }
  }
}
