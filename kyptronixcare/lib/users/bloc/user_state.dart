// part of 'user_bloc.dart';

// sealed class UserState extends Equatable {
//   const UserState();

//   @override
//   List<Object> get props => [];
// }

// final class UserInitial extends UserState {}

// class UserLoading extends UserState {}

// class UserSuccess extends UserState {
//   final String userId;

//   const UserSuccess(this.userId);

//   @override
//   List<Object> get props => [userId];
// }

// class UserFailure extends UserState {
//   final String error;

//   const UserFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }

// class EmailAlreadyExists extends UserState {
//   final String email;

//   const EmailAlreadyExists(this.email);

//   @override
//   List<Object> get props => [email];
// }

// class ResetPasswordSuccess extends UserState {}

// class ResetPasswordFailure extends UserState {
//   final String error;

//   const ResetPasswordFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }

// class AdminUsersSuccess extends UserState {
//   final List<UserModel> adminUsers;

//   const AdminUsersSuccess(this.adminUsers);

//   @override
//   List<Object> get props => [adminUsers];
// }

// class AdminUsersFailure extends UserState {
//   final String error;

//   const AdminUsersFailure(this.error);

//   @override
//   List<Object> get props => [error];
// }
