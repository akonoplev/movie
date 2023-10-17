//
//  SearchViewController.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import UIKit

protocol SearchViewProtocol: AnyObject, HasErrorView {
    func reloadData()
}

final class SearchViewController: UIViewController, SearchViewProtocol {

    var presenter: SearchPresenterProtocol! // inject

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            registerCells()
        }
    }
    private let cellId = "MovieListCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter.viewIsReady()
    }

    func reloadData() {
        tableView.reloadData()
    }

    private func setupLayout() {
        navigationItem.title = "Movies search"
        tableView.keyboardDismissMode = .onDrag
    }

    private func registerCells() {
        let nib = UINib(nibName: "MovieListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MovieListCell else {
            return UITableViewCell()
        }

        return cell.configure(movie: presenter.item(at: indexPath))
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.numberOfItems() - 1 {
            presenter.loadMore()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        view.endEditing(true)
        presenter.didSelectMovie(at: indexPath)
    }
}

//MARK: - search bar delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.search(searchText: searchBar.text ?? "")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension SearchViewController: Storyboardable {
    static func storyBoardName() -> String {
        return "Search"
    }
}
