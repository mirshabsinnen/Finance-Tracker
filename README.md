# Finance Tracker

A local-first personal finance tracker built with Flutter. Log expenses,
see a live pie chart of spending by category, and toggle between light and
dark mode — all data stays on-device.

<!-- Add 3 screenshots here once you have them:
![Empty state](screenshots/empty_state.png)
![Home screen](screenshots/home_screen.png)
![Add expense](screenshots/add_expense.png)
-->

## Features
- Add expenses with amount, category, description, and date
- Live pie chart breakdown of spending by category
- Swipe-to-delete expenses
- Light / dark theme toggle
- Fully offline — no backend, no login

## Architecture
- **UI** (`screens/`, `widgets/`) — presentation only, no business logic
- **State management** (`cubit/`) — `flutter_bloc` Cubits handle all app logic
- **Data layer** (`services/hive_service.dart`) — the only file that talks
  to the local Hive database
- **Model** (`models/expense.dart`) — typed `Expense` class with a
  hand-written Hive `TypeAdapter`

## Tech Stack
- Flutter
- `flutter_bloc` (Cubit) for state management
- `hive` / `hive_flutter` for local persistence
- `fl_chart` for the spending pie chart

## Getting Started
```bash
flutter pub get
flutter run
```

## Out of Scope (v1)
- Cloud sync / authentication
- Editing existing expenses
- Budgets, recurring expenses, notifications
