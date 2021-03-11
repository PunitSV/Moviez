//
//  MovieService.swift
//  Moviez
//
//  Created by Punit Vaigankar on 08/03/21.
//

import Foundation
import Alamofire

/*!
 * @typedef MovieService
 * @brief This is API class to fetch movie data from TMDB API over a network
 */
class MovieService {
    
    /*!
     * @brief TMDB API key to make API calls
     */
    private let apiKey = "d2909395fe406b033a23483c4adba65b"
    /*!
     * @brief Image url for width 200
     */
    public static let imageBaseUrl_w200 = "https://image.tmdb.org/t/p/w200"
    /*!
     * @brief Image url for width 400
     */
    public static let imageBaseUrl_w400 = "https://image.tmdb.org/t/p/w400"
    /*!
     * @brief Base url to play youtube video
     */
    public static let videoBaseUrl = "https://www.youtube.com/embed/"
    /*!
     * @brief Base Url for the API calls
     */
    private let apiBaseUrl = "https://api.themoviedb.org/3/movie/"
    /*!
     * @brief Endpoint to fetch popular movies
     */
    private let popularMoviesEndpoint = "popular"
    /*!
     * @brief Endpoint to fetch movie trailers details
     */
    private let movieVideosInfoEndpoint = "videos"
    
    /*!
     * @discussion Makes a network call to fetch movie data for the associated page number and passes data to the caller
     * @param page page number to fetch movies from catalog
     * @param completion closure to pass fetched movies to the caller
     */
    func fetchMovieCatalog(page: Int,completion : @escaping (Movies) -> ()) {
        let url = apiBaseUrl + popularMoviesEndpoint
        let parameters:[String:Any] = ["api_key": apiKey, "page": page]
        let request = AF.request(url,method: .get, parameters: parameters)
        request.responseDecodable(of: Movies.self) { (response) in
            guard let movies = response.value else {
                print(response.error ?? "Unknown error")
                return
            }
            completion(movies)
        }
        
    }
    
    /*!
     * @discussion Makes a network call to fetch movie details for the associated movie ID and passes  details to the caller
     * @param movieId Id associated with movie to determine movie details to fetch
     * @param completion closure to pass fetched movie details to the caller
     */
    func fetchMovieDetails(movieId:Int, completion : @escaping (Movie) -> ()) {
        let url = "\(apiBaseUrl)\(movieId)"
        let parameters:[String:Any] = ["api_key": apiKey]
        let request = AF.request(url,method: .get, parameters: parameters)
        request.responseDecodable(of: Movie.self) { (response) in
            guard let movie = response.value else {
                print(response.error ?? "Unknown error")
                return
            }
            completion(movie)
        }
    }
    
    /*!
     * @discussion Makes a network call to fetch movie video details for the associated movie ID and passes  details to the caller
     * @param movieId Id associated with movie to determine movie video details to fetch
     * @param completion closure to pass fetched movie video details to the caller
     */
    func fetchMovieVideoDetails(movieId:Int, completion : @escaping (MovieVideoInfo) -> ()) {
        let url = "\(apiBaseUrl)\(movieId)/" + movieVideosInfoEndpoint
        let parameters:[String:Any] = ["api_key": apiKey]
        let request = AF.request(url,method: .get, parameters: parameters)
        request.responseDecodable(of: MovieVideoInfo.self) { (response) in
            guard let movieVideoInfo = response.value else {
                print(response.error ?? "Unknown error")
                return
            }
            completion(movieVideoInfo)
        }
    }
}
