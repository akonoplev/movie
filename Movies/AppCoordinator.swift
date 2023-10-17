//
//  AppCoordinator.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import UIKit

final class AppCoordinator: NSObject {

    let window: UIWindow
    private let navigationController = UINavigationController()

    private let searchAssembly = SearchAssebly.instance()
    private let detailedAssembly = DetailedAssembly.instance()


    init(window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        super.init()
        setupNavBarAppearance()
    }

    func start() {
        let coordinator = searchAssembly.coordinator(output: self,
                                                     navigationController: navigationController)
        coordinator.start()
    }
}

// MARK: - Search module output
extension AppCoordinator: SearchModuleOutput {
    func showMovieDetailed(movie: MovieProtocol) {
        let context = DetailedContext(movie: movie)
        let coordinator = detailedAssembly.coordinator(context: context,
                                                       output: self,
                                                       navigationController: navigationController)
        coordinator.start()
    }
}

// MARK: - Detailed module output
extension AppCoordinator: DetailedModuleOutput {

}

private extension AppCoordinator {
    func setupNavBarAppearance() {
        if #available(iOS 15, *) {
               let appearance = UINavigationBarAppearance()
               appearance.configureWithOpaqueBackground()
               self.navigationController.navigationBar.isTranslucent = true
               self.navigationController.navigationBar.tintColor = UIColor.white
                appearance.shadowColor = .clear
               UINavigationBar.appearance().standardAppearance = appearance
               UINavigationBar.appearance().scrollEdgeAppearance = appearance
           }
    }
}
