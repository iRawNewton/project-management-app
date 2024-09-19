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

