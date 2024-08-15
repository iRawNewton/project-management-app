# Project Management App Documentation

## User Roles and Permissions:

1. Admin:
   * Full system control
   * Create and manage user accounts (Managers, Developers, Clients).
   * Assign projects to Managers and Developers.
   * View daily tasks, progress reports, and project status for all projects.
   * Monitor and view all chat communications between Managers, Clients, and Developers.
   * Send emails directly from the app.
   * Track payments received and project financials.
   * View project history, task breakdowns, and progress updates.
  
2. Manager:
   * Assign tasks to Developers and manage project progress.
   * Create Client and Developer accounts.
   * Manage projects and sub-projects, assign tasks, and track progress.
   * View only projects they are assigned to.
   * Record payments received (one-time or recurring monthly) and update project financial details.
   * Assign Developers to sub-projects or tasks.
   * Communicate with Clients and Developers through in-app chat and email.
   * View project history, task breakdowns, and detailed progress.
   * Oversee project notifications for tasks, deadlines, and updates.
  
3. Client
   * View overall project progress, payment details, and updates.
   * Track progress on sub-projects and individual tasks.
   * Communicate with Managers via in-app chat.
   * View remarks and updates from Developers.
   * Receive notifications on project progress, payment status, and new remarks.
   * Access project history to review past updates and changes.
  
4. Developer
   * View assigned projects, sub-projects, and specific tasks.
   * Provide daily task updates and progress reports through a remarks section.
   * Submit daily reports via email, which are saved in the database.
   * Update the progress of tasks and sub-projects with visual indicators.
   * Communicate with Managers via in-app chat.
   * Receive notifications for new task assignments, deadlines, and remarks.
   * View project history and task breakdown for each project assigned.
  

-----

## Project Structure

1. Single or Multi-Developer Projects:
   * Projects can have one or more Developers assigned, with the flexibility to reassign as needed.
  
2. Sub-Projects:
   * Projects may include multiple sub-projects (e.g., "Project ABC" can have "ABC Part 1", "ABC Part 2").
   * Sub-projects have individual progress tracking, updates, and payment tracking.
   * If no sub-project exists, all updates occur on the root project.
  
3. Task Breakdown:
   * Sub-projects and main projects contain a breakdown of tasks.
   * Each task has its own progress tracker, deadline, and assigned Developer.
   * Managers can assign specific tasks to individual Developers.
  
4. Progress Tracking:
   * Visual progress indicators (e.g., percentage completion) for each project, sub-project, and task.
   * Start and end dates for each project and sub-project to track timelines effectively.

  ----
  
## Payment Tracking:

1. Types of Payments:
   * One-Time Payment: Clients make payments at specific milestones.
   * Monthly Recurring Payment: For ongoing services, payments are tracked monthly. If a payment is missed, the project is paused until payment is resumed.
  
2. Payment Details:
   * Payment tracking is sub-project specific for multi-phase projects.
   * Clients can view payment details, but the app does not process payment.
  
----

## Communication and Notifications:

1. Remarks Section:
   * Developers provide daily updates and remarks, visible to Admins, Managers, and Clients.
   * Remarks are essential for tracking progress and maintaining project transparency.
  
2. Chats:
   * In-app chat system between Clients and Managers, and between Managers and Developers.
   * Admins can monitor all chat exchanges.
  
3. Email Integration:
   * Users (Admins, Managers, and Developers) can send project-related emails directly from the app.
   * Developers submit daily progress reports through email.
  
4. Notifications:
   * Notifications for:
     * Task assignments and updates
     * Payment reminders and status changes
     * Progress milestones or delays.
     * New remarks or important communications.
    
   * Notifications ensure that users stay updated on critical actions and deadlines.
  

  ----
## Project History:
* A complete history of changes, updates, and remarks for every project and sub-project.
* Admins and Managers can view all historical changes, including task progress, communication logs, and payment records.

----
****

