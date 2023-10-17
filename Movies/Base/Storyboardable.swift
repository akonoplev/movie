//
//  Storyboardable.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import UIKit

//MARK: - work with storyboards
protocol Storyboardable {
    static func storyBoardName() -> String
}

// MARK:- Create
extension Storyboardable where Self: UIViewController {
    
    static func create() -> Self {

        let storyboard = self.storyboard()

        let className = NSStringFromClass(Self.self)
        let finalClassName = className.components(separatedBy: ".").last!
        let viewControllerId = finalClassName + "ID"
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId)
        return viewController as! Self
    }

    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: storyBoardName(), bundle: nil)
    }
}
