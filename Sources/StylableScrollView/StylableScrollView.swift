/*
*   THE WORK (AS DEFINED BELOW) IS PROVIDED UNDER THE TERMS OF THIS
*   NON-VIOLENT PUBLIC LICENSE v4 ("LICENSE"). THE WORK IS PROTECTED BY
*   COPYRIGHT AND ALL OTHER APPLICABLE LAWS. ANY USE OF THE WORK OTHER THAN
*   AS AUTHORIZED UNDER THIS LICENSE OR COPYRIGHT LAW IS PROHIBITED. BY
*   EXERCISING ANY RIGHTS TO THE WORK PROVIDED IN THIS LICENSE, YOU AGREE
*   TO BE BOUND BY THE TERMS OF THIS LICENSE. TO THE EXTENT THIS LICENSE
*   MAY BE CONSIDERED TO BE A CONTRACT, THE LICENSOR GRANTS YOU THE RIGHTS
*   CONTAINED HERE IN AS CONSIDERATION FOR ACCEPTING THE TERMS AND
*   CONDITIONS OF THIS LICENSE AND FOR AGREEING TO BE BOUND BY THE TERMS
*   AND CONDITIONS OF THIS LICENSE.
*
*   StylableScrollView.swift
*
*   Created by Alex Modroño Vara on 5/8/21.
*
*/
import Foundation
import SwiftUI

/// A scrollable view that supports styling through the ``scrollViewStyle(_:)`` modifier.
///
/// The scroll view displays its content within the scrollable content region.
/// As the user performs platform-appropriate scroll gestures, the scroll view
/// adjusts what portion of the underlying content is visible. `ScrollView` can
/// scroll horizontally, vertically, or both, but does not provide zooming
/// functionality. Additional functionality might be added by the different styles.
///
/// ### Creating a StylableScrollView
///
/// Like you would when creating a `ScrollView`, you can customize the scrolling
/// axis of a ``StylableScrollView``, as well as whether it shows an indicator
/// when scrolling. For example, you can set a vertical stylable scroll view that
/// shows indicators when scrolling as follows:
///
///     StylableScrollView(.vertical, showsIndicators: true) {
///         ...
///     }
///
/// ### Applying styles
///
/// You can customize a stylable scroll views's appearance using one of the standard
/// scroll view styles (i.e. those that conform to ``ScrollViewStyle``), like
/// ``StickyScrollViewStyle`` or ``StretchableScrollViewStyle``, or even create your
/// own.
///
/// Applying styles can be done through the ``scrollViewStyle(_:)`` modifier, which
/// will set the style for all the ``StylableScrollView`` instances within a view.
///
/// In the following example, a ``StylableScrollView`` allows the user to scroll
/// through a set of views, and has the ``StretchableScrollViewStyle`` applied.
/// This allows to have a stretchable header that can be hidden when scrolled up,
/// and has a custom navigation bar that imitates the behaviour of a normal
/// `NavigationView`.
///
///     var body: some View {
///         StylableScrollView {
///             ...
///         }
///         .scrollViewStyle(
///             StretchableScrollViewStyle(
///                 header: {
///                     Image("banner")
///                 }, title: {
///                     Text("Kylian Mbappé")
///                 }, navBarContent: {
///                     Text("Kylian Mbappé")
///                 }
///             )
///         )
///     }
///
/// ![A stretchable scroll view with a big text talking about French footballer Kylian Mbappé. On top, a stretchable header can be seen.](StretchableHeader-kmbappe.png)
///
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct StylableScrollView<Content>: View {

    /// The style that is being used.
    @Environment(\.scrollViewStyle) private var style
    
    /// The configuration for the ScrollView
    private var configuration: ScrollViewStyleConfiguration

    /// Initializes a ``StylableScrollView`` with the specified configuration.
    /// - Parameter configuration: The ScrollView configuration.
    public init(_ configuration: ScrollViewStyleConfiguration) {
        self.configuration = configuration
    }

    public var body: some View {
        self.style.makeBody(configuration: self.configuration)
    }

}

public extension StylableScrollView where Content : View {

    /// Creates an instance of an ``StylableScrollView`` that is scrollable in a specific
    /// axis, and can show indicators while scrolling, using the body that you define.
    ///
    /// - Parameters:
    ///    - axes: The scrollable axes of the scroll view.
    ///    - showIndicators: A value that indicates whether the scroll view displays the scrollable
    ///      component of the content offset, in a way that's suitable for the platform.
    ///    - content: The scroll view's content.
    ///
    init(_ axes: Axis.Set = .vertical, showIndicators: Bool = true, content: () -> Content) {

        self.init(
            ScrollViewStyleConfiguration(
                showsIndicators: showIndicators,
                content: AnyView(content()),
                axes: axes
            )
        )

    }

}
