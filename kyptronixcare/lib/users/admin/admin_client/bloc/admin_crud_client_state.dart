part of 'admin_crud_client_bloc.dart';

sealed class AdminCrudClientState extends Equatable {
  const AdminCrudClientState();

  @override
  List<Object> get props => [];
}

final class AdminCrudClientInitial extends AdminCrudClientState {}

class AdminCrudClientLoading extends AdminCrudClientState {}

class AdminCrudClientSuccess extends AdminCrudClientState {
  final String userId;

  const AdminCrudClientSuccess(this.userId);
  @override
  List<Object> get props => [userId];
}

class AdminCrudClientError extends AdminCrudClientState {
  final String message;
  const AdminCrudClientError(this.message);
}

class AdminCrudClientEmailAlreadyExists extends AdminCrudClientState {
  final String email;

  const AdminCrudClientEmailAlreadyExists(this.email);
}

class AdminCrudUserClientCreated extends AdminCrudClientState {}

class AdminCrudUserClientUpdated extends AdminCrudClientState {}

class AdminCrudUserClientDeleted extends AdminCrudClientState {}

class AdminCrudClientUserFetched extends AdminCrudClientState {
  final List<UserModel> adminUsers;

  const AdminCrudClientUserFetched(this.adminUsers);
  @override
  List<Object> get props => [adminUsers];
}
