//
//  UIFont+.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/15.
//

import UIKit

extension UIFont {
    static func preferredFont(for style: TextStyle) -> UIFont {
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize)
        let metric = UIFontMetrics(forTextStyle: style)
        return metric.scaledFont(for: font)
    }
}
