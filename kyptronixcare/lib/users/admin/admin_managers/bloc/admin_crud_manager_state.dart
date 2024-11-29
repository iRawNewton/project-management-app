part of 'admin_crud_manager_bloc.dart';

sealed class AdminCrudManagerState extends Equatable {
  const AdminCrudManagerState();

  @override
  List<Object> get props => [];
}

final class AdminCrudManagerInitial extends AdminCrudManagerState {}

class AdminCrudManagerLoading extends AdminCrudManagerState {}

class AdminCrudManagerSuccess extends AdminCrudManagerState {
  final String userId;

  const AdminCrudManagerSuccess(this.userId);
  @override
  List<Object> get props => [userId];
}

class AdminCrudManagerError extends AdminCrudManagerState {
  final String message;
  const AdminCrudManagerError(this.message);
}

class AdminCrudManagerEmailAlreadyExists extends AdminCrudManagerState {
  final String email;

  const AdminCrudManagerEmailAlreadyExists(this.email);
}

class AdminCrudUserManagerCreated extends AdminCrudManagerState {}

class AdminCrudUserManagerUpdated extends AdminCrudManagerState {}

class AdminCrudUserManagerDeleted extends AdminCrudManagerState {}

class AdminCrudManagerUserFetched extends AdminCrudManagerState {
  final List<UserModel> adminUsers;

  const AdminCrudManagerUserFetched(this.adminUsers);
  @override
  List<Object> get props => [adminUsers];
}
