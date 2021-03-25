//
//  TopArticleTableViewCell.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 25/3/21.
//

import UIKit

class TopArticleTableViewCell: UITableViewCell {
    
    @IBOutlet var articleImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
}

extension TopArticleTableViewCell {
    
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
