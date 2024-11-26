part of 'admin_crud_bloc.dart';

sealed class AdminCrudEvent extends Equatable {
  const AdminCrudEvent();

  @override
  List<Object> get props => [];
}

class CreateUserAdminEvent extends AdminCrudEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String whatsappNumber;
  final Timestamp dateOfBirth;

  const CreateUserAdminEvent({
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

class GetUserAdminEvent extends AdminCrudEvent {}
