part of 'admin_crud_bloc.dart';

sealed class AdminCrudState extends Equatable {
  const AdminCrudState();

  @override
  List<Object> get props => [];
}

final class AdminCrudInitial extends AdminCrudState {}

class AdminCrudLoading extends AdminCrudState {}

class AdminCrudSuccess extends AdminCrudState {
  final String userId;

  const AdminCrudSuccess(this.userId);
  @override
  List<Object> get props => [userId];
}

class AdminCrudError extends AdminCrudState {
  final String message;
  const AdminCrudError(this.message);
}

class AdminCrudEmailAlreadyExists extends AdminCrudState {
  final String email;

  const AdminCrudEmailAlreadyExists(this.email);
}

class AdminCrudUserCreated extends AdminCrudState {}

class AdminCrudUserUpdated extends AdminCrudState {}

class AdminCrudUserDeleted extends AdminCrudState {}

class AdminCrudUserFetched extends AdminCrudState {
  final List<UserModel> adminUsers;

  const AdminCrudUserFetched(this.adminUsers);
  @override
  List<Object> get props => [adminUsers];
}

/* ---------------------------------- ----- --------------------------------- */
