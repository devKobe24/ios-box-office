//
//  RankIntensity.swift
//  BoxOffice
//
//  Created by Minseong Kang on 2023/08/16.
//

import UIKit

enum RankIntensity {
    case up(Int)
    case down(Int)
    case stay
    
    init?(fromString string: String) {
        if let value = Int(string), value > 0 {
            self = .up(value)
        } else if let value = Int(string), value < 0 {
            self = .down(value)
        } else if string == "0" {
            self = .stay
        } else {
            return nil
        }
    }
    
    func attributedString(withFont font: UIFont) -> NSAttributedString {
        let attributedString: NSMutableAttributedString
        
        switch self {
        case .up(let value):
            attributedString = NSMutableAttributedString(string: "▲\(value)")
            attributedString.addAttributes([
                .foregroundColor: UIColor.red,
                .font: font
            ], range: NSRange(location: 0, length: attributedString.length))
            
        case .down(let value):
            attributedString = NSMutableAttributedString(string: "▼\(value)")
            attributedString.addAttributes([
                .foregroundColor: UIColor.blue,
                .font: font
            ], range: NSRange(location: 0, length: attributedString.length))
            
        case .stay:
            attributedString = NSMutableAttributedString(string: "-")
            attributedString.addAttributes([
                .foregroundColor: UIColor.black,
                .font: font
            ], range: NSRange(location: 0, length: attributedString.length))
        }
        return attributedString
    }
}
