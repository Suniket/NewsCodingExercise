//
//  NewsDetailsTableViewCell.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import UIKit

class NewsDetailsTableViewCell: UITableViewCell {
    @IBOutlet var articleImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var contentLabel: UILabel!

}

extension NewsDetailsTableViewCell {
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 10
            frame.size.width -= 2 * 10
            super.frame = frame
        }
    }
}
