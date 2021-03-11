//
//  MovieDetailsVC.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import UIKit
import SDWebImage
import Cosmos

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var moviePosterIV: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTrailerButton: UIButton!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var durationLabel: UILabel!
    
    public var movieDetailViewModel:MovieDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    func bindViewModel() {
        
        self.movieDetailViewModel.bindPosterImage = {
            self.updatePoster()
        }
        
        self.movieDetailViewModel.bindMovieTitle = {
            self.updateMovieTitle()
        }
        
        self.movieDetailViewModel.bindGenre = {
            self.updateMovieGenre()
        }
        
        self.movieDetailViewModel.bindDate = {
            self.updateMovieDate()
        }
        
        self.movieDetailViewModel.bindLanguages = {
            self.updateMovieLanguages()
        }
        
        self.movieDetailViewModel.bindDuration = {
            self.updateDuration()
        }
        
        self.movieDetailViewModel.bindAverageVoting = {
            self.updateRatings()
        }
        self.movieDetailViewModel.bindOverview = {
            self.updateMovieOverview()
        }
    }
    
    func updatePoster() {
        self.moviePosterIV.sd_setImage(with: URL(string: self.movieDetailViewModel.posterImage!), placeholderImage: UIImage(named: "image_placeholder"))
        
    }
    
    func updateMovieTitle() {
        self.movieTitleLabel.text = self.movieDetailViewModel.movieTitle
    }
    
    func updateMovieGenre() {
        self.genresLabel.text = self.movieDetailViewModel.genres
    }
    
    func updateMovieDate() {
        self.releasedDateLabel.text = self.movieDetailViewModel.date
    }
    
    func updateMovieLanguages() {
        self.languagesLabel.text = self.movieDetailViewModel.languages
    }
    
    func updateDuration() {
        self.durationLabel.text = self.movieDetailViewModel.duration
    }
    
    func updateRatings() {
        self.ratingView.rating = self.movieDetailViewModel.averageVoting
    }
    
    func updateMovieOverview() {
        self.overviewLabel.text = self.movieDetailViewModel.overview
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "trailers") {
            if let trailerController = segue.destination as? TrailersTVC {
                let trailerViewModel = TrailerViewModel()
                trailerViewModel.movieId = self.movieDetailViewModel.movieId
                trailerController.trailerViewModel = trailerViewModel
            }
            
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "trailers" && Connectivity.isConnectedToInternet()) {
            return true
        } else {
            let alert = UIAlertController(title: "", message: "You seems to be offline.Please check your internet connection.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
    }

}
