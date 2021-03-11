//
//  TrailerViewModel.swift
//  Moviez
//
//  Created by Punit Vaigankar on 11/03/21.
//

import Foundation

/*!
 * @typedef TrailerViewModel
 * @brief ViewModel class for Trailers
 */
class TrailerViewModel: NSObject {
 
    /*!
     * @brief API class to make API calls
     */
    private var movieService:MovieService!
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
    var movieId:Int! {
        didSet {
            self.getMovieTrailers()
        }
    }
    /*!
     * @brief holds trailers list for the movie
     */
    private(set) var movieVideoInfo:[VideoResult]! {
        didSet {
            self.bindTrailerList()
        }
    }
    /*!
     * @brief binds trailer data to tableview
     */
    var bindTrailerList: (() -> ()) = {}
    
    override init() {
        self.movieService = MovieService()
        movieVideoInfo = []
    }
    
    /*!
     * @brief Fetches movie video details for a movie from API
     */
    func getMovieTrailers() {
        self.movieService.fetchMovieVideoDetails(movieId: self.movieId) { (movieVideoInfo) in
            self.movieVideoInfo = movieVideoInfo.results
        }
    }
}
