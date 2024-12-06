part of 'admin_projects_bloc.dart';

sealed class AdminProjectsEvent extends Equatable {
  const AdminProjectsEvent();

  @override
  List<Object> get props => [];
}

class AdminProjectsCreateEvent extends AdminProjectsEvent {
  final String projectName, description, clientId, paymentModel;
  final List<String> developers,
      subProjects,
      payments,
      siteLinks,
      remarks,
      tasks,
      tags,
      projectHistory,
      chats;
  final int progress;
  final DateTime startDate, endDate, createdAt, updatedAt;
  final List<DateTime> dueDates;

  const AdminProjectsCreateEvent(
      this.projectName,
      this.description,
      this.clientId,
      this.paymentModel,
      this.developers,
      this.subProjects,
      this.payments,
      this.siteLinks,
      this.remarks,
      this.tasks,
      this.tags,
      this.projectHistory,
      this.chats,
      this.progress,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.dueDates);

  @override
  List<Object> get props => [
        projectName,
        description,
        clientId,
        developers,
        subProjects,
        progress,
        startDate,
        endDate,
        paymentModel,
        payments,
        dueDates,
        siteLinks,
        remarks,
        tasks,
        tags,
        projectHistory,
        chats,
        createdAt,
        updatedAt,
      ];
}

class AdminProjectsReadClientEvent extends AdminProjectsEvent {}

class AdminProjectsReadEvent extends AdminProjectsEvent {}

class AdminProjectsUpdateEvent extends AdminProjectsEvent {}

class AdminProjectsDeleteEvent extends AdminProjectsEvent {}

class AdminProjectsConvertToSubProjectsEvent extends AdminProjectsEvent {
  final ProjectModel projects;

  const AdminProjectsConvertToSubProjectsEvent(this.projects);
  @override
  List<Object> get props => [projects];
}

class AdminProjectsAssignTeamEvent extends AdminProjectsEvent {
  final String userIds, projectId;
  final bool isDeveloper;

  const AdminProjectsAssignTeamEvent(
      this.userIds, this.isDeveloper, this.projectId);

  @override
  List<Object> get props => [userIds, isDeveloper, projectId];
}
