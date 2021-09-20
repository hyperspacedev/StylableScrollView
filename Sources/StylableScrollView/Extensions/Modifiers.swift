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

//  MARK: - SCROLLVIEW STYLE
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {

    /// Sets the style for all ``StylableScrollView`` instances within this view
    /// to one that conforms to ``ScrollViewStyle``, that allows to personalize
    /// a `ScrollView` by supporting custom appearance and behaviour.
    ///
    ///     StylableScrollView { ... }.scrollViewStyle(_:)
    ///
    /// ### Examples
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
    @inlinable @ViewBuilder func scrollViewStyle<S>(_ style: S) -> some View where S : ScrollViewStyle {

        self.environment(\.scrollViewStyle, AnyScrollViewStyle(style))

    }

}

//  MARK: - STRETCHABLE HEADER
@available(iOS 15.0, macOS 12, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public extension ScrollView {

    /// Turns a normal ScrollView into a ``StylableScrollView`` and sets the style
    /// for all of them within this view to ``StretchableScrollViewStyle``.
    ///
    /// While the ``scrollViewStyle(_:)`` modifier only works for ``StylableScrollView``s,
    /// this modifier can be applied on an existing ``ScrollView`` instance.
    ///
    ///     ScrollView { ... }.stretchableHeader(...)
    ///
    /// > Important: Using this modifier might result in a performance loss. If possible, use
    /// ``StylableScrollView`` directly.
    ///
    /// - Parameters:
    ///   - header: The header image that will be used for the sticky header.
    ///   - title: The title that appears on top of the header.
    ///   - navBar: The contents of the navigationBar that appears when scrolling.
    ///
    @ViewBuilder @inlinable func stretchableHeader<Title, NavBar>(
        header: Image,
        title: () -> Title,
        navBar: () -> NavBar
    ) -> some View where Title: View, NavBar: View {

        StylableScrollView(
            .vertical,
            showIndicators: false,
            content: {
                self
            })
            .scrollViewStyle(
                StretchableScrollViewStyle(
                    header: {
                        header
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    },
                    title: title,
                    navBarContent: navBar
                )
            )

    }

    /// Turns a normal ScrollView into a ``StylableScrollView`` and sets the style
    /// for all of them within this view to ``StretchableScrollViewStyle``.
    ///
    /// While the ``scrollViewStyle(_:)`` modifier only works for ``StylableScrollView``s,
    /// this modifier can be applied on an existing ``ScrollView`` instance.
    ///
    ///     ScrollView { ... }.stretchableHeader(...)
    ///
    /// > Important: Using this modifier might result in a performance loss. If possible, use
    /// ``StylableScrollView`` directly.
    ///
    /// - Parameters:
    ///   - header: The view that will be used for the sticky header.
    ///   - title: The title that appears on top of the header.
    ///   - navBar: The contents of the navigationBar that appears when scrolling.
    ///
    @ViewBuilder @inlinable func stretchableHeader<Header, Title, NavBar>(
        header: () -> Header,
        title: () -> Title,
        navBar: () -> NavBar
    ) -> some View where Header: View, Title: View, NavBar: View {

        StylableScrollView(
            .vertical,
            showIndicators: false,
            content: {
                self
            })
            .scrollViewStyle(
                StretchableScrollViewStyle(
                    header: header,
                    title: title,
                    navBarContent: navBar
                )
            )

    }

}

//  MARK: - SIZE MODIFIERS
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {

    /// Allows to retrieve the size of a SwiftUI view and access it from
    /// ancestor views, providing a completion
    /// - Parameter size: A completion handler that allows to work with the
    /// data obtained.
    @ViewBuilder func transformSize(_ size: @escaping (CGSize) -> Void) -> some View {

        self
            .background(
                GeometryReader { proxy -> Color in

                    size(proxy.frame(in: .global).size)

                    return Color.clear
                }
            )

    }

}

//  MARK: - NAVIGATION BAR ELEMENTS
extension View {

    /// Creates a fake navigation bar item for ``StretchableScrollViewStyle``'s fake navigation bar using
    /// preference keys.
    ///
    ///    - Parameters:
    ///        - axis: The horizontal edge the element will appear at.
    ///        - content: The element view
    ///        - affectedByColorChanges: Whether the element is affected by the changes in color when shown in a navigation Bar. Defaults to `true`.
    ///
    /// Use this modifier to set a specific navigation bar element for
    /// ``StretchableScrollViewStyle`` instances within a view:
    ///
    ///     ScrollView { ... }
    ///     .stretchableHeader(
    ///         header: ...,
    ///         title: ...,
    ///         navBar: {
    ///             ...
    ///             .navigationBarElement(...)
    ///         }
    ///      )
    ///
    @available(iOS 15.0, macOS 12.0, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @ViewBuilder public func navigationBarElement<Content: View>(axis: HorizontalEdge, _ content: () -> Content) -> some View {

        self.preference(
            key: Preferences.NavigationBar.Elements.Key.self,
            value: [
                Preferences.NavigationBar.Elements.Data(
                    axis: axis,
                    element: AnyView(content())
                )
            ]
        )

    }
}
