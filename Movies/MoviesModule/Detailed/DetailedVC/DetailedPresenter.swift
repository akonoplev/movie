//
//  DetailedPresenter.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

protocol DetailedPresenterProtocol: AnyObject {
    var movie: MovieProtocol { get }
    func numberOfItem() -> Int
    func item(at indexPath: IndexPath) -> DetailedPresenter.CellType
}

final class DetailedPresenter: DetailedPresenterProtocol {

    weak var view: DetailedViewProtocol?
    var coordinator: DetailedCoordinatorProtocol?

    private var dataSource: [CellType] = []

    let movie: MovieProtocol

    init(movie: MovieProtocol) {
        self.movie = movie
        setupDataSource()
    }

    private func setupDataSource() {
        dataSource.append(.header(imgPath: movie.poster_path))
        dataSource.append(.info(title: movie.title, releaseDate: movie.release_date, overview: movie.overview))
    }

    func numberOfItem() -> Int {
        dataSource.count
    }

    func item(at indexPath: IndexPath) -> DetailedPresenter.CellType {
        dataSource[indexPath.row]
    }
}

extension DetailedPresenter {
    enum CellType {
        case header(imgPath: String?)
        case info(title: String?, releaseDate: String?, overview: String?)
    }
}
