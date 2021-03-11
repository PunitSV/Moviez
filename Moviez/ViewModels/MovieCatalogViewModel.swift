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
    var hadScrolledUp:Bool!
    private(set) var results:[Result]! {
        didSet {
            self.bindMoviesToTableView()
        }
    }
    var isLoading:Bool! {
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
    private var minimumPageFetched:Int!
    private var maximumPageFetched:Int!
    private var totalPages:Int!
    var bindMoviesToTableView: (() -> ())! {
        didSet {
            fetchNextMovies()
        }
    }
    
    var showToast: (() -> ()) = {}
    
    override init() {
        super.init()
        results = []
        resetCounters()
        movieService = MovieService()
        databaseHelper = DataBaseHelper()
    }
    
    func resetCounters() {
        minimumPageFetched = 12
        maximumPageFetched = 12
        totalPages = minimumPageFetched + 1
        
    }
    
    func getMovieCatalog() {
        if(Connectivity.isConnectedToInternet()) {
            self.movieService.fetchMovieCatalog(page: minimumPageFetched) { (movies) in
                self.results = movies.results!
                self.totalPages = movies.totalPages
                self.databaseHelper.emptyMovieCatalog(forPage: self.minimumPageFetched)
                self.databaseHelper.addMoviesCatalogToDB(movies: movies)
            }
            
        } else {
            self.databaseHelper.getMovieCatalog(page: minimumPageFetched) { (movies) in
                self.results = movies.results!
                self.totalPages = movies.totalPages
            }

        }
    }
    
    func fetchNextMovies() {
        maximumPageFetched+=1
        #if DEBUG
        print("Current Page: \(maximumPageFetched!)")
        #endif
        if(maximumPageFetched > totalPages) {
            maximumPageFetched-=1
            self.toastMessage = "That's it!!! No more movies available"
        } else {
            self.hadScrolledUp = false
            getMovieCatalog()
        }
    }
    
    func fetchPreviousMovies() {
        minimumPageFetched-=1
        #if DEBUG
        print("Current Page: \(minimumPageFetched!)")
        #endif
        if(minimumPageFetched < 1) {
            minimumPageFetched+=1
            self.toastMessage = "No previous movies available"
        } else {
            self.hadScrolledUp = true
            getMovieCatalog()
        }
    }
    
    func search(withsequence sequence:String) {
        self.databaseHelper.search(forSequence: sequence) { (results) in
            self.results = results
        }
    }
}
