//
//  SearchAssebly.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import EasyDi

protocol SearchModuleOutput {
    func showMovieDetailed(movie: MovieProtocol)
}

final class SearchAssebly: Assembly {

    private let networkAssembly = NetworkServicesAssembley.instance()
    private let persistantAssembly = PersistantAssembly.instance()

    // MARK: - coordinator
    func coordinator(
        output: SearchModuleOutput,
        navigationController: UINavigationController
    ) -> BaseCoordinator {
        return define(init: SearchCoordinator(output: output, 
                                              assembly: self,
                                              navigationVC: navigationController)) {
            $0
        }
    }

    // MARK: - viewControllers
    func searchVC(coordinator: SearchCoordinatorProtocol) -> SearchViewController {
        return define(init: SearchViewController.create()) {
            $0.presenter = self.searchPresenter(view: $0, coordinator: coordinator)
            return $0
        }
    }
}

// MARK: - Module's presenters
private extension SearchAssebly {
    func searchPresenter(
        view: SearchViewProtocol,
        coordinator: SearchCoordinatorProtocol
    ) -> SearchPresenterProtocol {
        return define(init: SearchPresenter(
            searchDataProvider: SearchDataProvider(operationManager: self.networkAssembly.operationManager,
                                                   moviePersistantManager: self.persistantAssembly.movePersistantManager)
        )) {
            $0.view = view
            $0.coordinator = coordinator
            return $0
        }
    }
}
