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

extension Color {

    /// `Color.systemGray6` multi-platform equivalent.
    ///
    /// - Parameters:
    ///    - scheme: The current color scheme.
    static func systemGray6(for scheme: ColorScheme) -> Color {
        return scheme == .light ? Color(red: 0.95, green: 0.95, blue: 0.97) : Color(red: 0.11, green: 0.11, blue: 0.12)
    }

    /// A multi-platform solution for obtaining the window's background color.
    static var backgroundColor: Color {

        #if os(iOS)
        return Color(.systemBackground)
        #else
        return Color(.windowBackgroundColor)
        #endif
    }

    /// A multi-platform solution for obtaining the window's background color, but inverted.
    ///
    /// This one is not that accurate but who cares anyway. If you seem to know how to invert
    /// these colors without converting them to a `View`, which is what `Color.colorInvert()`
    /// does, feel free to open a PR.
    static func backgroundColorInverted(for scheme: ColorScheme) -> Color {

        return scheme == .dark ? .white : .black
    }

}
