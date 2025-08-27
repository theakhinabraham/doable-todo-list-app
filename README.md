<a name="readme-top"></a>
<!-- PROJECT HEADER & LOGO -->
<br />
<div align="center">
  <a href="https://github.com/theakhinabraham/doable-todo-list-app">
    <img src="img/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Doable Todo List App</h3>

  <p align="center">
    💡 An offline Flutter todo list app using Dart & SQLite Database with notification reminders & latest UI designs.
    <br /> <br>
    <br />
    <a href="https://github.com/theakhinabraham/doable-todo-list-app/issues">Report Bugs</a>
    ·
    <a href="https://github.com/theakhinabraham/doable-todo-list-app/issues">Request Features</a>
  </p>

<a href="#">![GitHub repo size](https://img.shields.io/github/repo-size/theakhinabraham/doable-todo-list-app)
<a href="https://github.com/theakhinabraham/doable-todo-list-app/issues">![GitHub contributors](https://img.shields.io/github/contributors/theakhinabraham/doable-todo-list-app)
<a href="https://github.com/theakhinabraham/doable-todo-list-app">![GitHub stars](https://img.shields.io/github/stars/theakhinabraham/doable-todo-list-app?style=social)
<a href="https://github.com/theakhinabraham/doable-todo-list-app">![GitHub forks](https://img.shields.io/github/forks/theakhinabraham/doable-todo-list-app?style=social)
<a href="https://twitter.com/akhinabr">![Twitter Follow](https://img.shields.io/twitter/follow/akhinabr?style=social)</a>
<br>
[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.2.6+-0175C2?style=flat&logo=dart)](https://dart.dev)
[![SQLite](https://img.shields.io/badge/SQLite-003B57?style=flat&logo=sqlite)](https://www.sqlite.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

</div>

<br>
<br>
<br>
<br>
<br>
 
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<br>

<!-- ABOUT THE PROJECT -->
# About Doable: Todo List App
An offline, single‑device to‑do app built with Flutter and SQLite. Features task management with reminders, date/time pickers, and filtering capabilities.
<br><br>

## 📱 Features

- ✅ **Task Management** - Create, edit, delete tasks with title and optional description
- ⏰ **Smart Scheduling** - Date and time pickers with reminder notifications
- 🔄 **Repeat Rules** - Daily, Weekly, Monthly options with custom weekday selection
- 🔍 **Advanced Filtering** - Filter by date, time, completion status, repeat rules, and reminders
- 📱 **Intuitive UI** - Swipe-to-delete completed tasks, clean Material Design
- 💾 **Offline First** - Local SQLite storage, no network required
- 🗑️ **Data Management** - Clear all data option in settings

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- BUILT WITH -->
### Built With Flutter

Flutter is an open source framework developed and supported by Google. App Developers use Flutter to build mobile apps for multiple platforms (iOS/android) with a single codebase. <br><br>
<img src="https://storage.googleapis.com/cms-storage-bucket/d113e56856107a174445.svg" style="height:50px; width:150px;">

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally. To get a local copy up and running follow these simple example steps.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0+)
- [Dart SDK](https://dart.dev/get-dart) (3.2.6+)
- Android Studio or VS Code with Flutter extension

Make sure you have `git` installed, type `git --version` in your cmd. (git official download page: https://git-scm.com/downloads)
  
```
git --version
```

### Installation

Steps to install code and app into your local device (and run app on emulator or mobile device)

1. Fork this repository (and leave a star if you like) by click on the `fork` button on the top right side.
2. From your copy of this repo located `yourname/doable-todo-list-app`, copy the code link: `https://github.com/your-user-name/doable-todo-list-app.git`
3. Create a folder named `doable` in your local device to store these files.
4. Open terminal and type `cd path/to/doable` (replace `/path/to/doable` with the real path to the new `doable` folder we created in step 3)

  ```
  cd path/to/doable
  ```
<br>
5. Clone your copy of this repo using `git clone link-you-copied-in-step-2`

  ```
  git clone https://github.com/your_username_/doable-todo-list-app.git
  ```
<br>

6. Open the folder `doable/doable-todo-list-app` in your code editor (I use VS Code) & start coding.
7. Run `emulator` or connect your mobile device with cable to run app on mobile.
    

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🏗️ Tech Stack

| Technology | Purpose | Version |
|------------|---------|---------|
| [Flutter](https://flutter.dev) | UI Framework | 3.0+ |
| [SQLite](https://www.sqlite.org) | Local Database | via sqflite ^2.4.0 |
| [SharedPreferences](https://pub.dev/packages/shared_preferences) | Settings Storage | ^2.3.2 |
| [flutter_svg](https://pub.dev/packages/flutter_svg) | Vector Graphics | ^2.0.10 |
| [intl](https://pub.dev/packages/intl) | Date Formatting | ^0.20.2 |
| [url_launcher](https://pub.dev/packages/url_launcher) | External Links | ^6.3.0 |


## 📂 Project Structure

lib/<br>
├── main.dart # App entry point<br>
├── screens/ # UI screens<br>
│ ├── home_page.dart # Main task list<br>
│ ├── add_task_page.dart # Create new tasks<br>
│ ├── edit_task_page.dart # Modify existing tasks<br>
│ └── settings_page.dart # App settings<br>
├── data/ # Data layer<br>
│ ├── database_service.dart # SQLite management<br>
│ └── task_dao.dart # Database operations<br>
├── models/ # Data models<br>
│ └── task_entity.dart # Task data structure<br>
└── task_repository.dart # Repository pattern facade<br>


## 🗄️ Database Schema

### Tasks Table

```
CREATE TABLE tasks(
id INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT NOT NULL,
description TEXT,
time TEXT, -- Display format: "11:30 AM"
date TEXT, -- Display format: "26/11/24"
has_notification INTEGER NOT NULL DEFAULT 0,
repeat_rule TEXT, -- "Daily" | "Weekly" | "Monthly" | "Weekly:"
completed INTEGER NOT NULL DEFAULT 0,
created_at TEXT DEFAULT CURRENT_TIMESTAMP,
updated_at TEXT
);
```

## 🎨 Architecture

The app follows a clean layered architecture:

```
graph TB
A[Presentation Layer] --> B[Repository Layer]
B --> C[Data Access Layer]
C --> D[SQLite Database]
```

```
A --> E[SharedPreferences]

subgraph "Presentation Layer"
    A1[HomePage]
    A2[AddTaskPage]
    A3[EditTaskPage]
    A4[SettingsPage]
end

subgraph "Data Layer"
    C1[TaskDao]
    C2[DatabaseService]
end
```


### Key Components

- **Presentation Layer**: Stateful/Stateless widgets managing UI state
- **Repository Layer**: TaskRepository as a facade for future extensibility
- **Data Access Layer**: TaskDao + DatabaseService for SQLite operations
- **Domain Model**: TaskEntity for data serialization

## 🔧 Configuration

### Android Setup
```
android {
compileSdk 34
defaultConfig {
minSdk 21
targetSdk 34
}
compileOptions {
sourceCompatibility JavaVersion.VERSION_17
targetCompatibility JavaVersion.VERSION_17
}
}
```


### Build Variants
- **Debug**: Development with debug symbols
- **Release**: Optimized production build

## 🎯 Usage Examples

### Creating a Task
```
final task = TaskEntity(
title: "Complete project documentation",
description: "Write comprehensive README",
time: "2:30 PM",
date: "27/01/25",
hasNotification: true,
repeatRule: "Daily",
completed: false,
);

await TaskDao.insert(task);
```

### Filtering Tasks
```
// Filter by completion status
final incompleteTasks = tasks.where((t) => !t.completed).toList();

// Filter by date
final todayTasks = tasks.where((t) => t.date == "27/01/25").toList();

// Filter by repeat rule
final weeklyTasks = tasks.where((t) =>
t.repeatRule?.startsWith("Weekly") == true
).toList();
```

## 📱 Screenshots

<p align="center">
<img src="/img/home-preview.png" style="height:40vh; width:auto;"> <img src="/img/add-task-preview.png" style="height:40vh; width:auto;"> <img src="/img/edit-task-preview.png" style="height:40vh; width:auto;"> <img src="/img/filter-preview.png" style="height:40vh; width:auto;"> <img src="/img/notification-preview.png" style="height:40vh; width:auto;">    
</p>

<!-- ROADMAP -->
## Roadmap
### Version 1.1.0
- [x] Add, edit and remove tasks
- [x] Complete task and undo completion
- [x] Display tasks on home screen
- [x] Completed tasks are striked through, swipe to delete
- [x] Completed tasks move to the bottom
- [x] Repeat feature (daily, weekly, monthly, no repeat)
- [x] Set date and time for task
- [x] Notification reminders

### Version 2.0
- [ ] **Cloud Sync** - Optional cloud backup and sync
- [ ] **Rich Notifications** - Local notification scheduling
- [ ] **Advanced Repeats** - Custom repeat patterns
- [ ] **Categories & Tags** - Task organization
- [ ] **Dark Mode** - Theme customization

### Version 2.1
- [ ] **Collaboration** - Shared task lists
- [ ] **Analytics** - Productivity insights
- [ ] **Export/Import** - JSON backup functionality
- [ ] **Widget Support** - Home screen widgets

See the [open issues](https://github.com/theakhinabraham/doable-todo-list-app/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!
<br>

<h2>How to get access to my project: </h2>

1. Fork this repository (and leave a star if you like) by click on the `fork` button on the top right side.
2. From your copy of this repo located `yourname/doable-todo-list-app`, copy the code link: `https://github.com/your-user-name/doable-todo-list-app.git`
3. Create a folder named `doable` in your local device to store these files.
4. Open terminal and type `cd path/to/doable` (replace `/path/to/doable` with the real path to the new `doable` folder we created in step 3)

  ```
  cd path/to/doable
  ```
<br>

5. Clone your copy of this repo using `git clone [link you copied in step 2]`

  ```
  git clone https://github.com/your_username_/doable-todo-list-app.git
  ```
<br>

6. Navigate to the root folder of this project
  
  ```
  cd /path/to/doable-todo-list-app
  ```
<br>

7. DO **NOT** MAKE CHANGES TO THE main BRANCH, create your own branch and name it your name

```
git branch my-user-name
```
<br>

8. Confirm that your new branch `my-user-name` is created

```
git branch
```
<br>

9. Select your new branch `my-user-name` and work on that branch only

```
git checkout my-user-name
```
<br>

10. Confirm that you are in your branch `my-user-name` and **NOT** on `main`

```
git branch
```
<br>

<h2>Staying up-to-date with original code: </h2>

1. You have to shift to `main` branch first but do **NOT** `push` to `main` branch

```
git checkout main
```
<br>

2. Perform a `pull` to stay updated. It must show `Already up-to-date`

```
git pull
```
<br>

3. Now you have to shift back to your branch `my-user-name` again before you can continue editing code

```
git checkout my-user-name
```
<br>

4. Perform a `pull` again in `my-user-name` your own branch

```
git pull
```
<br>

<h2>Once you are ready to push the changes, follow these steps: </h2>

1. Confirm you are in `my-user-name` your own branch

```
git branch
```
<br>

2. Push the changes

```
git add .
git commit -m "issue #24 fixed"
```
<br>

3. Choose `git push origin HEAD`, do **NOT** choose `git push origin HEAD:master`

```
git push
git push origin HEAD
```
<br>


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. Click [LICENSE.md](https://github.com/theakhinabraham/doable-todo-list-app/blob/main/LICENSE.md) for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [SQLite](https://www.sqlite.org) for reliable local storage
- [Material Design](https://material.io) for design inspiration

<!-- CONTACT -->
## 📞 Support

Akhin Abraham - [instagram.com/akhinabr](https://instagram.com/akhinabr) - theakhinabraham@gmail.com

Repository Link: [https://github.com/theakhinabraham/doable-todo-list-app](https://github.com/theakhinabraham/doable-todo-list-app)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

Here are some resource links to help with this project and it's contribution:

* [Flutter Docs](https://docs.flutter.dev/)
* [Flutter Packages](https://pub.dev/)


<p align="right">(<a href="#readme-top">back to top</a>)</p>
