//
//  ViewController.swift
//  MoviesApi
//
//  Created by André Brilho on 09/09/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    var numberPage:Int = 1
    var movies:[MovieModel] = []
    var isError:Bool = false
    var loadingCell:LoadingCollectionViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMovies.dataSource = self
        collectionMovies.delegate = self
        registerCells()
        getMovies(page: numberPage)
    }
    
    func getMovies(page:Int){
        MoviesApi.fetchMovies(NumberPage: page, sucess: { (movies) in
            self.isError = false
            self.movies.append(contentsOf: movies)
            self.collectionMovies.reloadData()
        }) { (error) in
            self.isError = true
            self.collectionMovies.reloadData()
            print(error)
        }
    }
    
    func registerCells(){
        collectionMovies.register(UINib(nibName: "ItemMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemMovieCell")
        collectionMovies.register(UINib(nibName: "LoadingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadingCell")
        collectionMovies.register(UINib(nibName: "ErrorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ErrorCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isError || movies.count == 0 {
            return 1
        }
        return movies.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isError || indexPath.row == movies.count {
            return CGSize(width: collectionView.frame.width, height: 45)
        }
        return CGSize(width: 156, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isError || movies.count == 0, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ErrorCell", for: indexPath) as? ErrorCollectionViewCell {
            return cell
        }
        if indexPath.row == movies.count, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath) as? LoadingCollectionViewCell {
            loadingCell = cell
            cell.actIndicator.startAnimating()
            print("cell com loading")
            return cell
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemMovieCell", for: indexPath) as? ItemMovieCollectionViewCell {
            cell.movie = movies[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !isError && movies.count > 0, let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController {
            detailVC.movie = movies[indexPath.row]
            present(detailVC, animated: true)
        }else{
            print("erro")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if !isError && movies.count > 0 {
            if indexPath.row == movies.count - 4 {
                numberPage += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.getMovies(page: self.numberPage)
                }
            }
        }
    }
}

