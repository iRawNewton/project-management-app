part of 'admin_projects_bloc.dart';

sealed class AdminProjectsState extends Equatable {
  const AdminProjectsState();

  @override
  List<Object> get props => [];
}

final class AdminProjectsInitial extends AdminProjectsState {}

class AdminProjectsLoading extends AdminProjectsState {}

class AdminProjectsGetList extends AdminProjectsState {
  final List<ProjectModel> projects;

  const AdminProjectsGetList(this.projects);
  @override
  List<Object> get props => [projects];
}

class AdminProjectsCreatedSuccessfully extends AdminProjectsState {
  final String docRefId;

  const AdminProjectsCreatedSuccessfully(this.docRefId);

  @override
  List<Object> get props => [docRefId];
}

class AdminProjectsCreateFailed extends AdminProjectsState {
  final String errorMessage;

  const AdminProjectsCreateFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class AdminProjectsTeamUpdateLoading extends AdminProjectsState {}

class AdminProjectsTeamUpdateSuccess extends AdminProjectsState {}

class AdminProjectsTeamUpdateFailure extends AdminProjectsState {
  final String errorMessage;

  const AdminProjectsTeamUpdateFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
