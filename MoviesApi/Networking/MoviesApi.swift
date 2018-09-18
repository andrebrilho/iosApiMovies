//
//  MoviesApi.swift
//  MoviesApi
//
//  Created by André Brilho on 09/09/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import Foundation

class MoviesApi {
    
    static func fetchMovies(NumberPage:Int, sucess: @escaping ([MovieModel]) -> Void, failure: @escaping (Error) -> Void) {
        
        if let url = URL(string: Constants.baseURL + Constants.moviePath + Constants.apiKey + "&page=" + String(NumberPage)){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request, completionHandler : { (data, response, error) in
                if let erro = error {
                    DispatchQueue.main.async {
                        failure(erro)
                    }
                }else{
                    if let data = data {
                        do {
                            let movieReponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                            DispatchQueue.main.async {
                                sucess(movieReponse.results!)
                            }
                        }catch {
                            DispatchQueue.main.async {
                                failure(error)
                            }
                        }
                    }
                }
            }).resume()
        }else{
            print("error url")
        }
    }
    
}
