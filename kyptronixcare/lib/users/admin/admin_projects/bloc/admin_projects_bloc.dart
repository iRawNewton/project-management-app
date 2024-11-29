import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'admin_projects_event.dart';
part 'admin_projects_state.dart';

class AdminProjectsBloc extends Bloc<AdminProjectsEvent, AdminProjectsState> {
  AdminProjectsBloc() : super(AdminProjectsInitial()) {
    on<AdminProjectsEvent>((event, emit) {});
    on<AdminProjectsCreateEvent>(_adminProjectsCreateEvent);
  }

  Future<void> _adminProjectsCreateEvent(
      AdminProjectsCreateEvent event, Emitter<AdminProjectsState> emit) async {
    // Start loading state
    emit(AdminProjectsLoading());

    try {
      // Prepare the project data from the event
      final Map<String, dynamic> projectData = {
        'projectName': event.projectName,
        'description': event.description,
        'clientId': event.clientId,
        'developers': event.developers,
        'subProjects': event.subProjects,
        'progress': event.progress,
        'startDate': [],
        'endDate': [],
        'paymentModel': null,
        'payments': event.payments,
        'dueDates': event.dueDates,
        'siteLinks': event.siteLinks,
        'remarks': event.remarks,
        'tasks': event.tasks,
        'tags': event.tags,
        'projectHistory': event.projectHistory,
        'chats': event.chats,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Reference to Firestore projects collection
      final projectRef = FirebaseFirestore.instance.collection('projects');

      // Add the project data to Firestore
      final docRef = await projectRef.add(projectData);

      // Handle the success of the operation
      if (docRef.id.isNotEmpty) {
        emit(AdminProjectsCreatedSuccessfully(docRef.id));
      } else {
        emit(const AdminProjectsCreateFailed(
            'Failed to create project, try again later.'));
      }
    } catch (e) {
      // Handle errors (e.g., network issues, Firebase exceptions)
      emit(const AdminProjectsCreateFailed(
          'An error occurred while creating the project.'));
    }
  }
}


/*

projects (Collection)

projectName: String
description: String

clientId: String  
developers: [userId]  
subProjects: [subProjectId] 
progress: Number  // Overall project progress (0 to 100)
startDate: Timestamp
endDate: Timestamp
paymentModel: String  // (one-time, recurring)
payments: [paymentId]  // List of payment records

dueDates: [dueDateId]  // List of due dates

siteLinks: [siteLinkId]  // List of site links with user ID and password
remarks: [remarkId]  // List of remark IDs for developer updates
tasks: [taskId]  // Task breakdown for the project
tags: [tagId]  // List of tag IDs associated with the project
projectHistory: [historyId]  // Historical changes for the project
chats: [chatId]  // List of chat IDs for project-specific conversations
createdAt: Timestamp
updatedAt: Timestamp


*/