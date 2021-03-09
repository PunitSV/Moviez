//
//  MovieDetailsVC.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import UIKit
import SDWebImage

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var moviePosterIV: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTrailerButton: UIButton!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
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
        
        self.movieDetailViewModel.bindOverview = {
            self.updateMovieOverview()
        }
    }
    
    func updatePoster() {
        self.moviePosterIV.sd_setImage(with: URL(string: self.movieDetailViewModel.posterImage!))
        
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
    
    func updateMovieOverview() {
        self.overviewLabel.text = self.movieDetailViewModel.overview
    }

    @IBAction func watchTrailer(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
