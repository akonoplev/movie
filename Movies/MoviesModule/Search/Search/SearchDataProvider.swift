//
//  SearchDataProvider.swift
//  Movies
//
//  Created by Андрей Коноплев on 16.10.2023.
//

import Combine
import Reachability
import Foundation

protocol SearchDataProviderProtocol {

    var movieListPublisher: AnyPublisher<[MovieProtocol], Never> { get }
    var errorPublisher: AnyPublisher<Error, Never> { get }

    func startNetworkNotifier()
    func updateSearchString(newSearchString: String)
    func resetCurrentPage()
    func loadSearchResult()
    func loadMoreIfPossible()
}

final class SearchDataProvider: SearchDataProviderProtocol {
    
    private let operationManager: OperationManagerProtocol
    private let moviePersistantManager: MoviePersistantManagerProtocol

    private let reachability = try! Reachability()

    private var searchText = ""
    private var currentPage = 1
    private var canLoadMore = false

    private var isNetworkAvailable = true

    @Published
    private var dataSource: [MovieProtocol] = []

    private let errorSubject = PassthroughSubject<Error, Never>()

    var movieListPublisher: AnyPublisher<[MovieProtocol], Never> {
        $dataSource.eraseToAnyPublisher()
    }
    var errorPublisher: AnyPublisher<Error, Never> {
        errorSubject.eraseToAnyPublisher()
    }

    init(
        operationManager: OperationManagerProtocol,
        moviePersistantManager: MoviePersistantManagerProtocol
    ) {
        self.operationManager = operationManager
        self.moviePersistantManager = moviePersistantManager
    }

    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }

    func startNetworkNotifier() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }

    func updateSearchString(newSearchString: String) {
        currentPage = 1
        searchText = newSearchString
    }

    func resetCurrentPage() {
        currentPage = 1
    }

    func loadSearchResult() {
        if isNetworkAvailable {
            loadServerSearchResult()
        } else {
            loadCachedMovies()
        }
    }

    private func loadServerSearchResult() {
        operationManager.search(searchText: searchText,
                                page: currentPage) { [weak self] response in
            guard let self = self else {
                return
            }

            self.moviePersistantManager.saveMovies(response.results)

            self.currentPage = response.page
            self.canLoadMore = response.page != response.total_pages

            if response.page > 1 {
                self.dataSource.append(contentsOf: response.results)
            } else {
                self.dataSource = response.results
            }
        } failire: { [weak self] error in
            self?.errorSubject.send(error)
        }
    }

    private func loadCachedMovies() {
        let cachedMovies = moviePersistantManager.getMovies()
        let filtereCacheddMovies = cachedMovies.filter {
            ($0.overview?.contains(searchText) ?? false) || $0.title?.contains(searchText) ?? false
        }

        dataSource = searchText.isEmpty ? cachedMovies : filtereCacheddMovies
    }

    func loadMoreIfPossible() {
        if isNetworkAvailable && canLoadMore {
            currentPage += 1
            loadSearchResult()
        }
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi, .cellular:
            self.isNetworkAvailable = true
        case .unavailable:
            self.isNetworkAvailable = false
            if dataSource.isEmpty {
                self.loadCachedMovies()
            }
        }
    }
}
