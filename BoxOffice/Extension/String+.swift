//
//  String+.swift
//  BoxOffice
//
//  Created by Kobe, yyss99 on 2023/08/12.
//

import Foundation

extension String {
    func changeNumberFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: Double(self)) ?? "Error"
    }
    
    mutating func formattedDateWithHyphen() -> String {
        self.insert("-", at: self.index(self.startIndex, offsetBy: 4))
        self.insert("-", at: self.index(self.endIndex, offsetBy: -2))
        
        return self
    }
}
