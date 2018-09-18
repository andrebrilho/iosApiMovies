//
//  DetailViewController.swift
//  MoviesApi
//
//  Created by André Brilho on 09/09/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var lblInfo1: UILabel!
    @IBOutlet weak var lblInfo2: UILabel!
    @IBOutlet weak var lblInfo3: UILabel!
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    
    var movie:MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = movie.original_title
        txtDesc.text = movie.overview
        lblInfo1.text = "Popularidade: \(String(movie.popularity!))"
        lblInfo2.text = "Idioma: \(String(movie.original_language!))"
        lblInfo3.text = "Idioma: \(String(movie.release_date!))"
        imgMovie.image = nil
        imgMovie.af_cancelImageRequest()
        
        if let poster_path = movie.poster_path, let url = URL(string: Constants.baseImageUrl + "500" + poster_path) {
            actIndicator.startAnimating()
            imgMovie.af_setImage(withURL: url, imageTransition: .crossDissolve(0.2), completion: {(_) in
                self.actIndicator.stopAnimating()
            })
        }
    }
    
    @IBAction func btnVoltar(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}

