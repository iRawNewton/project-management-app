// part of 'user_bloc.dart';

// sealed class UserEvent extends Equatable {
//   const UserEvent();

//   @override
//   List<Object> get props => [];
// }

// class CreateUserEvent extends UserEvent {
//   final String name;
//   final String email;
//   final String password;
//   final String phone;
//   final String whatsappNumber;
//   final Timestamp dateOfBirth;

//   const CreateUserEvent({
//     required this.name,
//     required this.email,
//     required this.password,
//     required this.phone,
//     required this.whatsappNumber,
//     required this.dateOfBirth,
//   });

//   @override
//   List<Object> get props =>
//       [name, email, password, phone, whatsappNumber, dateOfBirth];
// }

// class EmailAlreadyExistsEvent extends UserEvent {
//   final String email;

//   const EmailAlreadyExistsEvent(this.email);

//   @override
//   List<Object> get props => [email];
// }

// class ResetPasswordEvent extends UserEvent {
//   final String email;

//   const ResetPasswordEvent(this.email);

//   @override
//   List<Object> get props => [email];
// }

// class FetchAdminUsersEvent extends UserEvent {}
