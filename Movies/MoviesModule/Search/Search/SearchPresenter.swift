//
//  SearchPresenter.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Combine
import Foundation

protocol SearchPresenterProtocol {
    func viewIsReady()
    func numberOfItems() -> Int
    func item(at indexPath: IndexPath) -> MovieProtocol
    func didSelectMovie(at indexPath: IndexPath)
    func search(searchText: String)
    func loadMore()
}

final class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol? // inject
    var coordinator: SearchCoordinatorProtocol? // inject

    private var dataSource: [MovieProtocol] = []
    private let searchDataProvider: SearchDataProviderProtocol
    private var subscriptions = Set<AnyCancellable>()

    init(searchDataProvider: SearchDataProviderProtocol) {
        self.searchDataProvider = searchDataProvider
    }

    func viewIsReady() {
        searchDataProvider.startNetworkNotifier()
        subscribe()
    }

    func numberOfItems() -> Int {
        dataSource.count
    }

    func item(at indexPath: IndexPath) -> MovieProtocol {
        dataSource[indexPath.row]
    }

    func didSelectMovie(at indexPath: IndexPath) {
        let selectedMovie = dataSource[indexPath.row]
        coordinator?.didSelectMovie(movie: selectedMovie)
    }

    func search(searchText: String) {
        searchDataProvider.updateSearchString(newSearchString: searchText)
        searchDataProvider.loadSearchResult()

    }

    func loadMore() {
        searchDataProvider.loadMoreIfPossible()

    }

    private func subscribe() {
        searchDataProvider.errorPublisher
            .receive(on: DispatchQueue.main)
            .sink { error in
                self.view?.showError(error: error)
            }.store(in: &subscriptions)
        
        searchDataProvider.movieListPublisher
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] movies in
                guard let self = self else {
                    return
                }

                self.dataSource = movies
                self.view?.reloadData()
            }.store(in: &subscriptions)

    }
}
