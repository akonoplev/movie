//
//  DetailedCoordinator.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import UIKit

protocol DetailedCoordinatorProtocol: BaseCoordinator { }

final class DetailedCoordinator: DetailedCoordinatorProtocol {

    private let context: DetailedContext
    private let output: DetailedModuleOutput
    private let assembly: DetailedAssembly
    private let navigationController: UINavigationController

    init(
        context: DetailedContext,
        output: DetailedModuleOutput,
        assembly: DetailedAssembly,
        navigationController: UINavigationController
    ) {
        self.context = context
        self.output = output
        self.assembly = assembly
        self.navigationController = navigationController
    }

    func start() {
        let viewController = assembly.detailedVC(movie: context.movie, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
