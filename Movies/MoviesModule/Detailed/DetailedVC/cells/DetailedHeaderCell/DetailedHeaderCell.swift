//
//  DetailedHeaderCell.swift
//  Movies
//
//  Created by Андрей Коноплев on 15.10.2023.
//

import UIKit

final class DetailedHeaderCell: UITableViewCell {

    @IBOutlet private weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @discardableResult
    func configure(path: String?) -> Self {

        if let posterPath = path,
            let url = URL(string: GlobalConstants.API.imgURL + posterPath) {
            imgView.sd_setImage(with: url, placeholderImage: UIImage.posterPlaceholder)
        } else {
            imgView.image = UIImage.posterPlaceholder
        }

        return self
    }
}
