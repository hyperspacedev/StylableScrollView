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
*   Preferences.swift
*
*   Created by Alex Modroño Vara on 5/8/21.
*
*/
import Foundation
import SwiftUI

// MARK: – SWIFTLINT
//  swiftlint:disable nesting

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Preferences {

    /// All the preference keys for the header.
    public struct Header {

        /// Allows us to read the minY of the header from ancestor views.
        public struct Key: PreferenceKey {

            public typealias Value = Data

            public static var defaultValue: Data = Data.init(minY: 0)

            public static func reduce(value: inout Data, nextValue: () -> Data) {
                value = nextValue()
            }

        }

        /// Data used in ``Preferences/Header/Key``
        public struct Data: Equatable {

            let minY: CGFloat

        }

    }

    public struct ScrollViewStyle {

        public struct Key: EnvironmentKey {

            /// When no style is set for a ``StylableScrollView``, this style will be used.
            public static let defaultValue: AnyScrollViewStyle = AnyScrollViewStyle(

                PrimitiveScrollViewStyle()

            )

        }

    }

    /// All the preference keys related with the navigation bar.
    @available(iOS 15.0, macOS 12.0, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public struct NavigationBar {

        public struct Elements {

            /// Allows us to read the fake navbar elements from ancestor views.
            public struct Key: PreferenceKey {
                public typealias Value = [Data]

                public static var defaultValue: [Data] = []

                public static func reduce(value: inout [Data], nextValue: () -> [Data]) {
                    value.append(contentsOf: nextValue())
                }
            }

            /// Data used in ``Preferences/NavigationBar/Elements/Key``
            public struct Data: Equatable {

                public static func == (lhs: Data, rhs: Data) -> Bool {
                    return lhs.id == rhs.id
                }

                let id = UUID()
                let axis: HorizontalEdge
                let element: AnyView
            }

        }

    }

}
