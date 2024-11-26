import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/user_model.dart';

part 'admin_crud_event.dart';
part 'admin_crud_state.dart';

class AdminCrudBloc extends Bloc<AdminCrudEvent, AdminCrudState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AdminCrudBloc() : super(AdminCrudInitial()) {
    on<CreateUserAdminEvent>(_createUserAdminEvent);
    on<GetUserAdminEvent>(_getUserAdminEvent);
  }

  Future<void> _createUserAdminEvent(
      CreateUserAdminEvent event, Emitter<AdminCrudState> emit) async {
    emit(AdminCrudLoading());
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
        role: 'admin',
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

      emit(AdminCrudSuccess(user.id));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(AdminCrudEmailAlreadyExists(event.email));
      } else {
        emit(AdminCrudError(e.message ?? 'An error occurred.'));
      }
    } catch (error) {
      emit(AdminCrudError(error.toString()));
    }
  }

  Future<void> _getUserAdminEvent(
      GetUserAdminEvent event, Emitter<AdminCrudState> emit) async {
    emit(AdminCrudLoading());
    try {
      // Query Firestore for users with the role 'admin'
      QuerySnapshot adminQuerySnapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'admin')
          .get();

      // Check if any admins were found
      if (adminQuerySnapshot.docs.isEmpty) {
        emit(const AdminCrudError('No admin users found.'));
        return;
      }

      // Convert the documents to a list of UserModel
      List<UserModel> adminUsers = adminQuerySnapshot.docs
          .map((doc) =>
              UserModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();

      emit(AdminCrudUserFetched(adminUsers));
    } catch (error) {
      emit(AdminCrudError(error.toString()));
    }
  }
}
