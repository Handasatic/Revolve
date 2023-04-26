# Revolve ↻

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FHandasatic%2FRevolve%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Handasatic/Revolve)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FHandasatic%2FRevolve%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Handasatic/Revolve)

Revolve is a light-weight library for building applications with a robust and composable architecture. It is a Redux-based and leverages the power of the Combine framework to streamline your app's state management and UI development. Designed specifically for SwiftUI, Revolve makes creating efficient, maintainable, and enjoyable applications easier than ever.

* [What is Revolve?](#what-is-revolve)
* [Installation](#installation)
* [Examples](#examples)
* [Basic usage](#basic-usage)
* [Documentation](#documentation)

## What is Revolve?

Revolve is a modern architecture library for SwiftUI apps, which leverages Redux and Combine to manage your app's state, actions, and side effects. The library enables you to build clean and maintainable applications, making it easier to test, scale, and reason about your code.

## Features

- 📦 Swift Package Manager support
- 🔗 Composable reducers and state
- 💪 Type-safe actions using enums
- 🧪 Easily testable with CombineSchedulers

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/Handasatic/Revolve.git", from: "1.0.0")
```

## Examples

We provide a simple example of how to use Revolve:

* [Basic Example](https://github.com/Handasatic/Revolve/tree/main/Examples/ConverterExample) - A simple example demonstrating the core concepts of Revolve.
*  Advanced Example - Coming soon

## Basic usage

Here's a quick example to get you started with Revolve:

### Defining State

Create a struct conforming to `Revolve.State` to define your app's state. This struct should contain all the necessary properties to represent your app's current state.

```swift
struct AppState: Revolve.State {
    var user: UserState
    var settings: SettingsState
}

struct UserState: Revolve.State {
    var name: String
    var age: Int
}

struct SettingsState: Revolve.State {
    var notificationsEnabled: Bool
    var darkModeEnabled: Bool
}
```

### Defining Actions

Define an enum conforming to Revolve.Action to represent the different actions that can be performed in your app. For a more organized codebase, you can group actions by the state they affect.

```swift
eenum AppAction: Revolve.Action {
    case user(UserAction)
    case settings(SettingsAction)
}

enum UserAction: Revolve.Action {
    case setName(String)
    case setAge(Int)
}

enum SettingsAction: Revolve.Action {
    case setNotificationsEnabled(Bool)
    case setDarkModeEnabled(Bool)
}
```

### Defining Reducers

Create a reducer function that takes the current state and an action as its arguments and returns an updated state. To handle state composition, you can create separate reducers for each state struct and use a top-level reducer to delegate actions to their respective reducers.

```swift
let appReducer: Reducer<AppState, AppAction> = { state, action in
    switch action {
    case let .user(userAction):
        userReducer(state: &state.user, action: userAction)
    case let .settings(settingsAction):
        settingsReducer(state: &state.settings, action: settingsAction)
    }
}

let userReducer: Reducer<UserState, UserAction> = { state, action in
    switch action {
    case let .setName(name):
        state.name = name
    case let .setAge(age):
        state.age = age
    }
}

let settingsReducer: Reducer<SettingsState, SettingsAction> = { state, action in
    switch action {
    case let .setNotificationsEnabled(enabled):
        state.notificationsEnabled = enabled
    case let .setDarkModeEnabled(enabled):
        state.darkModeEnabled = enabled
    }
}
```

### Creating a StateStore

Instantiate a StateStore with the initial state, reducer, and a scheduler.

```swift
let store = StateStore(initialState: AppState(user: UserState(name: "", age: 0), 
                                              settings: SettingsState(notificationsEnabled: true, 
                                                                      darkModeEnabled: false)), 
                                    reducer: appReducer, 
                                    scheduler: DispatchQueue.main.eraseToAnyScheduler())

```
Then, inject the StateStore into your SwiftUI views.

