//
//  MoviesDB.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import RealmSwift

class MoviesDB: Object {
    @objc dynamic var page = 0
    var results = List<ResultDB>()
    @objc dynamic var totalPages = 0
    @objc dynamic var totalResults = 0

    static func create(page: Int, results: [ResultDB], totalPages: Int, totalResults: Int) -> MoviesDB {
        let movie = MoviesDB()
        movie.page = page
        movie.results.append(objectsIn: results)
        movie.totalPages = totalPages
        movie.totalResults = totalResults
        return movie
    }

}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseResult { response in
//     if let result = response.result.value {
//       ...
//     }
//   }

// MARK: - Result
class ResultDB: Object {
    @objc dynamic var id = 0
    @objc dynamic var posterPath = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var title = ""
    @objc dynamic var voteAverage = 0.0

    static func create(id: Int, posterPath:String, releaseDate:String,title: String, voteAverage: Double) -> ResultDB {
        let result = ResultDB()
        result.id = id
        result.posterPath = posterPath
        result.releaseDate = releaseDate
        result.title = title
        result.voteAverage = voteAverage
        
        return result
    }
}
