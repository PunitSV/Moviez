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
    @IBOutlet weak var modeBarButton: UIBarButtonItem!
    private var dataSource : GenericTableViewDataSource<MovieTVC,Result>!
    private var delegate: GenericTableViewDelegate!
    var searchTF:UITextField!
    var titleView:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    @IBAction func toggleMode(_ sender: UIBarButtonItem) {
        self.dataSource.clearItems()
        self.movieCatalogTV.reloadData()
        if(sender.tag == 1) {
            modeBarButton.image = UIImage(named: "search")
            sender.tag = 0
            if searchTF != nil {
                searchTF.removeFromSuperview()
            }
            titleView = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
            titleView.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            titleView.text = "Movie Catalog"
            titleView.textAlignment = .center
            self.navigationItem.titleView = titleView
            
            self.movieCatalogViewModel.resetCounters()
            self.movieCatalogViewModel.fetchNextMovies()
        } else {
            modeBarButton.image = UIImage(named: "view_all")
            sender.tag = 1
            
            if titleView != nil {
                titleView.removeFromSuperview()
            }
            
            searchTF = UITextField(frame: CGRect(x: self.view.frame.width/4, y: 5, width: (self.view.frame.width/2 + (self.view.frame.width/2 - self.view.frame.width/4)), height: 35))
            searchTF.borderStyle = .roundedRect
            searchTF.placeholder = "Search"
            searchTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            self.navigationItem.titleView = searchTF

        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.dataSource.clearItems()
        self.movieCatalogViewModel.search(withsequence: textField.text!)
    }
    
    private func bindViewModel() {
        
        self.movieCatalogViewModel = MovieCatalogViewModel()
        self.dataSource = GenericTableViewDataSource(cellIdentifier: "movie_catalog", items: self.movieCatalogViewModel.results, configureCell: { cell, movie, index in
            cell.configureCell(title: movie.title, imageUrl: movie.posterPath, index: index,language: movie.originalLanguage, averageVote:movie.voteAverage)
        })
        self.delegate = GenericTableViewDelegate(loadPagedItems: { isScrollUp in
            if(isScrollUp) {
                self.delegate.showHeaderView(forTableView: self.movieCatalogTV)
                self.movieCatalogViewModel.fetchPreviousMovies()
        
            } else {
                self.delegate.showFooterView(forTableView: self.movieCatalogTV)
                self.movieCatalogViewModel.fetchNextMovies()
            }
        })
        DispatchQueue.main.async {
            self.movieCatalogTV.dataSource = self.dataSource
            self.movieCatalogTV.delegate = self.delegate
        }
        
        self.movieCatalogViewModel.showToast = {
            self.movieCatalogTV.tableHeaderView = UIView(frame: CGRect.zero)
            self.movieCatalogTV.tableFooterView = UIView(frame: CGRect.zero)
            self.showToast(toastWith: self.movieCatalogViewModel.toastMessage)
        }
        self.movieCatalogViewModel.bindMoviesToTableView = {
            self.updateMovieCatalog()
        }
        
    }
    
    private func updateMovieCatalog() {
    
        self.dataSource.addItems(atTop: self.movieCatalogViewModel.hadScrolledUp, items: self.movieCatalogViewModel.results)
        DispatchQueue.main.async {
            self.movieCatalogTV.reloadData()
            self.movieCatalogTV.tableHeaderView = UIView(frame: CGRect.zero)
            self.movieCatalogTV.tableFooterView = UIView(frame: CGRect.zero)
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
                detailViewModel.movieId = self.dataSource.getMovie(atIndex: (sender as! UIButton).tag).id //movieCatalogViewModel.results[(sender as! UIButton).tag].id
                #if DEBUG
                print("\(self.dataSource.getMovie(atIndex: (sender as! UIButton).tag).id)")
                #endif
                movieDetailsController.movieDetailViewModel = detailViewModel
            }
        }
    }

}
