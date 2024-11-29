import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/user_model.dart';

part 'admin_crud_client_event.dart';
part 'admin_crud_client_state.dart';

class AdminCrudClientBloc
    extends Bloc<AdminCrudClientEvent, AdminCrudClientState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AdminCrudClientBloc() : super(AdminCrudClientInitial()) {
    on<AdminCrudClientEvent>((event, emit) {});
    on<CreateUserClientEvent>(_createUserClientEvent);
    on<GetUserClientEvent>(_getUserClientEvent);
  }

  Future<void> _createUserClientEvent(
      CreateUserClientEvent event, Emitter<AdminCrudClientState> emit) async {
    emit(AdminCrudClientLoading());

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
        role: 'Client',
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

      emit(AdminCrudClientSuccess(user.id));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(AdminCrudClientEmailAlreadyExists(event.email));
      } else {
        emit(AdminCrudClientError(e.message ?? 'An error occurred.'));
      }
    } catch (error) {
      emit(AdminCrudClientError(error.toString()));
    }
  }

  Future<void> _getUserClientEvent(
      GetUserClientEvent event, Emitter<AdminCrudClientState> emit) async {
    emit(AdminCrudClientLoading());
    try {
      // Query Firestore for users whose role is one of 'admin', 'projectManager', or 'client'
      QuerySnapshot adminQuerySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'Client')
          .get();

      // Filter out users with these roles

      // If no users are found, emit an error
      if (adminQuerySnapshot.docs.isEmpty) {
        emit(const AdminCrudClientError('No users found.'));
        return;
      }

      // Convert the documents to a list of UserModel
      List<UserModel> adminUsers = adminQuerySnapshot.docs
          .map((doc) =>
              UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();

      emit(AdminCrudClientUserFetched(adminUsers));
    } catch (error) {
      emit(AdminCrudClientError(error.toString()));
    }
  }
}
