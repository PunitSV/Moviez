//
//  GenericTableViewDelegate.swift
//  Moviez
//
//  Created by Punit Vaigankar on 10/03/21.
//

import Foundation
import UIKit

class GenericTableViewDelegate: NSObject, UITableViewDelegate {
    
    private var activityIndicatorHeader : UIActivityIndicatorView
    private var activityIndicatorFooter : UIActivityIndicatorView
    private var isScrollingUp:Bool!
    private var loadPagedItems:(Bool) -> ()
    
    init(loadPagedItems:@escaping (Bool) -> ()) {
        self.loadPagedItems = loadPagedItems
        activityIndicatorHeader = UIActivityIndicatorView(style: .gray)
        activityIndicatorHeader.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(44), height: CGFloat(44))
        
        activityIndicatorFooter = UIActivityIndicatorView(style: .gray)
        activityIndicatorFooter.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(44), height: CGFloat(44))
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
  
        if (scrollView.contentOffset.y < 0) {
            self.isScrollingUp = false
            print("Top scroll")
            loadPagedItems(true)
        } else if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            self.isScrollingUp = true
            loadPagedItems(false)
            print("down scroll")
        } else {
            self.isScrollingUp = nil
        }
    }
    
    func showHeaderView(forTableView tableView:UITableView) {
        tableView.tableHeaderView = activityIndicatorHeader
        activityIndicatorHeader.startAnimating()
    }
    
    func showFooterView(forTableView tableView:UITableView) {
        tableView.tableFooterView = activityIndicatorFooter
        activityIndicatorFooter.startAnimating()
    }
    
    func hideHeaderView() {
        self.activityIndicatorHeader.stopAnimating()
        self.activityIndicatorHeader.removeFromSuperview()
    }
    
    func hideFooterView() {
        self.activityIndicatorFooter.stopAnimating()
        self.activityIndicatorFooter.removeFromSuperview()
    }
}
