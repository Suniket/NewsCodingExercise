//
//  NewsDetailsViewController.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import UIKit

private let cellReuseIdentifier = "NewsDetailsTableViewCell"

class NewsDetailsViewController: UIViewController, StoryboardLoadable {
    
    var viewModel = NewsDetailsViewModel()
    
    let cellSpacingHeight: CGFloat = 5
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate methods
extension NewsDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NewsDetailsTableViewCell
        
        if let imageHref = viewModel.item?.thumbnail {
            cell.articleImageView.sd_setImage(with: URL(string: imageHref), placeholderImage: UIImage(named: "PlaceholderImage"))
        }
        cell.titleLabel.text = viewModel.item?.title
        cell.dateLabel.text = viewModel.pubDate
        cell.contentLabel.text = viewModel.item?.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
