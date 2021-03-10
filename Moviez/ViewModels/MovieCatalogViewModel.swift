//
//  MovieCatalogViewModel.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import Foundation

class MovieCatalogViewModel: NSObject {
    
    private var movieService:MovieService!
    private var databaseHelper:DataBaseHelper!
    private(set) var results:[Result]! {
        didSet {
            self.bindMoviesToTableView()
        }
    }
    private var isLoading:Bool! {
        didSet {
            if(isLoading) {
                
            } else {
                
            }
        }
    }
    var bindMoviesToTableView: (() -> ())! {
        didSet {
            getMovieCatalog()
        }
    }
    
    
    override init() {
        super.init()
        movieService = MovieService()
        databaseHelper = DataBaseHelper()
    }
    
    func getMovieCatalog() {
        if(Connectivity.isConnectedToInternet()) {
            self.movieService.fetchMovieCatalog(page: 10) { (movies) in
                self.results = movies.results
                self.databaseHelper.emptyMovieCatalog(forPage: 10)
                self.databaseHelper.addMoviesCatalogToDB(movies: movies)
            }
        } else {
            self.databaseHelper.getMovieCatalog(page: 10) { (movies) in
                self.results = movies.results
            }
        }
    }
}
