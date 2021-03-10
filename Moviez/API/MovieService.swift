//
//  MovieService.swift
//  Moviez
//
//  Created by Punit Vaigankar on 08/03/21.
//

import Foundation
import Alamofire

class MovieService {
    
    private let apiKey = "d2909395fe406b033a23483c4adba65b"
    public static let imageBaseUrl_w200 = "https://image.tmdb.org/t/p/w200"
    public static let imageBaseUrl_w400 = "https://image.tmdb.org/t/p/w400"
    public static let videoBaseUrl = "https://www.youtube.com/embed/64-iSYVmMVY?playsinline=1"
    private let apiBaseUrl = "https://api.themoviedb.org/3/movie/"
    private let popularMoviesEndpoint = "popular"
    private let movieVideosInfoEndpoint = "videos"
    
    func fetchMovieCatalog(page: Int,completion : @escaping (Movies) -> ()) {
        let url = apiBaseUrl + popularMoviesEndpoint
        let parameters:[String:Any] = ["api_key": apiKey, "page": page]
        let request = AF.request(url,method: .get, parameters: parameters)
        request.responseDecodable(of: Movies.self) { (response) in
            guard let movies = response.value else {
                print(response.error ?? "Unknown error")
                return
            }

            print(movies.results)
            completion(movies)
        }
        
    }
    
    func fetchMovieDetails(movieId:Int, completion : @escaping (Movie) -> ()) {
        let url = "\(apiBaseUrl)\(movieId)"
        let parameters:[String:Any] = ["api_key": apiKey]
        let request = AF.request(url,method: .get, parameters: parameters)
        request.responseDecodable(of: Movie.self) { (response) in
            guard let movie = response.value else {
                print(response.error ?? "Unknown error")
                return
            }

            print(movie)
            completion(movie)
        }
    }
    
    func fetchMovieVideoDetails(movieId:Int, completion : @escaping (MovieVideoInfo) -> ()) {
        let url = "\(apiBaseUrl)\(movieId)/" + movieVideosInfoEndpoint
        let parameters:[String:Any] = ["api_key": apiKey]
        let request = AF.request(url,method: .get, parameters: parameters)
        request.responseDecodable(of: MovieVideoInfo.self) { (response) in
            guard let movieVideoInfo = response.value else {
                print(response.error ?? "Unknown error")
                return
            }

            print(movieVideoInfo)
            completion(movieVideoInfo)
        }
    }
}
