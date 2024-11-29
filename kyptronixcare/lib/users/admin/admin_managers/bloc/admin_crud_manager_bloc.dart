import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/user_model.dart';

part 'admin_crud_manager_event.dart';
part 'admin_crud_manager_state.dart';

class AdminCrudManagerBloc
    extends Bloc<AdminCrudManagerEvent, AdminCrudManagerState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AdminCrudManagerBloc() : super(AdminCrudManagerInitial()) {
    on<AdminCrudManagerEvent>((event, emit) {});
    on<CreateUserManagerEvent>(_createUserManagerEvent);
    on<GetUserManagerEvent>(_getUserManagerEvent);
  }

  Future<void> _createUserManagerEvent(
      CreateUserManagerEvent event, Emitter<AdminCrudManagerState> emit) async {
    emit(AdminCrudManagerLoading());
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
        role: 'Manager',
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

      emit(AdminCrudManagerSuccess(user.id));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(AdminCrudManagerEmailAlreadyExists(event.email));
      } else {
        emit(AdminCrudManagerError(e.message ?? 'An error occurred.'));
      }
    } catch (error) {
      emit(AdminCrudManagerError(error.toString()));
    }
  }

  Future<void> _getUserManagerEvent(
      GetUserManagerEvent event, Emitter<AdminCrudManagerState> emit) async {
    emit(AdminCrudManagerLoading());
    try {
      // Query Firestore for users whose role is one of 'admin', 'projectManager', or 'client'
      QuerySnapshot adminQuerySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'Manager')
          .get();

      // Filter out users with these roles

      // If no users are found, emit an error
      if (adminQuerySnapshot.docs.isEmpty) {
        emit(const AdminCrudManagerError('No users found.'));
        return;
      }

      // Convert the documents to a list of UserModel
      List<UserModel> adminUsers = adminQuerySnapshot.docs
          .map((doc) =>
              UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();

      emit(AdminCrudManagerUserFetched(adminUsers));
    } catch (error) {
      emit(AdminCrudManagerError(error.toString()));
    }
  }
}
