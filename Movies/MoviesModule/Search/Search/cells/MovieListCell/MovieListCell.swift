//
//  MovieListCell.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import SDWebImage
import UIKit

class MovieListCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @discardableResult
    func configure(movie: MovieProtocol) -> Self {

        if let posterPath = movie.poster_path, 
            let url = URL(string: GlobalConstants.API.imgURL + posterPath) {
            imgView.sd_setImage(with: url, placeholderImage: UIImage.posterPlaceholder)
        } else {
            imgView.image = UIImage.posterPlaceholder
        }

        titleLbl.text = movie.title
        releaseLbl.text = movie.release_date


        return self
    }

}
