//
//  MainViewController.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import UIKit
import SDWebImage

private let topCellReuseIdentifier = "TopArticleTableViewCell"
private let regularCellReuseIdentifier = "RegularArticleTableViewCell"

class MainViewController: UIViewController, StoryboardLoadable {
    
    @IBOutlet private var newsTableView: UITableView!
    
    private var refreshControl = UIRefreshControl()

    private var viewModel = MainViewModel()

    let cellSpacingHeight: CGFloat = 5

    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        newsTableView.addSubview(refreshControl)
        
        viewModel.delegate = self
        refreshView()
    }
}

// MARK: Instance methods
extension MainViewController {
    
    func updateLoadingState() {
        
        if viewModel.isLoading == true {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .medium
            loadingIndicator.startAnimating();
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.dismiss(animated: false, completion: {
                    self?.refreshControl.endRefreshing()
                    if let alertViewModel = self?.viewModel.errorAlertViewModel {
                        let alert = UIAlertController.buildAlertController(for: alertViewModel)
                        self?.present(alert, animated: true)
                    } else {
                        self?.title = self?.viewModel.screenTitle
                        self?.newsTableView.reloadData()
                        self?.refreshControl.endRefreshing()
                    }
                })
            }
        }
    }
    
    @objc func refreshView() {
        viewModel.reloadData()
        updateLoadingState()
    }
    
    func configureCell<T: UITableViewCell>(cellType: T, for indexPath: IndexPath) {
        
        if let cell = (cellType as? TopArticleTableViewCell) {
            cell.titleLabel.text = viewModel.titleAt(indexPath: indexPath)
            cell.dateLabel.text = viewModel.dateAt(indexPath: indexPath)
            cell.articleImageView.sd_setImage(with: URL(string: viewModel.imageAt(indexPath: indexPath)), placeholderImage: UIImage(named: "PlaceholderImage"))
        } else if let cell = (cellType as? RegularArticleTableViewCell) {
            cell.titleLabel.text = viewModel.titleAt(indexPath: indexPath)
            cell.dateLabel.text = viewModel.dateAt(indexPath: indexPath)
            cell.articleImageView.sd_setImage(with: URL(string: viewModel.imageAt(indexPath: indexPath)), placeholderImage: UIImage(named: "PlaceholderImage"))
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate methods
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.totalItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: topCellReuseIdentifier, for: indexPath) as! TopArticleTableViewCell
            configureCell(cellType: cell, for: indexPath )
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: regularCellReuseIdentifier, for: indexPath) as! RegularArticleTableViewCell
            configureCell(cellType: cell, for: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = NewsDetailsViewController.instantiate(fromStoryboardNamed: "NewsDetailsViewController")
        viewController.viewModel.item = (viewModel.totalItems[indexPath.section])
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}

// MARK: - MainViewModelDelegate methods
extension MainViewController: MainViewModelDelegate {
    
    func viewModel(_ viewModel: MainViewModel, loadingStateDidChange isLoading: Bool) {
        updateLoadingState()
    }
}
