import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../model/projects_model.dart';
import '../../../model/user_model.dart';

part 'admin_projects_event.dart';
part 'admin_projects_state.dart';

class AdminProjectsBloc extends Bloc<AdminProjectsEvent, AdminProjectsState> {
  AdminProjectsBloc() : super(AdminProjectsInitial()) {
    on<AdminProjectsEvent>((event, emit) {});
    on<AdminProjectsCreateEvent>(_adminProjectsCreateEvent);
    on<AdminProjectsReadEvent>(_adminProjectsReadEvent);
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
        'developers': [],
        'subProjects': [],
        'managers': [],
        'progress': 0,
        'startDate': null,
        'endDate': null,
        'paymentModel': null,
        'payments': [],
        'dueDates': [],
        'siteLinks': [],
        'remarks': [],
        'tasks': [],
        'tags': [],
        'projectHistory': [],
        'chats': [],
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

  Future<void> _adminProjectsReadEvent(
      AdminProjectsReadEvent event, Emitter<AdminProjectsState> emit) async {
    try {
      print('object');
      // Emit loading state while fetching the data
      emit(AdminProjectsLoading());

      // Fetch the projects collection
      final projectsSnapshot =
          await FirebaseFirestore.instance.collection('projects').get();

      // Create a list to hold project details along with user data
      List<ProjectModel> projects = [];

      for (var projectDoc in projectsSnapshot.docs) {
        // Retrieve the project data from the snapshot
        var projectData = projectDoc.data();

        // Create a project model (assuming you have a ProjectModel for handling project data)
        ProjectModel project = ProjectModel.fromMap(projectDoc.id, projectData);

        // Create a list to store developers' details
        List<UserModel> developers = [];

        // Fetch the details for each developer
        for (var developerId in project.developers) {
          // Fetch the user details from the users collection
          var userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(developerId)
              .get();

          if (userDoc.exists) {
            // Add the user data to the developers list
            UserModel developer =
                UserModel.fromMap(developerId, userDoc.data()!);
            developers.add(developer);
          }
        }

        project.developersDetails = developers;

        projects.add(project);
      }

      emit(AdminProjectsGetList(projects));
    } catch (error) {
      emit(AdminProjectsCreateFailed(error.toString()));
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