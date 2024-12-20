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
    on<AdminProjectsConvertToSubProjectsEvent>(_convertProjectToSubProjects);
    on<AdminProjectsAssignTeamEvent>(_adminProjectsAssignTeamEvent);
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
        'dueDates': null,
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

        // Create lists to store user details
        List<UserModel> developers = [];
        List<UserModel> managers = [];
        UserModel? client;

        // Fetch the details for each developer
        for (var developerId in project.developers) {
          var userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(developerId)
              .get();

          if (userDoc.exists) {
            UserModel developer =
                UserModel.fromMap(developerId, userDoc.data()!);
            developers.add(developer);
          }
        }

        // Fetch the details for each manager
        for (var managerId in project.managers) {
          var userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(managerId)
              .get();

          if (userDoc.exists) {
            UserModel manager = UserModel.fromMap(managerId, userDoc.data()!);
            managers.add(manager);
          }
        }

        // Fetch the client details
        if (project.clientId.isNotEmpty) {
          var userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(project.clientId)
              .get();

          if (userDoc.exists) {
            client = UserModel.fromMap(project.clientId, userDoc.data()!);
          }
        }

        // Assign the details to the project model
        project.developersDetails = developers;
        project.managersDetails = managers;
        project.clientDetails = client;

        // Add the project to the list
        projects.add(project);
      }

      // Emit the list of projects after successfully fetching and processing the data
      emit(AdminProjectsGetList(projects));
    } catch (error) {
      // Handle errors by emitting the failure state
      print('7');
      emit(AdminProjectsCreateFailed(error.toString()));
    }
  }

  Future<void> _convertProjectToSubProjects(
    AdminProjectsConvertToSubProjectsEvent event,
    Emitter<AdminProjectsState> emit,
  ) async {
    emit(AdminProjectsLoading());

    try {
      // Reference to Firestore collections
      final projectRef = FirebaseFirestore.instance.collection('projects');
      final subProjectRef =
          FirebaseFirestore.instance.collection('subProjects');
      final taskRef = FirebaseFirestore.instance.collection('tasks');
      final tagRef = FirebaseFirestore.instance.collection('tags');
      // final taskRemarkRef =
      //     FirebaseFirestore.instance.collection('taskRemarks');
      final remarkRef = FirebaseFirestore.instance.collection('remarks');
      final projectHistoryRef =
          FirebaseFirestore.instance.collection('projectHistory');
      final siteLinkRef = FirebaseFirestore.instance.collection('siteLinks');
      final paymentRef = FirebaseFirestore.instance.collection('payments');
      final dueDateRef = FirebaseFirestore.instance.collection('dueDates');

      // Fetch the parent project
      final parentProject = await projectRef.doc(event.projects.id).get();
      if (!parentProject.exists) {
        emit(const AdminProjectsCreateFailed('Parent project not found.'));
        return;
      }

      // Prepare the sub-project data (copy relevant fields)
      final subProjectData = {
        'parentProjectId': event.projects.id,
        'subProjectName': 'Sub Project 1',
        'developers': event.projects.developers,
        'progress': event.projects.progress,
        'startDate': parentProject['startDate'],
        'endDate': parentProject['endDate'],
        'tasks': event.projects.tasks,
        'remarks': event.projects.remarks,
        'tags': event.projects.tags,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Add the sub-project to Firestore
      final subProjectDoc = await subProjectRef.add(subProjectData);

      // Fetch and copy associated tasks
      final tasksQuerySnapshot =
          await taskRef.where('projectId', isEqualTo: event.projects.id).get();

      List<String> taskIds = [];
      for (var task in tasksQuerySnapshot.docs) {
        // Prepare new task data for the sub-project
        final taskData = task.data();
        final newTaskData = {
          'taskName': taskData['taskName'],
          'description': taskData['description'],
          'assignedTo': taskData['assignedTo'],
          'projectId': taskData['projectId'],
          'subProjectId': subProjectDoc.id, // Reference to new sub-project
          'emergency': taskData['emergency'] ?? false,
          'progress': taskData['progress'] ?? 0,
          'status': taskData['status'],
          'dueDate': taskData['dueDate'],
          'remarks': taskData['remarks'] ?? [],
          'createdAt': taskData['createdAt'],
          'updatedAt': taskData['updatedAt'],
        };
        final newTaskDoc = await taskRef.add(newTaskData);
        taskIds.add(newTaskDoc.id);
      }

      // Update sub-project with task IDs
      await subProjectDoc.update({'tasks': taskIds});

      // Fetch and copy associated tags
      final tagsQuerySnapshot =
          await tagRef.where('projectId', isEqualTo: event.projects.id).get();

      List<String> tagIds = [];
      for (var tag in tagsQuerySnapshot.docs) {
        final tagData = tag.data();
        final newTagData = {
          'tagName': tagData['tagName'],
          'createdAt': tagData['createdAt'],
          'updatedAt': tagData['updatedAt'],
        };
        final newTagDoc = await tagRef.add(newTagData);
        tagIds.add(newTagDoc.id);
      }

      // Update sub-project with tag IDs
      await subProjectDoc.update({'tags': tagIds});

      // Fetch and copy associated remarks
      final remarksQuerySnapshot = await remarkRef
          .where('projectId', isEqualTo: event.projects.id)
          .get();

      List<String> remarkIds = [];
      for (var remark in remarksQuerySnapshot.docs) {
        final remarkData = remark.data();
        final newRemarkData = {
          'projectId': remarkData['projectId'],
          'subProjectId': subProjectDoc.id,
          'userId': remarkData['userId'],
          'userRole': remarkData['userRole'],
          'remarkText': remarkData['remarkText'],
          'createdAt': remarkData['createdAt'],
        };
        final newRemarkDoc = await remarkRef.add(newRemarkData);
        remarkIds.add(newRemarkDoc.id);
      }

      // Update sub-project with remark IDs
      await subProjectDoc.update({'remarks': remarkIds});

      // Create project history entry
      final projectHistoryData = {
        'projectId': event.projects.id,
        'changeType': 'Sub-Project Created',
        'changeDescription': 'Sub-project created',
        'userId': 'event.userId',
        'createdAt': FieldValue.serverTimestamp(),
      };
      await projectHistoryRef.add(projectHistoryData);

      // Handle siteLinks, payments, and dueDates (optional, if any)
      // Fetch and transfer Site Links
      final siteLinksQuerySnapshot = await siteLinkRef
          .where('projectId', isEqualTo: event.projects.id)
          .get();

      List<String> siteLinkIds = [];
      for (var siteLink in siteLinksQuerySnapshot.docs) {
        final siteLinkData = siteLink.data();
        final newSiteLinkData = {
          'projectId': event.projects.id,
          'siteUrl': siteLinkData['siteUrl'],
          'userId': siteLinkData['userId'],
          'password': siteLinkData['password'],
          'createdAt': siteLinkData['createdAt'],
          'updatedAt': siteLinkData['updatedAt'],
        };
        final newSiteLinkDoc = await siteLinkRef.add(newSiteLinkData);
        siteLinkIds.add(newSiteLinkDoc.id);
      }

      // Clear the Site Links from the parent project
      for (var siteLink in siteLinksQuerySnapshot.docs) {
        await siteLink.reference.delete();
      }

      // Fetch and transfer Payments
      final paymentsQuerySnapshot = await paymentRef
          .where('projectId', isEqualTo: event.projects.id)
          .get();

      List<String> paymentIds = [];
      for (var payment in paymentsQuerySnapshot.docs) {
        final paymentData = payment.data();
        final newPaymentData = {
          'projectId': event.projects.id,
          'amountReceived': paymentData['amountReceived'],
          'receivedOn': paymentData['receivedOn'],
          'paymentMethod': paymentData['paymentMethod'],
          'dueDateId': paymentData['dueDateId'],
          'createdAt': paymentData['createdAt'],
          'updatedAt': paymentData['updatedAt'],
        };
        final newPaymentDoc = await paymentRef.add(newPaymentData);
        paymentIds.add(newPaymentDoc.id);
      }

      // Clear the Payments from the parent project
      for (var payment in paymentsQuerySnapshot.docs) {
        await payment.reference.delete();
      }

      // Fetch and transfer Due Dates
      final dueDatesQuerySnapshot = await dueDateRef
          .where('projectId', isEqualTo: event.projects.id)
          .get();

      List<String> dueDateIds = [];
      for (var dueDate in dueDatesQuerySnapshot.docs) {
        final dueDateData = dueDate.data();
        final newDueDateData = {
          'projectId': event.projects.id,
          'dueDate': dueDateData['dueDate'],
          'missedCount': dueDateData['missedCount'],
          'cleared': dueDateData['cleared'],
          'createdAt': dueDateData['createdAt'],
          'updatedAt': dueDateData['updatedAt'],
        };
        final newDueDateDoc = await dueDateRef.add(newDueDateData);
        dueDateIds.add(newDueDateDoc.id);
      }

      // Clear the Due Dates from the parent project
      for (var dueDate in dueDatesQuerySnapshot.docs) {
        await dueDate.reference.delete();
      }

      // Update sub-project with site link, payment, and due date references
      await subProjectDoc.update({
        'siteLinks': siteLinkIds,
        'payments': paymentIds,
        'dueDates': dueDateIds,
      });

      emit(AdminProjectsCreatedSuccessfully(subProjectDoc.id));
    } catch (e) {
      emit(const AdminProjectsCreateFailed(
          'An error occurred while converting the project.'));
    }
  }

  Future<void> _adminProjectsAssignTeamEvent(
    AdminProjectsAssignTeamEvent event,
    Emitter<AdminProjectsState> emit,
  ) async {
    emit(AdminProjectsTeamUpdateLoading());

    try {
      // Get the project reference from Firebase
      var projectRef = FirebaseFirestore.instance
          .collection('projects')
          .doc(event.projectId);

      // Get the current document data
      var projectSnapshot = await projectRef.get();

      // Check if the document exists
      if (!projectSnapshot.exists) {
        emit(
          const AdminProjectsTeamUpdateFailure(
            'Project not found. Please check the project ID.',
          ),
        );
        return;
      }

      // Get the current developers or managers list
      List<dynamic> currentUserIds = [];
      if (event.isDeveloper) {
        currentUserIds = projectSnapshot.data()?['developers'] ?? [];
      } else {
        currentUserIds = projectSnapshot.data()?['managers'] ?? [];
      }

      // If currentUserIds is a single string, make it a list for consistency
      if (currentUserIds is String) {
        currentUserIds = [currentUserIds];
      }

      // Ensure event.userIds is iterable, even if it's a single string
      List<String> newUserIds = [];

      // Check if event.userIds is a single string or an iterable
      newUserIds = [event.userIds]; // Wrap single string in a list

      // Filter out the userIds that are already in the list
      newUserIds.removeWhere((userId) => currentUserIds.contains(userId));

      if (newUserIds.isNotEmpty) {
        // If there are new user IDs that are not already assigned, update the list
        if (event.isDeveloper) {
          await projectRef.update({
            'developers': FieldValue.arrayUnion(newUserIds),
          });
        } else {
          await projectRef.update({
            'managers': FieldValue.arrayUnion(newUserIds),
          });
        }

        emit(AdminProjectsTeamUpdateSuccess());
      } else {
        emit(
          const AdminProjectsTeamUpdateFailure(
            'No new users to assign. Users are already assigned.',
          ),
        );
      }
    } catch (error) {
      emit(
        const AdminProjectsTeamUpdateFailure(
          'Surprise! Developer assignment didn’t work. Try Again.',
        ),
      );
    }
  }
}

/*
remmy

uiux
sahil
*/