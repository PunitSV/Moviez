//
//  MovieDetailsViewModel.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import Foundation

/*!
 * @typedef MovieDetailsViewModel
 * @brief ViewModel class for MovieDetails
 */
class MovieDetailsViewModel: NSObject {
    /*!
     * @brief API class to make API calls
     */
    private var movieService:MovieService!
    /*!
     * @brief Database class to make datbase related operations
     */
    private var databaseHelper:DataBaseHelper!
    /*!
     * @brief To indicate network activity
     */
    private var isLoading:Bool! {
        didSet {
            if(isLoading) {
                
            } else {
                
            }
        }
    }
    /*!
     * @brief Id associated with movie to fetch movie details
     */
    var movieId:Int!
    /*!
     * @brief holds Image url of movie poster
     */
    private(set) var posterImage:String! {
        didSet {
            self.bindPosterImage()
        }
    }
    /*!
     * @brief holds name of the movie
     */
    private(set) var movieTitle:String! {
        didSet {
            self.bindMovieTitle()
        }
    }
    /*!
     * @brief holds genres of the movie
     */
    private(set) var genres:String! {
        didSet {
            self.bindGenre()
        }
    }
    /*!
     * @brief holds released date of the movie
     */
    private(set) var date:String! {
        didSet {
            self.bindDate()
        }
    }
    /*!
     * @brief holds languages of the movie
     */
    private(set) var languages:String! {
        didSet {
            self.bindLanguages()
        }
    }
    /*!
     * @brief holds average voting of the movie
     */
    private(set) var averageVoting:Double! {
        didSet {
            self.bindAverageVoting()
        }
    }
    /*!
     * @brief holds duration of the movie
     */
    private(set) var duration:String! {
        didSet {
            self.bindDuration()
        }
    }
    /*!
     * @brief holds overview of the movie
     */
    private(set) var overview:String! {
        didSet {
            self.bindOverview()
        }
    }
    /*!
     * @brief binds poster image of the movie to UI
     */
    var bindPosterImage: (() -> ()) = {}
    /*!
     * @brief binds name of the movie to UI
     */
    var bindMovieTitle: (() -> ()) = {}
    /*!
     * @brief binds genres of the movie to UI
     */
    var bindGenre: (() -> ()) = {}
    /*!
     * @brief binds released date of the movie to UI
     */
    var bindDate: (() -> ()) = {}
    /*!
     * @brief binds languages of the movie to UI
     */
    var bindLanguages: (() -> ()) = {}
    /*!
     * @brief binds average vote of the movie to UI
     */
    var bindAverageVoting: (() -> ()) = {}
    /*!
     * @brief binds duration of the movie to UI
     */
    var bindDuration: (() -> ()) = {}
    /*!
     * @brief holds overview of the movie
     */
    var bindOverview: (() -> ())! {
        didSet{
            self.getMovieDetails()
        }
    }
    
    override init() {
        super.init()
        self.movieService = MovieService()
        self.databaseHelper = DataBaseHelper()
        self.genres = ""
        self.languages = ""
    }
    
    /*!
     * @brief Fetches movie details for a movie from API
     */
    func getMovieDetails() {
        
        if(Connectivity.isConnectedToInternet()) {
            self.movieService.fetchMovieDetails(movieId: movieId) { (movie) in
                self.posterImage = MovieService.imageBaseUrl_w400 + movie.posterPath!
                self.movieTitle = movie.title
                
                for genre in movie.genres! {
                    self.genres += genre.name! + ","
                }
                self.genres.removeLast()
                
                self.date = movie.releaseDate!
                for language in movie.spokenLanguages! {
                    self.languages += language.name! + ","
                }
                self.languages.removeLast()
                if let duration = movie.runtime {
                    self.duration = "\(duration) min"
                } else {
                    self.duration = "-"
                }
                
                self.averageVoting = movie.voteAverage
                self.overview = movie.overview!
                
                self.databaseHelper.emptyMovieDetails(withMovieId: self.movieId)
                self.databaseHelper.addMovieDetailsToDB(movie: movie)
            }
        } else {
            self.databaseHelper.getMovieDetails(movieId: self.movieId) { (movie) in
                self.posterImage = MovieService.imageBaseUrl_w400 + movie.posterPath!
                self.movieTitle = movie.title
                
                for genre in movie.genres! {
                    self.genres += genre.name! + ","
                }
                self.genres.removeLast()
                
                self.date = movie.releaseDate!
                for language in movie.spokenLanguages! {
                    self.languages += language.name! + ","
                }
                self.languages.removeLast()
                if let duration = movie.runtime {
                    self.duration = "\(duration) min"
                } else {
                    self.duration = "-"
                }
                
                self.averageVoting = movie.voteAverage
                self.overview = movie.overview!
            }
        }
    }
}
