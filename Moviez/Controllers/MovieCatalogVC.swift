//
//  ViewController.swift
//  Moviez
//
//  Created by Punit Vaigankar on 08/03/21.
//

import UIKit

class MovieCatalogVC: UIViewController {

    private var movieCatalogViewModel:MovieCatalogViewModel!
    @IBOutlet weak var movieCatalogTV: UITableView!
    private var dataSource : GenericTableViewDataSource<MovieTVC,Result>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    private func bindViewModel() {
        self.movieCatalogViewModel = MovieCatalogViewModel()
        self.movieCatalogViewModel.bindMoviesToTableView = {
            self.updateMovieCatalog()
        }
    }
    
    private func updateMovieCatalog() {
        self.dataSource = GenericTableViewDataSource(cellIdentifier: "movie_catalog", items: self.movieCatalogViewModel.results, configureCell: { cell, movie, index in
            cell.configureCell(title: movie.title, imageUrl: movie.posterPath, index: index)
        })
                
        DispatchQueue.main.async {
            self.movieCatalogTV.dataSource = self.dataSource
            self.movieCatalogTV.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "details") {
            if let movieDetailsController = segue.destination as? MovieDetailsVC {
                let detailViewModel = MovieDetailsViewModel()
                detailViewModel.movieId = movieCatalogViewModel.results[(sender as! UIButton).tag].id
                #if DEBUG
                print("\(movieCatalogViewModel.results[(sender as! UIButton).tag].id!)")
                #endif
                movieDetailsController.movieDetailViewModel = detailViewModel
            }
        }
    }

}

