//
//  MovieDetailsViewModel.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import Foundation

class MovieDetailsViewModel: NSObject {
    
    
    private var movieService:MovieService!
    private var databaseHelper:DataBaseHelper!
    
    private var isLoading:Bool! {
        didSet {
            if(isLoading) {
                
            } else {
                
            }
        }
    }
    
    var movieId:Int!
    
    private(set) var posterImage:String! {
        didSet {
            self.bindPosterImage()
        }
    }
    
    private(set) var movieTitle:String! {
        didSet {
            self.bindMovieTitle()
        }
    }
    
    private(set) var genres:String! {
        didSet {
            self.bindGenre()
        }
    }
    private(set) var date:String! {
        didSet {
            self.bindDate()
        }
    }
    private(set) var languages:String! {
        didSet {
            self.bindLanguages()
        }
    }
    private(set) var overview:String! {
        didSet {
            self.bindOverview()
        }
    }

    var bindPosterImage: (() -> ()) = {}
    var bindMovieTitle: (() -> ()) = {}
    var bindGenre: (() -> ()) = {}
    var bindDate: (() -> ()) = {}
    var bindLanguages: (() -> ()) = {}
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
                
                self.overview = movie.overview!
            }
        }
    }
}
