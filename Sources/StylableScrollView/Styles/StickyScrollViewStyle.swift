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
*   StickyScrollViewStyle.swift
*
*   Created by Alex Modroño Vara on 5/8/21.
*
*/
import Foundation
import SwiftUI

/// A ScrollView style that contains a custom sticky header with a custom title.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct StickyScrollViewStyle<Header, Title>: ScrollViewStyle where Header: View, Title: View {

    @State var tabBarOffset: CGFloat = 0

    private let header: Header
    private let title: Title

    private var headerHeight: CGFloat

    public init(size headerHeight: CGFloat = 200, header: () -> Header, title: () -> Title) {

        self.headerHeight = headerHeight
        self.header = header()
        self.title = title()

    }

    /// Creates a view that represents a body that is scrollable in the direction of the given
    /// axis and can show indicators while scrolling, and that contains a custom sticky header
    /// with a custom title.
    ///
    /// - Parameter configuration: The properties of the ScrollView, such as its
    ///   content, scrollable axis, and whether the scroll view should display
    ///   the scrollable component of the content offset, in a way suitable for
    ///   the platform.
    public func makeBody(configuration: ScrollViewStyle.Configuration) -> some View {

        if configuration.axes != .vertical {
            NSLog("Configuration.axes was passed as %d, but .vertical will be used instead.", configuration.axes.rawValue)
        }

        return ScrollView(
            .vertical,
            showsIndicators: configuration.showsIndicators,
            content: {
                VStack(spacing: 0) {
                    headerView
                    configuration.content
                        .zIndex(0.1)
                }
            }
        )

    }

    /// Returns the height of the stretchable header.
    ///
    /// - Parameters:
    ///   - for: the y offset that will be used for calculating the position of the header.
    ///   - isOptional: a boolean indicating whether the height can be returned as optional or not.
    private func getHeightForHeader(for minY: CGFloat, _ isOptional: Bool = true) -> CGFloat? {
        return minY > 0 ? headerHeight + minY : isOptional ? nil : headerHeight
    }

    public var headerView: some View {
        GeometryReader(content: { proxy -> AnyView in

            let minY = proxy.frame(in: .global).minY
            let totalWidth = proxy.frame(in: .global).width

            return AnyView(

                ZStack {

                    header
                        .frame(
                            width: totalWidth,
                            height: getHeightForHeader(
                                for: minY,
                                   false
                            ),
                            alignment: .center)
                        .cornerRadius(0)

                }
                .offset(y: minY < headerHeight ? -minY + headerHeight : 0)

            )

        })
            .frame(height: headerHeight)
            .zIndex(1)
    }

}
