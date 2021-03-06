//
//  MovieTVC.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import UIKit
import SDWebImage
import Cosmos

/*!
 * @typedef MovieTVC
 * @brief UI to display for movie catalog list
 */
class MovieTVC: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterIV: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieTitleButton: UIButton!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        containerView.setNeedsLayout()
        containerView.needsUpdateConstraints()
        containerView.layoutIfNeeded()
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowPath = UIBezierPath(rect: containerView.bounds).cgPath
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*!
     * @discussion assigned data to UI cell
     * @param title Name of the movie
     * @param imageUrl Endpath of the movie poster
     * @param language Language of the movie
     * @param averageVote Average vote for the movie
     */
    func configureCell(title:String?, imageUrl:String?, index:Int?,language:String?, averageVote:Double?) {
        
        self.movieTitleLabel.text = title
        let imageUrl = MovieService.imageBaseUrl_w200 + (imageUrl ?? "")
        self.moviePosterIV.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "image_placeholder"))
        self.movieTitleButton.tag = index ?? -1
        self.languageLabel.text = language
        self.ratingView.rating = averageVote ?? 0.0
    }

}
