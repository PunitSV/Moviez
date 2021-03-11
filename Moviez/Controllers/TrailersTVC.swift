//
//  TrailerTVC.swift
//  Moviez
//
//  Created by Punit Vaigankar on 11/03/21.
//

import UIKit
import WebKit

class TrailersTVC: UITableViewController {

    public var trailerViewModel:TrailerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Trailer"
        self.trailerViewModel.bindTrailerList = {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.trailerViewModel.movieVideoInfo.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trailer_item", for: indexPath)
        if let trailerCell = cell as? TrailerTVC {
            trailerCell.configureCell(trailerName: self.trailerViewModel.movieVideoInfo[indexPath.row].name ?? "Unknown")
        }
        return cell
    }

    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var webview: WKWebView?
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.allowsInlineMediaPlayback = true
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - (self.navigationController?.navigationBar.frame.height ?? 0))
        
        webview = WKWebView(frame: frame, configuration: webViewConfig)
        let url = MovieService.videoBaseUrl + (self.trailerViewModel.movieVideoInfo[indexPath.row].key ?? "") + "?playsinline=0&rel=0"
        let myURL = URL(string: url)
        let youTubeRequest = URLRequest(url: myURL!)

        webview?.load(youTubeRequest)

        guard let webView = webview else { return }
        self.view.addSubview(webView)
    }
    
}
