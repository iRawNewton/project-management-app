part of 'admin_crud_dev_bloc.dart';

sealed class AdminCrudDevEvent extends Equatable {
  const AdminCrudDevEvent();

  @override
  List<Object> get props => [];
}

class CreateUserDevEvent extends AdminCrudDevEvent {
  final String name;
  final String email;
  final String roleType;
  final String role;

  final String password;
  final String phone;
  final String whatsappNumber;
  final Timestamp dateOfBirth;

  const CreateUserDevEvent({
    required this.name,
    required this.email,
    required this.roleType,
    required this.role,
    required this.password,
    required this.phone,
    required this.whatsappNumber,
    required this.dateOfBirth,
  });

  @override
  List<Object> get props => [
        name,
        email,
        roleType,
        role,
        password,
        phone,
        whatsappNumber,
        dateOfBirth
      ];
}

class GetUserDevEvent extends AdminCrudDevEvent {}
