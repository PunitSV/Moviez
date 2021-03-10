//
//  MovieVideoInfo.swift
//  Moviez
//
//  Created by Punit Vaigankar on 10/03/21.
//

import Foundation

// MARK: - MovieVideoInfo
struct MovieVideoInfo: Codable {
    let id: Int?
    let results: [VideoResult]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case results = "results"
    }
}

// MARK: - Result
struct VideoResult: Codable {
    let id, iso639_1, iso3166_1, key: String?
    let name, site: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
