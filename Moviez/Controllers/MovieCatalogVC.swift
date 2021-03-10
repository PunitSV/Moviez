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
    private var delegate: GenericTableViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    private func bindViewModel() {
        self.movieCatalogViewModel = MovieCatalogViewModel()
        self.movieCatalogViewModel.showToast = {
            self.showToast(toastWith: self.movieCatalogViewModel.toastMessage)
        }
        self.movieCatalogViewModel.bindMoviesToTableView = {
            self.updateMovieCatalog()
        }
        
    }
    
    private func updateMovieCatalog() {
        self.dataSource = GenericTableViewDataSource(cellIdentifier: "movie_catalog", items: self.movieCatalogViewModel.results, configureCell: { cell, movie, index in
            cell.configureCell(title: movie.title, imageUrl: movie.posterPath, index: index)
        })
        self.delegate = GenericTableViewDelegate(loadPagedItems: { isScrollUp in
            if(isScrollUp) {
                self.movieCatalogViewModel.fetchPreviousMovies()
            } else {
                self.movieCatalogViewModel.fetchNextMovies()
            }
        })
        DispatchQueue.main.async {
            self.movieCatalogTV.dataSource = self.dataSource
            self.movieCatalogTV.delegate = self.delegate
            self.delegate.hideHeaderView()
            self.delegate.hideFooterView()
            self.movieCatalogTV.reloadData()
        }
    }
    
    private func showToast(toastWith message : String, font: UIFont = UIFont.systemFont(ofSize: 15) ,backgroundColor: UIColor = .black,textColor: UIColor = .white, duration: TimeInterval = 5.0) {
        
        let yPostition = self.view.frame.size.height - 84

        let frame = CGRect(x: 30, y: yPostition, width: self.view.frame.size.width - 60, height: 44)

        let toast = UILabel(frame: frame)
        toast.backgroundColor = backgroundColor.withAlphaComponent(0.8)
        toast.textColor = textColor
        toast.textAlignment = .center;
        toast.font = font
        toast.text = message
        toast.alpha = 1.0
        toast.layer.cornerRadius = 10;
        toast.clipsToBounds  =  true
        self.view.addSubview(toast)

        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseInOut, animations: {
            toast.alpha = 0.0
        }, completion: {(isCompleted) in
            toast.removeFromSuperview()
        })
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

