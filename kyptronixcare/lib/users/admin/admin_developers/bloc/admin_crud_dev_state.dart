part of 'admin_crud_dev_bloc.dart';

sealed class AdminCrudDevState extends Equatable {
  const AdminCrudDevState();

  @override
  List<Object> get props => [];
}

final class AdminCrudDevInitial extends AdminCrudDevState {}

class AdminCrudDevLoading extends AdminCrudDevState {}

class AdminCrudDevSuccess extends AdminCrudDevState {
  final String userId;

  const AdminCrudDevSuccess(this.userId);
  @override
  List<Object> get props => [userId];
}

class AdminCrudDevError extends AdminCrudDevState {
  final String message;
  const AdminCrudDevError(this.message);
}

class AdminCrudDevEmailAlreadyExists extends AdminCrudDevState {
  final String email;

  const AdminCrudDevEmailAlreadyExists(this.email);
}

class AdminCrudUserDevCreated extends AdminCrudDevState {}

class AdminCrudUserDevUpdated extends AdminCrudDevState {}

class AdminCrudUserDevDeleted extends AdminCrudDevState {}

class AdminCrudDevUserFetched extends AdminCrudDevState {
  final List<UserModel> adminUsers;

  const AdminCrudDevUserFetched(this.adminUsers);
  @override
  List<Object> get props => [adminUsers];
}