## Database Structure (Firebase Firestore)

1. Users Collection
   ```
   users (Collection)
   └── userId (Document)
         ├── name: String
         ├── email: String
         ├── role: String  // (admin, manager, client, developer)
         ├── profilePictureUrl: String  // Profile picture
         ├── assignedProjects: [projectId]  // List of project IDs assigned to the user
         ├── emergencyTasks: [taskId]  // List of emergency task IDs for the developer
         ├── notifications: [notificationId]  // Notification management
         ├── firstLogin: Timestamp  // Timestamp of the user's first login (null if not logged in)
         ├── lastLogin: Timestamp  // Tracks the user's last login activity
         ├── createdAt: Timestamp
         └── updatedAt: Timestamp
   ```

2. Projects Collection
   ```
   projects (Collection)
   └── projectId (Document)
         ├── projectName: String
         ├── description: String
         ├── managerId: String  // Manager in charge
         ├── clientId: String  // Client related to the project
         ├── developers: [userId]  // List of developer IDs assigned to the project
         ├── subProjects: [subProjectId]  // List of sub-project IDs (optional)
         ├── progress: Number  // Overall project progress (0 to 100)
         ├── startDate: Timestamp
         ├── endDate: Timestamp
         ├── paymentModel: String  // (one-time, recurring)
         ├── remarks: [remarkId]  // List of remark IDs for developer updates
         ├── tasks: [taskId]  // Task breakdown for the project
         ├── projectHistory: [historyId]  // Historical changes for the project
         ├── createdAt: Timestamp
         └── updatedAt: Timestamp 
   ```
   
3. Sub-Projects Collection (Linked to Projects)
   ```
   subProjects (Collection)
   └── subProjectId (Document)
         ├── parentProjectId: String  // Reference to the parent project
         ├── subProjectName: String
         ├── developers: [userId]  // List of developers assigned to the sub-project
         ├── progress: Number  // Sub-project progress
         ├── startDate: Timestamp
         ├── endDate: Timestamp
         ├── tasks: [taskId]  // Task breakdown for the sub-project
         ├── remarks: [remarkId]  // Developer remarks specific to this sub-project
         ├── createdAt: Timestamp
         └── updatedAt: Timestamp
   ```
   
4. Tasks Collection
   ```
   tasks (Collection)
   └── taskId (Document)
         ├── taskName: String
         ├── description: String
         ├── assignedTo: String  // Developer ID assigned to the task
         ├── projectId: String  // Linked project (optional for emergency tasks)
         ├── subProjectId: String  // Linked sub-project (optional)
         ├── emergency: Boolean  // True if an emergency task
         ├── progress: Number  // Task progress (0 to 100)
         ├── dueDate: Timestamp
         ├── createdAt: Timestamp
         └── updatedAt: Timestamp
   ```
   
5. Remarks Collection
   ```
   remarks (Collection)
   └── remarkId (Document)
         ├── projectId: String  // The project to which the remark is related
         ├── subProjectId: String  // Optional for sub-project-specific remarks
         ├── userId: String  // The ID of the user who made the remark (Client, Manager, Developer)
         ├── userRole: String  // Role of the user (client, manager, developer)
         ├── remarkText: String  // The actual remark or update
         ├── createdAt: Timestamp  // When the remark was made
   ```
   
6. Notification Collection
   ```
   notifications (Collection)
   └── notificationId (Document)
         ├── userId: String  // Who receives the notification
         ├── message: String
         ├── type: String  // (taskAssigned, remarkAdded, etc.)
         ├── read: Boolean
         ├── createdAt: Timestamp
   ```
   
7. Project History Collection
   ```
   projectHistory (Collection)
   └── historyId (Document)
         ├── projectId: String
         ├── changeType: String  // (taskAdded, remarkAdded, progressUpdated, etc.)
         ├── changeDescription: String
         ├── userId: String  // Who made the change
         ├── createdAt: Timestamp
   ```


