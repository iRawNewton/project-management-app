### Users Collection

```plaintext
users (Collection)
└── userId (Document)
      ├── name: String
      ├── email: String
      ├── role: String  // (admin, manager, client, developer)
      ├── profilePictureUrl: String  // Profile picture
      ├── assignedProjects: [projectId]  // List of project IDs assigned to the user
      ├── emergencyTasks: [taskId]  // List of emergency task IDs for the developer
      ├── notifications: [notificationId]  // Notification management
      ├── phone: String  // User's phone number
      ├── whatsappNumber: String  // User's WhatsApp number
      ├── password: String  // Encrypted user password
      ├── firstLogin: Timestamp  // Timestamp of the user's first login (null if not logged in)
      ├── lastLogin: Timestamp  // Tracks the user's last login activity
      ├── dateOfBirth: Timestamp  // Developer's date of birth
      ├── createdAt: Timestamp
      └── updatedAt: Timestamp
```

### Projects Collection

```plaintext
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
      ├── payments: [paymentId]  // List of payment records
      ├── dueDates: [dueDateId]  // List of due dates
      ├── siteLinks: [siteLinkId]  // List of site links with user ID and password
      ├── remarks: [remarkId]  // List of remark IDs for developer updates
      ├── tasks: [taskId]  // Task breakdown for the project
      ├── tags: [tagId]  // List of tag IDs associated with the project
      ├── projectHistory: [historyId]  // Historical changes for the project
      ├── chats: [chatId]  // List of chat IDs for project-specific conversations
      ├── createdAt: Timestamp
      └── updatedAt: Timestamp
```

#### Json Structure

```json
{
  "projects": {
    "projectId": {
      "projectName": "Main Project",
      "description": "Description of the main project",
      "managerId": "manager123",
      "clientId": "client456",
      "developers": ["userId1", "userId2"],
      "subProjects": ["subProjectId1", "subProjectId2"],  // Array of dynamic sub-project IDs
      "progress": 60,
      "startDate": "2024-01-01",
      "endDate": "2024-06-01",
      "paymentModel": "recurring",
      "payments": ["paymentId1", "paymentId2"],
      "dueDates": ["dueDateId1", "dueDateId2"],
      "siteLinks": ["siteLinkId1", "siteLinkId2"],
      "remarks": ["remarkId1"],
      "tags": ["tagId1", "tagId2"],
      "projectHistory": ["historyId1", "historyId2"],
      "chats": ["chatId1"],
      "createdAt": "2024-01-01",
      "updatedAt": "2024-01-01"
    },
    "subProjects": {
      "subProjectId1": {
        "projectName": "Sub Project 1",
        "description": "Description of sub-project 1",
        "managerId": "manager123",
        "clientId": "client456",
        "developers": ["userId1"],
        "mainProjectId": "projectId",  // Link to the main project
        "progress": 40,
        "startDate": "2024-02-01",
        "endDate": "2024-03-01",
        "paymentModel": "recurring",
        "payments": ["paymentId3"],
        "dueDates": ["dueDateId3"],
        "siteLinks": ["siteLinkId3"],
        "remarks": ["remarkId2"],
        "tasks": ["taskId3", "taskId4"],
        "tags": ["tagId3"],
        "projectHistory": ["historyId3"],
        "chats": ["chatId2"],
        "createdAt": "2024-02-01",
        "updatedAt": "2024-02-01"
      },
      "subProjectId2": {
        "projectName": "Sub Project 2",
        "description": "Description of sub-project 2",
        "managerId": "manager123",
        "clientId": "client456",
        "developers": ["userId2"],
        "mainProjectId": "projectId",  // Link to the main project
        "progress": 30,
        "startDate": "2024-03-01",
        "endDate": "2024-04-01",
        "paymentModel": "recurring",
        "payments": ["paymentId4"],
        "dueDates": ["dueDateId4"],
        "siteLinks": ["siteLinkId4"],
        "remarks": ["remarkId3"],
        "tasks": ["taskId5", "taskId6"],
        "tags": ["tagId4"],
        "projectHistory": ["historyId4"],
        "chats": ["chatId3"],
        "createdAt": "2024-03-01",
        "updatedAt": "2024-03-01"
      }
    },
    "tasks": {
      "taskId1": {
        "title": "Task 1 for Main Project",
        "description": "Description of task 1",
        "assignedTo": ["userId1"],
        "status": "in-progress",
        "dueDate": "2024-01-15",
        "projectId": "projectId",
        "subProjectId": null  // This is part of the main project
      },
      "taskId3": {
        "title": "Task 1 for Sub Project 1",
        "description": "Description of task 1 for sub-project",
        "assignedTo": ["userId1"],
        "status": "in-progress",
        "dueDate": "2024-02-15",
        "projectId": "projectId",
        "subProjectId": "subProjectId1"  // This task is for sub-project 1
      },
      "taskId4": {
        "title": "Task 2 for Sub Project 1",
        "description": "Description of task 2 for sub-project",
        "assignedTo": ["userId1"],
        "status": "completed",
        "dueDate": "2024-02-20",
        "projectId": "projectId",
        "subProjectId": "subProjectId1"
      }
    },
    "payments": {
      "paymentId1": {
        "amount": 1000,
        "date": "2024-01-10",
        "status": "completed",
        "projectId": "projectId"
      },
      "paymentId2": {
        "amount": 2000,
        "date": "2024-02-10",
        "status": "completed",
        "projectId": "projectId"
      },
      "paymentId3": {
        "amount": 500,
        "date": "2024-02-15",
        "status": "completed",
        "projectId": "subProjectId1"
      }
    },
    "dueDates": {
      "dueDateId1": {
        "title": "Main Project Phase 1 Due",
        "date": "2024-02-01",
        "projectId": "projectId"
      },
      "dueDateId3": {
        "title": "Sub Project 1 Task Due",
        "date": "2024-02-15",
        "projectId": "subProjectId1"
      }
    },
    "siteLinks": {
      "siteLinkId1": {
        "url": "http://mainprojectsite.com",
        "username": "admin",
        "password": "securepassword",
        "projectId": "projectId"
      },
      "siteLinkId3": {
        "url": "http://subprojectsite.com",
        "username": "user",
        "password": "subpassword",
        "projectId": "subProjectId1"
      }
    },
    "remarks": {
      "remarkId1": {
        "comment": "Remark for the main project",
        "authorId": "userId1",
        "date": "2024-01-05",
        "projectId": "projectId"
      },
      "remarkId2": {
        "comment": "Remark for Sub Project 1",
        "authorId": "userId2",
        "date": "2024-02-10",
        "projectId": "subProjectId1"
      }
    }
  }
}
```

