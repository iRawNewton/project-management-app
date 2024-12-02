import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/user_model.dart';

part 'admin_crud_dev_event.dart';
part 'admin_crud_dev_state.dart';

class AdminCrudDevBloc extends Bloc<AdminCrudDevEvent, AdminCrudDevState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AdminCrudDevBloc() : super(AdminCrudDevInitial()) {
    on<AdminCrudDevEvent>((event, emit) {});
    on<CreateUserDevEvent>(_createUserDevEvent);
    on<GetUserDevEvent>(_getUserDevEvent);
  }

  Future<void> _createUserDevEvent(
      CreateUserDevEvent event, Emitter<AdminCrudDevState> emit) async {
    emit(AdminCrudDevLoading());
    try {
      // Attempt to create user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Create user in Firestore
      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: event.name,
        email: event.email,
        categoryRole: event.roleType,
        role: event.role,
        profilePictureUrl: '',
        assignedProjects: [],
        emergencyTasks: [],
        notifications: [],
        phone: event.phone,
        whatsappNumber: event.whatsappNumber,
        password: event.password, // Ensure you encrypt this before saving
        firstLogin: Timestamp.now(),
        lastLogin: Timestamp.now(),
        dateOfBirth: event.dateOfBirth,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      await _firestore.collection('users').doc(user.id).set(user.toMap());

      emit(AdminCrudDevSuccess(user.id));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(AdminCrudDevEmailAlreadyExists(event.email));
      } else {
        emit(AdminCrudDevError(e.message ?? 'An error occurred.'));
      }
    } catch (error) {
      emit(AdminCrudDevError(error.toString()));
    }
  }

  Future<void> _getUserDevEvent(
      GetUserDevEvent event, Emitter<AdminCrudDevState> emit) async {
    emit(AdminCrudDevLoading());
    try {
      // Query Firestore for users whose role is one of 'admin', 'projectManager', or 'client'
      QuerySnapshot querySnapshot = await _firestore.collection('users').where(
          'role',
          isNotEqualTo: ['admin', 'projectManager', 'client']).get();

      // Filter out users with these roles
      List<UserModel> adminUsers = querySnapshot.docs
          .where((doc) =>
              !['admin', 'projectManager', 'client'].contains(doc['role']))
          .map((doc) =>
              UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();

      // If no users are found, emit an error
      if (adminUsers.isEmpty) {
        emit(const AdminCrudDevError('No users found.'));
        return;
      }

      // Emit the fetched user data
      emit(AdminCrudDevUserFetched(adminUsers));
    } catch (error) {
      emit(AdminCrudDevError(error.toString()));
    }
  }
}