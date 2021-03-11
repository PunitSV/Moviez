//
//  MovieCatalogViewModel.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import Foundation

/*!
 * @typedef MovieCatalogViewModel
 * @brief ViewModel class for MovieCatalog
 */
class MovieCatalogViewModel: NSObject {
    
    /*!
     * @brief API class to make API calls
     */
    private var movieService:MovieService!
    /*!
     * @brief Database class to make datbase related operations
     */
    private var databaseHelper:DataBaseHelper!
    /*!
     * @brief To detect tableview scrolldirection to add movies at top or bottom
     */
    var hadScrolledUp:Bool!
    /*!
     * @brief Movies to be binded to the list
     */
    private(set) var results:[Result]! {
        didSet {
            self.bindMoviesToTableView()
        }
    }
    /*!
     * @brief To indicate network activity
     */
    var isLoading:Bool! {
        didSet {
            if(isLoading) {
                
            } else {
                
            }
        }
    }
    /*!
     * @brief To show toast message in case of end or begining of the list
     */
    private(set) var toastMessage:String! {
        didSet {
            self.showToast()
        }
    }
    /*!
     * @brief minimum page fetched from API call
     */
    private var minimumPageFetched:Int!
    /*!
     * @brief maximum page fetched from API call
     */
    private var maximumPageFetched:Int!
    /*!
     * @brief total number of pages available to fetch from API
     */
    private var totalPages:Int!
    /*!
     * @brief closure to binds movies to the tableview
     */
    var bindMoviesToTableView: (() -> ())! {
        didSet {
            fetchNextMovies()
        }
    }
    /*!
     * @brief closure to show toast message
     */
    var showToast: (() -> ()) = {}
    
    override init() {
        super.init()
        results = []
        resetCounters()
        movieService = MovieService()
        databaseHelper = DataBaseHelper()
    }
    
    /*!
     * @brief resets to initial state
     */
    func resetCounters() {
        minimumPageFetched = 12
        maximumPageFetched = 12
        totalPages = minimumPageFetched + 1
        
    }
    
    /*!
     * @brief Fetches movie catalog data from API
     */
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
    
    /*!
     * @brief Calculates next page number to be fetched from API and setsup toast message incase of last page
     */
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
    
    /*!
     * @brief Calculates previous page number to be fetched from API and setsup toast message in case of first page
     */
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
    
    /*!
     * @brief Calls search function on database
     */
    func search(withsequence sequence:String) {
        self.databaseHelper.search(forSequence: sequence) { (results) in
            self.results = results
        }
    }
}
