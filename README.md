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
