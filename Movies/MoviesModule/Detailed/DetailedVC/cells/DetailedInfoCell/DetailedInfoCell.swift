//
//  DetailedInfoCell.swift
//  Movies
//
//  Created by Андрей Коноплев on 15.10.2023.
//

import UIKit

final class DetailedInfoCell: UITableViewCell {

    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var releaseLbl: UILabel!
    @IBOutlet private weak var overviewLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @discardableResult
    func configure(
        title: String?,
        release: String?,
        overview: String?
    ) -> Self {
        titleLbl.text = title
        releaseLbl.text = release
        overviewLbl.text = overview
        return self
    }
}
