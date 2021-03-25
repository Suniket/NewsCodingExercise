//
//  UIViewController+StoryboardLoadable.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import UIKit

/// A view controller that has Interface Builder components stored withing a storyboard.
protocol StoryboardLoadable {

    /// The name of the storyboard file containing the view controller.
    static var storyboardName: String { get }

    /// The identifier of the view controller within the storyboard.
    static var storyboardIdentifier: String { get }
}

// MARK: - Instantiating helper methods
extension StoryboardLoadable where Self: UIViewController {

    static var storyboardName: String {
        return String(describing: self)
    }

    static var storyboardIdentifier: String {
        return String(describing: self)
    }

    /// Instantiates an instance of the view controller from the specified storyboard,
    /// based on the view controller's `storyboardIdentifier` property.
    ///
    /// - Parameter name: The name of the storyboard file to load the view controller from.
    ///                   If nil, it is assumed the storyboard has the same filename as the class.
    /// - Returns: The instantiated view controller.
    static func instantiate(fromStoryboardNamed name: String? = nil) -> Self {
        let storyboardName = name ?? self.storyboardName
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        return instantiate(fromStoryboard: storyboard)
    }

    /// Instantiates an instance of the view controller from the specified storyboard,
    /// based on the view controller's `storyboardIdentifier` property.
    ///
    /// - Parameter storyboard: The storyboard to load the view controller from.
    /// - Returns: The instantiated view controller.
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> Self {
        let identifier = self.storyboardIdentifier
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Failed to instantiate view controller with identifier=\(identifier) from storyboard \( storyboard )")
        }
        return controller
    }

    /// Instantiates the view controller marked 'initial' from the specified storyboard.
    ///
    /// - Parameter name: The name of the storyboard file to load the view controller from.
    ///                   If nil, it is assumed the storyboard has the same filename as the class.
    /// - Returns: The instantiated view controller.
    static func initial(fromStoryboardNamed name: String? = nil) -> Self {
        let storyboardName = name ?? self.storyboardName
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        return initial(fromStoryboard: storyboard)
    }

    /// Instantiates the view controller marked 'initial' from the specified storyboard.
    ///
    /// - Parameter storyboard: The storyboard to load the view controller from.
    /// - Returns: The instantiated view controller.
    static func initial(fromStoryboard storyboard: UIStoryboard) -> Self {
        guard let controller = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Failed to instantiate initial view controller from storyboard named \( storyboard )")
        }
        return controller
    }
}
