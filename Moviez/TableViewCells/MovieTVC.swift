//
//  MovieTVC.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import UIKit
import SDWebImage

class MovieTVC: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterIV: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieTitleButton: UIButton!
    
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
    
    func configureCell(title:String?, imageUrl:String?, index:Int?) {
        
        self.movieTitleLabel.text = title
        let imageUrl = MovieService.imageBaseUrl + (imageUrl ?? "")
        self.moviePosterIV.sd_setImage(with: URL(string: imageUrl))
        self.movieTitleButton.tag = index ?? -1
    }

}
