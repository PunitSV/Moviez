//
//  MovieCatalogViewModel.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import Foundation

class MovieCatalogViewModel: NSObject {
    
    private var movieService:MovieService!
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
    var bindMoviesToTableView: (() -> ()) = {}
    
    
    override init() {
        super.init()
        movieService = MovieService()
        getMovieCatalog()
    }
    
    func getMovieCatalog() {
        self.movieService.fetchMovieCatalog(page: 10) { (movies) in
            self.results = movies.results
        }
    }
}
