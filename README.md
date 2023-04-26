# Revolve

[![CI](https://github.com/YOUR_GITHUB_USERNAME/Revolve/workflows/CI/badge.svg)](https://github.com/YOUR_GITHUB_USERNAME/Revolve/actions?query=workflow%3ACI)
[![Slack](https://img.shields.io/badge/slack-chat-informational.svg?label=Slack&logo=slack)](https://www.YOUR_SLACK_INVITE_LINK.com)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FYOUR_GITHUB_USERNAME%2FRevolve%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/YOUR_GITHUB_USERNAME/Revolve)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FYOUR_GITHUB_USERNAME%2FRevolve%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/YOUR_GITHUB_USERNAME/Revolve)

Revolve is a SwiftUI library for building applications with a robust and composable architecture. It is designed to work seamlessly with SwiftUI, Combine, and the Redux-like pattern to make your app's state management and UI development straightforward and enjoyable.

* [What is Revolve?](#what-is-revolve)
* [Learn more](#learn-more)
* [Examples](#examples)
* [Basic usage](#basic-usage)
* [Documentation](#documentation)
* [Community](#community)
* [Installation](#installation)
* [Translations](#translations)

## What is Revolve?

Revolve is a modern architecture library for SwiftUI apps, which leverages Redux and Combine to manage your app's state, actions, and side effects. The library enables you to build clean and maintainable applications, making it easier to test, scale, and reason about your code.

## Learn more

To learn more about Revolve and how to use it, check out our [extensive documentation](https://github.com/YOUR_GITHUB_USERNAME/Revolve/wiki).

## Examples

We provide several examples of how to use Revolve in different scenarios:

* [Basic Example](https://github.com/YOUR_GITHUB_USERNAME/Revolve/tree/main/Examples/BasicExample) - A simple example demonstrating the core concepts of Revolve.
* [Advanced Example](https://github.com/YOUR_GITHUB_USERNAME/Revolve/tree/main/Examples/AdvancedExample) - A more complex example, showcasing how to handle advanced use cases and app features with Revolve.

## Basic usage

Here's a quick example to get you started with Revolve:

```swift
import SwiftUI
import Revolve

// 1. Define your app state
struct AppState {
    var counter: Int = 0
}

// 2. Define your app actions
enum AppAction {
    case increment
    case decrement
}

// 3. Implement the reducer
let appReducer = Reducer<AppState, AppAction> { state, action in
    switch action {
    case .increment:
        state.counter += 1
    case .decrement:
        state.counter -= 1
    }
}

// 4. Create the store
let store = Store(initialState: AppState(), reducer: appReducer)

// 5. Use the store in your SwiftUI views
struct ContentView: View {
    @ObservedObject var store: Store<AppState, AppAction>

    var body: some View {
        VStack {
            Text("Counter: \(store.state.counter)")
            Button("Increment") {
                store.send(.increment)
            }
            Button("Decrement") {
                store.send(.decrement)
            }
        }
    }
}

// 6. Provide the store to your SwiftUI app
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
```