### Sub-Projects Collection (Linked to Projects)

```plaintext
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
      ├── tags: [tagId]  // List of tag IDs associated with the sub-project
      ├── createdAt: Timestamp
      └── updatedAt: Timestamp
```

### Tags Collection

```plaintext
tags (Collection)
└── tagId (Document)
      ├── tagName: String  // The name of the tag (e.g., "Urgent", "High Priority")
      ├── createdAt: Timestamp
      └── updatedAt: Timestamp
```

### Tasks Collection

```plaintext
tasks (Collection)
└── taskId (Document)
      ├── taskName: String
      ├── description: String  // Task description
      ├── assignedTo: String  // Developer ID assigned to the task
      ├── projectId: String  // Linked project (optional for emergency tasks)
      ├── subProjectId: String  // Linked sub-project (optional)
      ├── emergency: Boolean  // True if an emergency task
      ├── progress: Number  // Task progress (0 to 100)
      ├── status: String  // Task status (Not Started, Doing, Done)
      ├── dueDate: Timestamp
      ├── remarks: [taskRemarkId]  // List of remark IDs for the task (optional)
      ├── createdAt: Timestamp
      └── updatedAt: Timestamp
```

### Task Remarks Collection

```plaintext
taskRemarks (Collection)
└── taskRemarkId (Document)
      ├── taskId: String  // Reference to the task
      ├── userId: String  // Developer who added the remark
      ├── userRole: String  // Role of the user (developer, manager)
      ├── remarkText: String  // Detailed remark or update on the task
      ├── statusUpdate: String  // Optional task status update (Not Started, Doing, Done)
      ├── createdAt: Timestamp
```

### Remarks Collection

```plaintext
remarks (Collection)
└── remarkId (Document)
      ├── projectId: String  // The project to which the remark is related
      ├── subProjectId: String  // Optional for sub-project-specific remarks
      ├── userId: String  // The ID of the user who made the remark (Client, Manager, Developer)
      ├── userRole: String  // Role of the user (client, manager, developer)
      ├── remarkText: String  // The actual remark or update
      ├── createdAt: Timestamp  // When the remark was made
```

### Notifications Collection

```plaintext
notifications (Collection)
└── notificationId (Document)
      ├── userId: String  // Who receives the notification
      ├── message: String
      ├── type: String  // (taskAssigned, remarkAdded, etc.)
      ├── read: Boolean
      ├── createdAt: Timestamp
```

### Project History Collection

```plaintext
projectHistory (Collection)
└── historyId (Document)
      ├── projectId: String
      ├── changeType: String  // (taskAdded, remarkAdded, progressUpdated, etc.)
      ├── changeDescription: String
      ├── userId: String  // Who made the change
      ├── createdAt: Timestamp
```

### Site Links Collection (Linked to Projects)

```plaintext
siteLinks (Collection)
└── siteLinkId (Document)
      ├── projectId: String  // Reference to the project
      ├── siteUrl: String  // The URL of the site
      ├── userId: String  // User ID for the site
      ├── password: String  // Password for the site
      ├── createdAt: Timestamp
      └── updatedAt: Timestamp
```

### Payments Collection (Linked to Projects)

```plaintext
payments (Collection)
└── paymentId (Document)
      ├── projectId: String  // Reference to the project
      ├── amountReceived: Number  // Amount received
      ├── receivedOn: Timestamp  // Date of payment received
      ├── paymentMethod: String  // (Bank Transfer, Cheque, Cash, etc.)
      ├── dueDateId: String  // Associated due date (if any)
      ├── createdAt: Timestamp
      └── updatedAt: Timestamp
```

### Due Dates Collection (Linked to Projects)

```plaintext
dueDates (Collection)
└── dueDateId (Document)
      ├── projectId: String  // Reference to the project
      ├── dueDate: Timestamp  // The due date for the payment
      ├── missedCount: Number  // Number of times the due date was missed
      ├── cleared: Boolean  // True if the payment is cleared
      ├── createdAt: Timestamp
      └── updatedAt: Timestamp
```

### Chats Collection

```plaintext
chats (Collection)
└── chatId (Document)
      ├── projectId: String  // Reference to the project
      ├── participants: [userId]  // List of users involved in the chat
      ├── messages: [messageId]  // List of message IDs in the chat
      ├── createdAt: Timestamp
      └── updatedAt: Timestamp
```

### Messages Collection (Linked to Chats)

```plaintext
messages (Collection)
└── messageId (Document)
      ├── chatId: String  // Reference to the chat
      ├── senderId: String  // The user who sent the message
      ├── messageText: String  // The content of the message
      ├── timestamp: Timestamp  // When the message was sent
```

---

