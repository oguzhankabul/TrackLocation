# Location Tracker App

## Overview

This application features a straightforward interface designed to demonstrate location tracking capabilities on iOS. Upon granting location access permissions, users are directed to the main page, equipped with three primary buttons: "Start", "Stop", and "Reset".

- **Start**: Initiates location tracking. As you move, pins are dropped on the map for every 100 meters you cover.
- **Stop**: Halts the location tracking and pin-dropping process.
- **Reset**: Clears all the pins from the map.

Should the application be restarted, it retains the last-known pins on the map. Additionally, if it was previously closed while tracking was active ("Start" was engaged), it will automatically resume tracking upon relaunch.

## Technical Details

The application is built following the MVVM-R (Model-View-ViewModel-Router) architecture, ensuring a clean and manageable codebase. Each screen within the app is structured with its ViewModel, ViewController, Router, and Route, facilitating navigation and data management:

- **ViewModel**: Manages the business logic and communicates with the ViewController for UI updates.
- **ViewController**: Handles the user interface and interactions.
- **Router**: Contains the routes for navigation to different screens.
- **Route**: Defines the navigational functions to transition between screens.

For transitions, although the PushTransition is integrated into the project, it has not been utilized. Instead, two different transition types have been implemented and are used throughout the app, including an initial transition upon application startup.

### Key Features:

- Utilizes **MapKit** for map and location services.
- The UI is entirely coded programmatically, without the use of storyboards.
- Unit tests have been written for logic-heavy classes, promoting reliable and robust development practices.
- The project abstains from third-party dependencies, showcasing native solutions to common development requirements.
- Adheres to principles of clean code and structure, aiming for maintainability and scalability.

### Getting Started

To use this app, clone the repository, open it in Xcode, and run it on a suitable simulator or physical device. Ensure that location services are enabled and permissions are granted for the optimal experience.

## Contributing

Contributions to the Location Tracker App are welcome. Whether it's suggesting new features, reporting bugs, or improving documentation, your input is valued. Please feel free to submit pull requests or open issues to discuss potential changes.
