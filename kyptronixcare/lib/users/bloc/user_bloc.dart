// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../model/user_model.dart';

// part 'user_event.dart';
// part 'user_state.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   UserBloc() : super(UserInitial()) {
//     on<CreateUserEvent>(_onCreateUser);
//     on<ResetPasswordEvent>(_onResetPassword);
//     on<FetchAdminUsersEvent>(_onFetchAdminUsers);
//   }

//   Future<void> _onCreateUser(
//       CreateUserEvent event, Emitter<UserState> emit) async {
//     emit(UserLoading());
//     try {
//       // Attempt to create user in Firebase Authentication
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: event.email,
//         password: event.password,
//       );

//       // Create user in Firestore
//       UserModel user = UserModel(
//         id: userCredential.user!.uid,
//         name: event.name,
//         email: event.email,
//         role: 'admin',
//         profilePictureUrl: '',
//         assignedProjects: [],
//         emergencyTasks: [],
//         notifications: [],
//         phone: event.phone,
//         whatsappNumber: event.whatsappNumber,
//         password: event.password, // Ensure you encrypt this before saving
//         firstLogin: Timestamp.now(),
//         lastLogin: Timestamp.now(),
//         dateOfBirth: event.dateOfBirth,
//         createdAt: Timestamp.now(),
//         updatedAt: Timestamp.now(),
//       );

//       await _firestore.collection('users').doc(user.id).set(user.toMap());

//       emit(UserSuccess(user.id));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         emit(EmailAlreadyExists(event.email));
//       } else {
//         emit(UserFailure(e.message ?? 'An error occurred.'));
//       }
//     } catch (error) {
//       emit(UserFailure(error.toString()));
//     }
//   }

//   Future<void> _onResetPassword(
//       ResetPasswordEvent event, Emitter<UserState> emit) async {
//     emit(UserLoading());
//     try {
//       await _auth.sendPasswordResetEmail(email: event.email);
//       emit(ResetPasswordSuccess());
//     } catch (error) {
//       emit(ResetPasswordFailure(error.toString()));
//     }
//   }

//   Future<void> _onFetchAdminUsers(
//       FetchAdminUsersEvent event, Emitter<UserState> emit) async {
//     emit(UserLoading());
//     try {
//       // Fetch users with the role 'admin'
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('users')
//           .where('role', isEqualTo: 'admin')
//           .get();

//       List<UserModel> adminUsers = querySnapshot.docs.map((doc) {
//         return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();

//       emit(AdminUsersSuccess(adminUsers));
//     } catch (error) {
//       emit(AdminUsersFailure(error.toString()));
//     }
//   }
// }

// /*

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SignUpScreen extends StatelessWidget {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _whatsappController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController(); // Use DatePicker

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign Up')),
//       body: BlocListener<UserBloc, UserState>(
//         listener: (context, state) {
//           if (state is UserSuccess) {
//             // Navigate to another screen or show success message
//           } else if (state is UserFailure) {
//             // Show error message
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
//               TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
//               TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
//               TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Phone')),
//               TextField(controller: _whatsappController, decoration: InputDecoration(labelText: 'WhatsApp Number')),
//               TextField(controller: _dobController, decoration: InputDecoration(labelText: 'Date of Birth')), // Use DatePicker for better UX
//               ElevatedButton(
//                 onPressed: () {
//                   BlocProvider.of<UserBloc>(context).add(CreateUserEvent(
//                     name: _nameController.text,
//                     email: _emailController.text,
//                     password: _passwordController.text,
//                     phone: _phoneController.text,
//                     whatsappNumber: _whatsappController.text,
//                     dateOfBirth: Timestamp.now(), // Replace with actual timestamp from DOB field
//                   ));
//                 },
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// */