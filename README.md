<div align="center">

![Banner](./Resources/banner.png)

![swift 5.5](https://img.shields.io/badge/swift-5.5-blue.svg)
![SwiftUI](https://img.shields.io/badge/-SwiftUI-blue.svg)
![iOS](https://img.shields.io/badge/os-iOS-green.svg)
![iPadOS](https://img.shields.io/badge/os-iPadOS-green.svg)
![macOS](https://img.shields.io/badge/os-macOS-green.svg)
![tvOS](https://img.shields.io/badge/os-tvOS-green.svg)
![watchOS](https://img.shields.io/badge/os-watchOS-green.svg)
    
</div>

## Index

- [Getting started](#getting-started)
    - [Building from source](#building-from-source)
    - [Through Swift Package Manager](#through-swift-package-manager)
- [Usage](#usage)
    - [Applying styles](#applying-styles)

## Getting started 🏃🏻‍♂️

`StylableScrollView` can be easily installed through the Swift Package Manager in any Xcode
project.

### Building from source

To build `StylableScrollView`, you'll need the following:

- A Mac running macOS 11 (Big Sur) or higher
- Xcode 13 or higher
- SwiftLint

Download the source for this project by either cloning directly from Xcode or via
`gh repo clone`, then clicking "Run" to build the project.

### Through Swift Package Manager

To add `StylableScrollView` to your package in Xcode 13, go to 
**File &rsaquo; Swift Packages &rsaquo; Add Package Dependency...** and paste in the URL: `https://github.com/hyperspacedev/StylableScrollView`.

## Usage

Like you would when creating a `ScrollView`, you can customize the scrolling axis of a
`StylableScrollView`, as well as whether it shows an indicator when scrolling. For example, you
can set a vertical stylable scroll view that shows indicators when scrolling as follows:

```swift
StylableScrollView(.vertical, showsIndicators: true) {
 ...
}
```

 ### Applying styles

You can customize a stylable scroll views's appearance using one of the standard scroll view
styles (i.e. those that conform to `ScrollViewStyle`), like `StickyScrollViewStyle` or
`StretchableScrollViewStyle`, or even create your own.

Applying styles can be done through the `scrollViewStyle(_:)` modifier, which will set the style
for all the `StylableScrollView` instances within a view.

In the following example, a `StylableScrollView` allows the user to scroll through a set of views
and has the `StretchableScrollViewStyle` applied. This allows to have a stretchable header that
can be hidden when scrolled up, and has a custom navigation bar that imitates the behaviour of a
normal `NavigationView`.

```
 var body: some View {
     StylableScrollView {
         ...
     }
     .scrollViewStyle(
         StretchableScrollViewStyle(
             header: {
                 Image("banner")
             }, title: {
                 Text("Kylian Mbappé")
             }, navBarContent: {
                 Text("Kylian Mbappé")
             }
         )
     )
 }
```
