//
//  DetailedViewController.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import UIKit

protocol DetailedViewProtocol: AnyObject {
    
}

final class DetailedViewController: UIViewController, DetailedViewProtocol {

    var presenter: DetailedPresenterProtocol! // inject

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            registerCells()
        }
    }

    private let headerCellId = "headerCellId"
    private let infoCellId = "infoCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        navigationItem.title = presenter.movie.title
        navigationItem.backButtonDisplayMode = .minimal
    }

    private func registerCells() {
        let headerNib = UINib(nibName: "DetailedHeaderCell", bundle: nil)
        let infoNib = UINib(nibName: "DetailedInfoCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: headerCellId)
        tableView.register(infoNib, forCellReuseIdentifier: infoCellId)
    }
}

extension DetailedViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItem()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.item(at: indexPath) {
        case let .header(imgPath):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: headerCellId, for: indexPath) as? DetailedHeaderCell else {
                return UITableViewCell()
            }

            return cell.configure(path: imgPath)
        case let .info(title, releaseDate, overview):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath) as? DetailedInfoCell else {
                return UITableViewCell()
            }

            return cell.configure(title: title, release: releaseDate, overview: overview)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension DetailedViewController: Storyboardable {
    static func storyBoardName() -> String {
        return "Detailed"
    }
}
