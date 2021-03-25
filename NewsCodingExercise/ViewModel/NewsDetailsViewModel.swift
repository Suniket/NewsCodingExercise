//
//  NewsDetailsViewModel.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import Foundation

class NewsDetailsViewModel: NSObject {
    
    var item: Item?
    
    var pubDate: String {
        return (DateFormatter.requiredFormattedPubDate(pubDate: item?.pubDate ?? ""))
    }
     
}
