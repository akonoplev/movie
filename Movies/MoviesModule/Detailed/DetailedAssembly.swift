//
//  DetailedAssembly.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import EasyDi

protocol DetailedModuleOutput {

}

final class DetailedAssembly: Assembly {

    // MARK: - coordinator
    func coordinator(
        context: DetailedContext,
        output: DetailedModuleOutput,
        navigationController: UINavigationController
    ) -> DetailedCoordinatorProtocol {
        return define(init: DetailedCoordinator(context: context,
                                                output: output,
                                                assembly: self,
                                                navigationController: navigationController)) {
            $0
        }
    }

    // MARK: - viewControllers
    func detailedVC(movie: MovieProtocol, coordinator: DetailedCoordinatorProtocol) -> DetailedViewController {
        return define(init: DetailedViewController.create()) {
            $0.presenter = self.detailedPresenter(movie: movie,
                                                  view: $0,
                                                  coordinator: coordinator)
            return $0
        }
    }
}

// MARK: - Module's presenters
private extension DetailedAssembly {
    func detailedPresenter(
        movie: MovieProtocol,
        view: DetailedViewProtocol,
        coordinator: DetailedCoordinatorProtocol
    ) -> DetailedPresenterProtocol {
        return define(init: DetailedPresenter(
            movie: movie
        )) {
            $0.view = view
            $0.coordinator = coordinator
            return $0
        }
    }
}

