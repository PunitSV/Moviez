//
//  MovieDB.swift
//  Moviez
//
//  Created by Punit Vaigankar on 10/03/21.
//

import RealmSwift
/*!
 * @typedef MovieDB
 * @brief class used to store movie details data by Realm
 */
class MovieDB: Object {
    
    var genres = List<GenreDB>()
    @objc dynamic var id = 0
    @objc dynamic var overview = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var releaseDate = ""
    var spokenLanguages = List<SpokenLanguageDB>()
    @objc dynamic var title = ""
    @objc dynamic var runtime = 0
    @objc dynamic var voteAverage = 0.0
    
    /*!
     * @discussion creates object of MovieDB class and assigns the appropriate object properties
     * @param genres list of genres for the movie
     * @param id Unique id associated with the movie
     * @param overview Brief summary about the movie
     * @param posterPath Endpath for the movie poster
     * @param releaseDate The date when the movie was released
     * @param spokenLanguages languages of the movie
     * @param title Name odf the movie
     * @param runtime duration of the movie
     * @param voteAverage Average votes for the movie
     * @return MovieDB object assigned with it's properties
     */
    static func create(genres: [GenreDB], id: Int, overview: String, posterPath: String, releaseDate: String, spokenLanguages: [SpokenLanguageDB], title: String, runtime:Int, voteAverage: Double) -> MovieDB {
        let movie = MovieDB()
        movie.genres.append(objectsIn: genres)
        movie.id = id
        movie.overview = overview
        movie.posterPath = posterPath
        movie.releaseDate = releaseDate
        movie.spokenLanguages.append(objectsIn: spokenLanguages)
        movie.title = title
        movie.runtime = runtime
        movie.voteAverage = voteAverage
        return movie
    }
}

/*!
 * @typedef GenreDB
 * @brief class used to store genre for a movie by Realm
 */
class GenreDB: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    /*!
     * @discussion creates object of GenreDB class and assigns the appropriate object properties
     * @param id Unique id associated with the genre
     * @param name Name of the Genre
     * @return GenreDB object assigned with it's properties
     */
    static func create(id:Int, name:String) -> GenreDB {
        let genre = GenreDB()
        genre.id = id
        genre.name = name
        return genre
    }
}

/*!
 * @typedef SpokenLanguageDB
 * @brief class used to store languages for a movie by Realm
 */
class SpokenLanguageDB: Object {
    @objc dynamic var englishName = ""
    @objc dynamic var iso639_1 = ""
    @objc dynamic var name = ""

    /*!
     * @discussion creates object of SpokenLanguageDB class and assigns the appropriate object properties
     * @param englishName Name of language in English
     * @param iso639_1 Associated language code
     * @param name Name of the language
     * @return GenreDB object assigned with it's properties
     */
    static func create(englishName:String, iso639_1:String, name:String) -> SpokenLanguageDB{
        let spokenLanguages = SpokenLanguageDB()
        spokenLanguages.englishName = englishName
        spokenLanguages.iso639_1 = iso639_1
        spokenLanguages.name = name
        return spokenLanguages
    }
}
