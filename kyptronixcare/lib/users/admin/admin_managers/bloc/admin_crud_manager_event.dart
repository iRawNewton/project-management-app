part of 'admin_crud_manager_bloc.dart';

sealed class AdminCrudManagerEvent extends Equatable {
  const AdminCrudManagerEvent();

  @override
  List<Object> get props => [];
}

class CreateUserManagerEvent extends AdminCrudManagerEvent {
  final String name;
  final String email;

  final String password;
  final String phone;
  final String whatsappNumber;
  final Timestamp dateOfBirth;

  const CreateUserManagerEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.whatsappNumber,
    required this.dateOfBirth,
  });

  @override
  List<Object> get props =>
      [name, email, password, phone, whatsappNumber, dateOfBirth];
}

class GetUserManagerEvent extends AdminCrudManagerEvent {}
