//
//  MovieDB.swift
//  Moviez
//
//  Created by Punit Vaigankar on 10/03/21.
//

import RealmSwift

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

class GenreDB: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    static func create(id:Int, name:String) -> GenreDB {
        let genre = GenreDB()
        genre.id = id
        genre.name = name
        return genre
    }
}

class SpokenLanguageDB: Object {
    @objc dynamic var englishName = ""
    @objc dynamic var iso639_1 = ""
    @objc dynamic var name = ""

    static func create(englishName:String, iso639_1:String, name:String) -> SpokenLanguageDB{
        let spokenLanguages = SpokenLanguageDB()
        spokenLanguages.englishName = englishName
        spokenLanguages.iso639_1 = iso639_1
        spokenLanguages.name = name
        return spokenLanguages
    }
}
