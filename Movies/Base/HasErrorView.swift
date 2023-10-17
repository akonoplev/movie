//
//  HasErrorView.swift
//  Movies
//
//  Created by Андрей Коноплев on 17.10.2023.
//

import SPIndicator
import UIKit

protocol HasErrorView: AnyObject {
    func showError(error: Error)
    func showSuccess(text: String, type: SPIndicatorIconPreset)
}

extension HasErrorView where Self: UIViewController {
    func showError(error: Error) -> Void {
        let indicatorView = SPIndicatorView(title: error.localizedDescription, preset: .error)
        indicatorView.duration = 2
        indicatorView.present(haptic: .error, completion: nil)
    }

    func showSuccess(text: String, type: SPIndicatorIconPreset) {
        let indicatorView = SPIndicatorView(title: text, preset: type)
        indicatorView.duration = 2
        indicatorView.present(completion: nil)
    }
}
