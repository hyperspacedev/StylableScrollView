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
*   Created by Alex Modroño Vara on 26/12/21.
*
*/
import Foundation
import SwiftUI

// MARK: - NAVIGATION BAR
//
/// A proxy for access to several aspects of a Navigation Bar Element,
/// such as whether the navigation bar has changed display mode, the
/// preferred color for navigation bar elements, and more.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct NavigationBarProxy {

    public enum Mode {
        case large
        case inline
    }

    public var mode: Mode

    public var elementsColor: Color

}
