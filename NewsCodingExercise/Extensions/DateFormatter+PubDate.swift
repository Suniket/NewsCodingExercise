//
//  DateFormatter+PubDate.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import Foundation

extension DateFormatter {
    
    static func requiredFormattedPubDate(pubDate: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateStyle = .long
        dateFormatterPrint.timeStyle = .short
        
        guard let rawDate = dateFormatterGet.date(from: pubDate) else { return pubDate }
        return dateFormatterPrint.string(from: rawDate)
    }
}
