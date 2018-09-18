//
//  MovieModel.swift
//  MoviesApi
//
//  Created by André Brilho on 09/09/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import Foundation

class MovieModel: Decodable {
    
    var vote_count : Int?
    var id : Int?
    var video : Bool?
    var vote_average : Float?
    var title : String?
    var popularity : Float?
    var poster_path : String?
    var original_language : String?
    var original_title : String?
    var genre_ids : [Int]?
    var backdrop_path : String?
    var adult : Bool?
    var overview : String?
    var release_date : String?
    
}
