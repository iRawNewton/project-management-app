import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? role; // Role is now optional
  final String? categoryRole; // Added categoryRole, optional
  final String profilePictureUrl;
  final List<String> assignedProjects;
  final List<String> emergencyTasks;
  final List<String> notifications;
  final String phone;
  final String whatsappNumber;
  final String password; // Store only encrypted password
  final Timestamp firstLogin;
  final Timestamp lastLogin;
  final Timestamp dateOfBirth;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.role, // Optional role
    this.categoryRole, // Optional categoryRole
    required this.profilePictureUrl,
    required this.assignedProjects,
    required this.emergencyTasks,
    required this.notifications,
    required this.phone,
    required this.whatsappNumber,
    required this.password,
    required this.firstLogin,
    required this.lastLogin,
    required this.dateOfBirth,
    required this.createdAt,
    required this.updatedAt,
  });

  // Method to convert UserModel to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role, // Optional
      'categoryRole': categoryRole, // Optional
      'profilePictureUrl': profilePictureUrl,
      'assignedProjects': assignedProjects,
      'emergencyTasks': emergencyTasks,
      'notifications': notifications,
      'phone': phone,
      'whatsappNumber': whatsappNumber,
      'password': password, // Store encrypted
      'firstLogin': firstLogin,
      'lastLogin': lastLogin,
      'dateOfBirth': dateOfBirth,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Method to create a UserModel from a Map
  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'], // Optional
      categoryRole: map['categoryRole'], // Optional
      profilePictureUrl: map['profilePictureUrl'] ?? '',
      assignedProjects: List<String>.from(map['assignedProjects'] ?? []),
      emergencyTasks: List<String>.from(map['emergencyTasks'] ?? []),
      notifications: List<String>.from(map['notifications'] ?? []),
      phone: map['phone'] ?? '',
      whatsappNumber: map['whatsappNumber'] ?? '',
      password: map['password'] ?? '',
      firstLogin: map['firstLogin'] ?? Timestamp.now(),
      lastLogin: map['lastLogin'] ?? Timestamp.now(),
      dateOfBirth: map['dateOfBirth'] ?? Timestamp.now(),
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
    );
  }
}
