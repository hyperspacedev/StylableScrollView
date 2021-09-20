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
*   StretchableScrollViewStyle.swift
*
*   Created by Alex Modroño Vara on 5/8/21.
*
*/
import Foundation
import SwiftUI

/// The default ScrollView style.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PrimitiveScrollViewStyle: ScrollViewStyle {

    /// Creates a view that represents a body that is scrollable in the direction of the given
    /// axis and can show indicators while scrolling.
    ///
    /// - Parameter configuration: The properties of the ScrollView, such as its
    ///   content, scrollable axis, and whether the scroll view should display
    ///   the scrollable component of the content offset, in a way suitable for
    ///   the platform.
    public func makeBody(configuration: ScrollViewStyle.Configuration) -> some View {

        ScrollView(
            configuration.axes,
            showsIndicators: configuration.showsIndicators,
            content: {
                configuration.content
            }
        )

    }

}
