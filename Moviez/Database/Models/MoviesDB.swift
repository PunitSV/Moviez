//
//  MoviesDB.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import RealmSwift
/*!
 * @typedef MoviesDB
 * @brief class used to store movie data by Realm
 */
class MoviesDB: Object {
    @objc dynamic var page = 0
    var results = List<ResultDB>()
    @objc dynamic var totalPages = 0
    @objc dynamic var totalResults = 0

    /*!
     * @discussion creates object of MoviesDB class and assigns the appropriate object properties
     * @param page associated page number
     * @param results results for the page number
     * @param totalPages total number of pages available
     * @param totalResults total results available
     * @return MovieDB object assigned with it's properties
     */
    static func create(page: Int, results: [ResultDB], totalPages: Int, totalResults: Int) -> MoviesDB {
        let movie = MoviesDB()
        movie.page = page
        movie.results.append(objectsIn: results)
        movie.totalPages = totalPages
        movie.totalResults = totalResults
        return movie
    }

}

// MARK: - Result
/*!
 * @typedef ResultDB
 * @brief class used to store movie results for a particular page by Realm
 */
class ResultDB: Object {
    @objc dynamic var id = 0
    @objc dynamic var posterPath = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var title = ""
    @objc dynamic var originalLanguage = ""
    @objc dynamic var voteAverage = 0.0

    /*!
     * @discussion creates object of ResultDB class and assigns the appropriate object properties
     * @param id id associated with the movie
     * @param posterPath endpath for the movie poster
     * @param releaseDate The date when the movie was released
     * @param title Title of the movie
     * @param language language of the movie
     * @param voteAverage Average votes for the movie
     * @return ResultDB object assigned with it's properties
     */
    static func create(id: Int, posterPath:String, releaseDate:String,title: String, language: String, voteAverage: Double) -> ResultDB {
        let result = ResultDB()
        result.id = id
        result.posterPath = posterPath
        result.releaseDate = releaseDate
        result.title = title
        result.originalLanguage = language
        result.voteAverage = voteAverage
        
        return result
    }
}
