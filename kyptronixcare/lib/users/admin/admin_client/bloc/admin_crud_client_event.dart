part of 'admin_crud_client_bloc.dart';

sealed class AdminCrudClientEvent extends Equatable {
  const AdminCrudClientEvent();

  @override
  List<Object> get props => [];
}

class CreateUserClientEvent extends AdminCrudClientEvent {
  final String name;
  final String email;

  final String password;
  final String phone;
  final String whatsappNumber;
  final Timestamp dateOfBirth;

  const CreateUserClientEvent({
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

class GetUserClientEvent extends AdminCrudClientEvent {}
