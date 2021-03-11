//
//  TrailerViewModel.swift
//  Moviez
//
//  Created by Punit Vaigankar on 11/03/21.
//

import Foundation

class TrailerViewModel: NSObject {
 
    private var movieService:MovieService!
    private var isLoading:Bool! {
        didSet {
            if(isLoading) {
                
            } else {
                
            }
        }
    }
    
    var movieId:Int! {
        didSet {
            self.getMovieTrailers()
        }
    }
    private(set) var movieVideoInfo:[VideoResult]! {
        didSet {
            self.bindTrailerList()
        }
    }
    
    var bindTrailerList: (() -> ()) = {}
    
    override init() {
        self.movieService = MovieService()
        movieVideoInfo = []
    }
    
    func getMovieTrailers() {
        self.movieService.fetchMovieVideoDetails(movieId: self.movieId) { (movieVideoInfo) in
            self.movieVideoInfo = movieVideoInfo.results
        }
    }
}
