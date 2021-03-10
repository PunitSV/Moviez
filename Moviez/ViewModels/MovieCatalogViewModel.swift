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
    private(set) var toastMessage:String! {
        didSet {
            self.showToast()
        }
    }
    private var currentPage:Int!
    private var totalPages:Int!
    var bindMoviesToTableView: (() -> ())! {
        didSet {
            fetchNextMovies()
        }
    }
    
    var showToast: (() -> ()) = {}
    
    override init() {
        super.init()
        currentPage = 12
        totalPages = currentPage + 1
        results = []
        movieService = MovieService()
        databaseHelper = DataBaseHelper()
    }
    
    func getMovieCatalog(insert atStart:Bool) {
        if(Connectivity.isConnectedToInternet()) {
            self.movieService.fetchMovieCatalog(page: currentPage) { (movies) in
                if(atStart) {
                    self.results.insert(contentsOf: movies.results!, at: 0)
                } else {
                    self.results.append(contentsOf: movies.results!)
                }
                self.totalPages = movies.totalPages
                self.databaseHelper.emptyMovieCatalog(forPage: self.currentPage)
                self.databaseHelper.addMoviesCatalogToDB(movies: movies)
            }
        } else {
            self.databaseHelper.getMovieCatalog(page: currentPage) { (movies) in
                if(atStart) {
                    self.results.insert(contentsOf: movies.results!, at: 0)
                } else {
                    self.results.append(contentsOf: movies.results!)
                }
                self.totalPages = movies.totalPages
            }
        }
    }
    
    func fetchNextMovies() {
        currentPage+=1
        #if DEBUG
        print("Current Page: \(currentPage!)")
        #endif
        if(currentPage > totalPages) {
            currentPage-=1
            self.toastMessage = "That's it!!! No more movies available"
        } else {
            getMovieCatalog(insert: false)
        }
    }
    
    func fetchPreviousMovies() {
        currentPage-=1
        #if DEBUG
        print("Current Page: \(currentPage!)")
        #endif
        if(currentPage < 1) {
            currentPage+=1
            self.toastMessage = "No previous movies available"
        } else {
            getMovieCatalog(insert: true)
        }
    }
}
