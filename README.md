# ViewBoundContextMenu
ViewBoundContextMenu is a SwiftUI component that implements context menus that apply only to the view that defines them. While this should also be the case for SwiftUI's `contextMenu` view modifier, it doesn't work in views inside `List`: in this situation, the context menu is applied to the entire row.

This problem has been reported multiple times. Here are some examples:
- [Multiple context menus in a list row](https://developer.apple.com/forums/thread/127611)
- [Add contextMenu in the items inside of a List in SwiftUI](https://stackoverflow.com/questions/58583312/add-contextmenu-in-the-items-inside-of-a-list-in-swiftui)

The current workaround is to remove `List` and replace it with a `VStack` *(or a `LazyVStack`)* and a `ScrollView`. This solution isn't ideal, because `List` provides a different experience and supports additional interactions (such as swipe actions).

**ViewBoundContextMenu solves this problem!**

## Installation
ViewBoundContextMenu is available through [Swift Package Manager](https://swift.org/package-manager).

```swift
.package(url: "https://github.com/MrAsterisco/ViewBoundContextMenu", from: "<see GitHub releases>")
```

### Latest Release
To find out the latest version, look at the Releases tab of this repository.  

## Usage
ViewBoundContextMenu is exposed as a `ViewModifier` that you can apply to any view:

```swift
Text("Left Label")
  .bold()
  .viewBoundContextMenu {
    [
      .init(
        identifier: "Unique Identifier",
        title: "Action Title",
        image: nil, // Optional
        action: { // Do something }
      )
    ]
  }
```

The content of the menu is defined by an array of `ContextAction`:

```swift
struct ContextAction {
  let identifier: String
  let title: String
  let image: UImage?|NSImage? // Optional: images will not be displayed when targeting Mac Catalyst.
  let action: () -> ()
}
```

### Example App
To see ViewBoundContextMenu in action, you can open the `ViewBoundContextMenu` workspace and run the "ViewBoundContextMenuExample" app.

## Compatibility
ViewBoundContextMenu is compatible with **iOS**, **macOS**, and **Mac Catalyst**.

ViewBoundContextMenu targets **iOS 13.0 or later** and **macOS 10.15 or later**. The following dependencies are required:
- `SwiftUIX` version 0.1.2.

## Contributions
All contributions to expand the library are welcome. Fork the repo, make the changes you want, and open a Pull Request.

If you make changes to the codebase, I am not enforcing a coding style, but I may ask you to make changes based on how the rest of the library is made.

## Status
This library is under **active development**. It is used in one app in Production (running on iOS and Mac Catalyst). 

Even if most of the APIs are pretty straightforward, **they may change in the future**; but you don't have to worry about that, because releases will follow [Semanting Versioning 2.0.0](https://semver.org).

## License
RxFireAuth is distributed under the MIT license. [See LICENSE](https://github.com/MrAsterisco/ViewBoundContextMenu/blob/master/LICENSE) for details.

