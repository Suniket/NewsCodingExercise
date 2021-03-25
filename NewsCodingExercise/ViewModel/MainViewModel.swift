//
//  MainViewModel.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import UIKit
import Foundation

protocol MainViewModelDelegate: AnyObject {
    
    /// Method to notify abouty loading state.
    /// - Parameters:
    ///   - viewModel: MainViewModel
    ///   - isLoading: Loading status
    func viewModel(_ viewModel: MainViewModel, loadingStateDidChange isLoading: Bool)
    
}

class MainViewModel: NSObject {
    
    weak var delegate: MainViewModelDelegate?
    
    var errorAlertViewModel: AlertViewModel?

    var totalItems = [Item]()
    
    var screenTitle = ""
    
    var networkManager = NetworkManager(session: URLSession(configuration: .ephemeral))
    
    /// Indicates whether the view is considered to be loading. The default is
    /// `false`. Setting this property automatically updates the delegate.
    var isLoading: Bool = false {
        didSet {
            if isLoading != oldValue {
                delegate?.viewModel(self, loadingStateDidChange: isLoading)
            }
        }
    }
    
    /// Refresh view.
    func reloadData() {
        isLoading = true
        loadRSSFeedData()
    }
    
    func loadRSSFeedData() {
        networkManager.loadData(from: AppConfiguration.applicationBaseUrl, type: NewsResponse.self) { [weak self] response in
            
            switch response {
            case let .success(newsResponse):
                self?.errorAlertViewModel = nil
                self?.isLoading = false
                
                self?.totalItems = newsResponse.items
                self?.screenTitle = newsResponse.feed.title ?? ""
                
            case let .failure(error):
                let alertViewModel = AlertViewModel(actionModels: [AlertViewModel.ActionModel(title: "OK", style: .cancel, handler: nil)],
                                                    title: "Error",
                                                    message: error.errorDescription,
                                                    prefferedStyle: .alert)
                self?.errorAlertViewModel = alertViewModel
                self?.isLoading = false
            }
        }
    }
    
    func processedDates() -> [String] {
        var processedDates = [String]()
        for (_, item) in (self.totalItems).enumerated() {
            processedDates.append(DateFormatter.requiredFormattedPubDate(pubDate: item.pubDate ?? ""))
        }
        return processedDates
    }
}

extension MainViewModel {
    
    func titleAt(indexPath: IndexPath) -> String {
        return totalItems[indexPath.section].title ?? ""
    }
    
    func dateAt(indexPath: IndexPath) -> String {
        return processedDates()[indexPath.section]
    }
    
    func imageAt(indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            return totalItems[indexPath.section].enclosure?.link ?? ""
        } else {
            return totalItems[indexPath.section].thumbnail ?? ""
        }
    }
}
