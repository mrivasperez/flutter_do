# flutter_do

![Flutter Version](https://img.shields.io/badge/Flutter-3.27.2-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-3.6.1-blue.svg)

## Overview

`flutter_do` is a simple yet functional Todo list application built with Flutter. This project was created as a practical way for me to learn the fundamentals of Flutter development, including:

- Basic UI design with Flutter widgets.
- State management.
- Data persistence.
- List manipulation (sorting, reordering).

## Getting Started

### Prerequisites

- **Flutter SDK:** Ensure you have the Flutter SDK installed on your system. For installation instructions, refer to the official Flutter documentation: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
- **Dart SDK:** The Dart SDK comes bundled with Flutter.
- **An IDE:** You can use Android Studio, IntelliJ IDEA, or VS Code with the Flutter and Dart plugins.

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/mrivasperez/flutter_do.git
   ```

2. **Navigate to the project directory:**

   ```bash
   cd flutter_do
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

### Running the App

1. **Connect a device or start an emulator/simulator.**
2. **Run the app:**

   ```bash
   flutter run
   ```

## Features

- **Add tasks:** Users can add new tasks to the todo list.
- **Mark tasks as complete:** Users can check off completed tasks.
- **Edit tasks:** Users can modify the text of existing tasks.
- **Delete tasks:** Users can remove tasks from the list.
- **Delete all completed tasks:** Provides an option to clear all completed tasks at once.
- **Reorder tasks:** Users can drag and drop tasks to rearrange their order.
- **Persistence:** The todo list is saved using `shared_preferences` and is restored when the app is reopened.
- **Visual feedback:** Completed tasks are animated to fade out slightly.

## Project Structure

The project follows a standard Flutter project structure:

```
flutter_do/
├── lib/ # Main application code
│ ├── main.dart # Entry point of the app
│ ├── models/ # Data models (Todo class)
│ ├── screens/ # UI for different screens (TodoListScreen)
│ ├── services/ # Services for handling data (StorageService)
│ └── widgets/ # Reusable UI components (TodoItemWidget)
├── test/ # Unit and widget tests (not implemented yet)
├── web/ # Web-specific files (if targeting web)
├── android/ # Android-specific code and resources
├── ios/ # iOS-specific code and resources
├── pubspec.yaml # Project dependencies and metadata
└── README.md # Project description
```

## Learning Journey

This project has been instrumental in helping me understand several core Flutter concepts. Some of the key takeaways include:

- **Widget Tree:** How to structure a Flutter app using the widget tree.
- **Stateless and Stateful Widgets:** The difference between stateless and stateful widgets and when to use them.
- **State Management:** Using `setState` for simple state management and understanding the need for more robust solutions (like `Provider` or `BLoC`) as an app grows.
- **Layouts:** Working with different layout widgets like `Row`, `Column`, `ListView`, `Scaffold`, etc.
- **Navigation:** Understanding how to navigate between different screens (not yet implemented in this project).
- **Data Persistence:** Using the `shared_preferences` package to store simple data locally.
- **Asynchronous Operations:** Working with `async` and `await` for operations like loading data from storage.

## Future Improvements

- **Enhanced UI:** Explore more advanced UI elements, animations, and custom themes.
- **Search and Filtering:** Add functionality to search for tasks and filter them by category or due date.
- **Advanced State Management:** Refactor to use a more robust state management solution like `Provider` or `BLoC`.
- **Testing:** Write unit and widget tests to ensure code quality and prevent regressions.
- **List Manipulation:** Using `ReorderableListView` to enable drag-and-drop reordering of list items.

## Contributing

As this is a personal learning project, I am not actively seeking contributions. However, feel free to fork the repository and use the code for your own learning purposes. If you find any bugs or have suggestions for improvements, please open an issue.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
