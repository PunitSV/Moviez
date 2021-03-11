//
//  DataBaseHelper.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//
import RealmSwift
/*!
 * @typedef DataBaseHelper
 * @brief Helper class to perform various database operations
 */
class DataBaseHelper {
    
    /*!
     * @brief Object of Realm database to perform various database operations
     */
    private let realm = try! Realm()
    
    /*!
     * @discussion Inserts paged movie data into database
     * @param movies Object of Movies having movies to be inserted in database
     */
    func addMoviesCatalogToDB(movies:Movies) {
        
        var results:[ResultDB] = []
        
        realm.beginWrite()
        for result in movies.results! {
            let resultDB = ResultDB.create(id: result.id!, posterPath: result.posterPath ?? "", releaseDate: result.releaseDate ?? "N/A", title: result.title!, language: result.originalLanguage ?? "", voteAverage: result.voteAverage!)
            realm.add(resultDB)
            results.append(resultDB)
        }
        
        let movies = MoviesDB.create(page: movies.page!, results: results, totalPages: movies.totalPages!, totalResults: movies.totalResults!)
        realm.add(movies)
        
        try! realm.commitWrite()
    }
    
    /*!
     * @discussion Reads movies data from database for a particular page
     * @param page page number whose data needs to be read
     * @param completion closure to pass movies fetched from database
     */
    func getMovieCatalog(page:Int,completion : @escaping (Movies) -> ()) {
        
        guard let moviesDB = realm.objects(MoviesDB.self).filter("page = %@", page).first else {
            return
        }
        #if DEBUG
        print(moviesDB)
        #endif
        
        var movies:Movies
        
        var results:[Result] = []
        for result in moviesDB.results {
            results.append(Result(adult: false, backdropPath: "", genreIDS: [], id: result.id, originalLanguage: result.originalLanguage, originalTitle: "", overview: "", popularity: 0.0, posterPath: result.posterPath, releaseDate: result.releaseDate, title: result.title, video: false, voteAverage: result.voteAverage, voteCount: 0))
        }
        
        movies = Movies(page: moviesDB.page, results: results, totalPages: moviesDB.totalPages, totalResults: moviesDB.totalResults)
        completion(movies)
        
    }
    
    /*!
     * @discussion Deletes the movies associated with the passed page number
     * @param page page number whose data needs to be deleted
     */
    func emptyMovieCatalog(forPage page:Int) {
        let moviesForPage = realm.objects(MoviesDB.self).filter("page = %@", page)
        #if DEBUG
        print(moviesForPage)
        #endif
        
        try! realm.write {
            realm.delete(moviesForPage)
        }
        
    }
    
    /*!
     * @discussion Inserts movie details into database
     * @param movie Object of Movie having details related to the movie
     */
    func addMovieDetailsToDB(movie:Movie) {
        
        var genres:[GenreDB] = []
        var spokenLanguages:[SpokenLanguageDB] = []
        realm.beginWrite()
        
        for genre in movie.genres! {
            let genreDB = GenreDB.create(id: genre.id!, name: genre.name!)
            realm.add(genreDB)
            genres.append(genreDB)
        }
        
        for spokenLanguage in movie.spokenLanguages! {
            let spokenLanguagesDB = SpokenLanguageDB.create(englishName: spokenLanguage.englishName!, iso639_1: spokenLanguage.iso639_1!, name: spokenLanguage.name!)
            realm.add(spokenLanguagesDB)
            spokenLanguages.append(spokenLanguagesDB)
        }
        let movieDB = MovieDB.create(genres: genres, id: movie.id!, overview: movie.overview!, posterPath: movie.posterPath!, releaseDate: movie.releaseDate!, spokenLanguages: spokenLanguages, title: movie.title!, runtime: movie.runtime ?? 0, voteAverage: movie.voteAverage!)
        
        realm.add(movieDB)
        try! realm.commitWrite()
    }
    
    /*!
     * @discussion Reads movie details from database for a movie
     * @param movieId Id associated with movie whose details needs to be read
     * @param completion closure to pass movie details fetched from database
     */
    func getMovieDetails(movieId:Int, completion : @escaping (Movie) -> ()) {
        
        guard let moviesDB = realm.objects(MovieDB.self).filter("id = %@", movieId).first else {
            return
        }
        #if DEBUG
        print(moviesDB)
        #endif
        
        var genres:[Genre] = []
        var spokenLanguages:[SpokenLanguage] = []
        
        for genre in moviesDB.genres {
            genres.append(Genre(id: genre.id, name: genre.name))
        }
        
        for spokenLanguage in moviesDB.spokenLanguages {
            spokenLanguages.append(SpokenLanguage(englishName: spokenLanguage.englishName, iso639_1: spokenLanguage.iso639_1, name: spokenLanguage.name))
        }
        
        let movie = Movie(adult: false, backdropPath: "", belongsToCollection: nil, budget: 0, genres: genres, homepage: "", id: moviesDB.id, imdbID: "", originalLanguage: "", originalTitle: "", overview: moviesDB.overview, popularity: 0.0, posterPath: moviesDB.posterPath, productionCompanies: nil, productionCountries: nil, releaseDate: moviesDB.releaseDate, revenue: 0, runtime: moviesDB.runtime, spokenLanguages: spokenLanguages, status: "", tagline: "", title: moviesDB.title, video: false, voteAverage: moviesDB.voteAverage, voteCount: 0)
     
        completion(movie)
    }
    
    /*!
     * @discussion Deletes the movie details from database
     * @param movieId Movie Id whose data needs to be deleted
     */
    func emptyMovieDetails(withMovieId movieId:Int) {
        let moviesDetails = realm.objects(MovieDB.self).filter("id = %@", movieId)
        #if DEBUG
        print(moviesDetails)
        #endif
        
        try! realm.write {
            realm.delete(moviesDetails)
        }
        
    }
    
    /*!
     * @discussion Searches for Movies whose name contains the passed character sequence
     * @param sequence character sequence to be searched in movie name
     * @param completion closure to pass movies fetched from database
     */
    func search(forSequence sequence:String, completion : @escaping ([Result]) -> ()) {
    
        var results:[Result] = []
        let resultDB = realm.objects(ResultDB.self).filter("title CONTAINS %@", sequence).distinct(by: ["id"])
        
        for result in resultDB {
            results.append(Result(adult: false, backdropPath: "", genreIDS: [], id: result.id, originalLanguage: "", originalTitle: "", overview: "", popularity: 0.0, posterPath: result.posterPath, releaseDate: result.releaseDate, title: result.title, video: false, voteAverage: result.voteAverage, voteCount: 0))
        }
        completion(results)
    }
}
