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

/// A ScrollView style that contains a custom stretchable header with a custom title, and a custom
/// navigation bar.
@available(iOS 15.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct StretchableScrollViewStyle<Header, Title, Content>: ScrollViewStyle where Header: View, Title: View, Content: View {

    private let header: Header
    private let title: Title
    private let navBarContent: Content

    public let showBackButton: Bool

    private var headerHeight: CGFloat

    public init(size headerHeight: CGFloat = 200, header: () -> Header, title: () -> Title, navBarContent: () -> Content, _ showBackButton: Bool = true) {

        self.headerHeight = headerHeight
        self.header = header()
        self.title = title()
        self.navBarContent = navBarContent()
        self.showBackButton = showBackButton

    }

    private struct view: View {

        typealias navBarPreferenceKey = Preferences.NavigationBar.Elements.Key
        typealias navBarPreferenceData = Preferences.NavigationBar.Elements.Data

        @State var minY: CGFloat = 0
        @State var leadingNavBarElements: [AnyView] = []
        @State var trailingNavBarElements: [AnyView] = []

        @Environment(\.colorScheme) var colorScheme
        @Environment(\.layoutDirection)
        var layoutDirection: LayoutDirection

        var configuration: ScrollViewStyleConfiguration
        
        let header: Header
        let title: Title
        let navBarContent: Content
        public let showBackButton: Bool

        var headerHeight: CGFloat

        var body: some View {
            ScrollView(
                .vertical,
                showsIndicators: configuration.showsIndicators,
                content: {
                    VStack(spacing: 0) {
                        headerView
                        configuration.content
                    }
                    .onPreferenceChange(Preferences.Header.Key.self) { preference in
                        self.minY = preference.minY
                    }
                    .onPreferenceChange(navBarPreferenceKey.self) { preferences in

                        for p in preferences {

                            if p.axis == .leading {
                                self.leadingNavBarElements.append(p.element)
                            }

                            if p.axis == .trailing {
                                self.trailingNavBarElements.append(p.element)
                            }

                        }

                    }
                }
            )
                .overlay(
                    HStack {

                        if self.showBackButton {
                            BackButton(
                                color: navBarElementColor(
                                    for: materialOpacity(
                                        for: self.minY
                                    ),
                                       self.colorScheme
                                )
                            )
                                .shadow(radius: 10)
                        }

                        getNavBarElements(for: self.layoutDirection == .leftToRight ? .leading : .trailing)

                        Spacer()

                        getNavBarElements(for: self.layoutDirection == .leftToRight ? .trailing : .leading)

                    }
                        .padding(.top, 5)
                        .padding(.trailing),
                    alignment: .top
                )
        }

        @ViewBuilder private func getNavBarElements(for horizontalEdge: HorizontalEdge) -> some View {
            
            HStack {
                if horizontalEdge == .leading {
                    if self.leadingNavBarElements.count > 0 {
                        ForEach(
                            0 ..< self.leadingNavBarElements.count
                        ) { index in
                            self.leadingNavBarElements[index]
                        }
                    }
                } else {
                    if self.trailingNavBarElements.count > 0 {
                        ForEach(
                            0 ..< self.trailingNavBarElements.count
                        ) { index in
                            self.trailingNavBarElements[index]
                        }
                    }
                }
            }
            .foregroundColor(
                navBarElementColor(
                    for: materialOpacity(
                        for: self.minY
                    ),
                       self.colorScheme
                )
            )

        }

        private func navBarElementColor(for materialOpacity: Double, _ scheme: ColorScheme) -> Color {
            if scheme == .light {
                return materialOpacity < 0.3 ? Color.backgroundColor : Color.backgroundColorInverted(for: self.colorScheme)
            } else {
                return Color.white
            }
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

                        #if os(iOS)
                        VStack(spacing: 0) {
                            Rectangle()
                                .opacity(0)
                                .background(.ultraThickMaterial)
                                .overlay(
                                    Divider()
                                        .foregroundColor(.gray)
                                    , alignment: .bottom
                                )
                        }
                            .opacity(materialOpacity(for: minY))
                            .zIndex(0.9)

                        navBarContent
                            .opacity(materialOpacity(for: minY) > 0.3 ? 1 : 0)
    //                        .animation(.easeIn(duration: 0.2))
                            .offset(y: 65)
                            .zIndex(1)
                        #endif

                    }
                        .frame(height: getHeightForHeader(for: minY))
                        .offset(y: minY > 0 ? -minY : -minY < 100 ? 0 : -minY - 100)
                        .overlay(
                            title
                                .padding()
                                .offset(y: minY > 0 ? -minY : 0)
                                .zIndex(0.8)
                                .opacity(materialOpacity(for: minY) > 0.3 ? 0 : 1)
                                .animation(.easeIn(duration: 0.2)),
                            alignment: .bottomLeading
                        )
                        .preference(
                            key: Preferences.Header.Key.self,
                            value: Preferences.Header.Data(minY: minY)
                        )

                )

            })
                .frame(height: headerHeight)
                .zIndex(1)
                #if os(iOS)
                .navigationBarHidden(true)
                #endif
        }

        /// Returns the opacity of the material view that is used as the background of the fake navigation bar.
        ///
        /// - Parameters:
        ///   - for: the y offset that will be used for calculating the position of the header.
        fileprivate func materialOpacity(for minY: CGFloat, _ isOptional: Bool = true) -> Double {
            let progress = -(minY + 80) / 30
            return Double(-minY > 80 ? progress : 0)
        }

        /// Returns the height of the stretchable header.
        ///
        /// - Parameters:
        ///   - for: the y offset that will be used for calculating the position of the header.
        ///   - isOptional: a boolean indicating whether the height can be returned as optional or not.
        private func getHeightForHeader(for minY: CGFloat, _ isOptional: Bool = true) -> CGFloat? {
            return minY > 0 ? headerHeight + minY : isOptional ? nil : headerHeight
        }
        
    }

    /// Creates a view that represents a body that is scrollable in the direction of the given
    /// axis and can show indicators while scrolling, and that contains a custom stretchable header
    /// with a custom title, and a custom navigation bar.
    ///
    /// - Parameter configuration: The properties of the ScrollView, such as its
    ///   content, scrollable axis, and whether the scroll view should display
    ///   the scrollable component of the content offset, in a way suitable for
    ///   the platform.
    public func makeBody(configuration: ScrollViewStyle.Configuration) -> some View {

        if configuration.axes != .vertical {
            NSLog("Configuration.axes was passed as %d, but .vertical will be used instead.", configuration.axes.rawValue)
        }

        return StretchableScrollViewStyle.view(
            configuration: configuration,
            header: self.header,
            title: self.title,
            navBarContent: self.navBarContent,
            showBackButton: self.showBackButton,
            headerHeight: self.headerHeight
        ).zIndex(0.1)
    }

}
