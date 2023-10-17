//
//  MovieCoordinator.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import UIKit

protocol SearchCoordinatorProtocol: BaseCoordinator {
    func didSelectMovie(movie: MovieProtocol)
}

final class SearchCoordinator: SearchCoordinatorProtocol {

    private let output: SearchModuleOutput
    private let assembly: SearchAssebly
    private let navigationController: UINavigationController

    init(
        output: SearchModuleOutput,
        assembly: SearchAssebly,
        navigationVC: UINavigationController
    ) {
        self.output = output
        self.assembly = assembly
        self.navigationController = navigationVC
    }

    func start() {
        let viewController = assembly.searchVC(coordinator: self)
        navigationController.viewControllers = [viewController]
    }

    func didSelectMovie(movie: MovieProtocol) {
        output.showMovieDetailed(movie: movie)
    }

}
