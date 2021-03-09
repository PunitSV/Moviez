//
//  MovieDetailsViewModel.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import Foundation

class MovieDetailsViewModel: NSObject {
    
    var movieId:String! {
        didSet {
            self.getMovieDetails()
        }
    }
    private var movieService:MovieService!
    private(set) var movie:Movie! {
        didSet {
            self.bindMovieInfo()
        }
    }
    private var isLoading:Bool! {
        didSet {
            if(isLoading) {
                
            } else {
                
            }
        }
    }
    var bindMovieInfo: (() -> ()) = {}
    
    
    override init() {
        super.init()
        movieService = MovieService()
    }
    
    func getMovieDetails() {
        self.movieService.fetchMovieDetails(movieId: movieId) { (movie) in
            self.movie = movie
        }
    }
}
