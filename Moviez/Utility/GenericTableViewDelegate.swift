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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let isScrollUp = isScrollingUp else {
            return
        }
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if(isScrollUp) {
            //if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                tableView.tableFooterView = activityIndicatorFooter
            activityIndicatorFooter.startAnimating()
                loadPagedItems(false)
            //}
        } else {
           // if indexPath.section ==  0 && indexPath.row == 0 {
                tableView.tableHeaderView = activityIndicatorHeader
            activityIndicatorHeader.startAnimating()
                loadPagedItems(true)
            //}
        }
        
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        /*if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            self.isScrollingUp = true
        } else {
            self.isScrollingUp = false
        }*/
        if (scrollView.contentOffset.y < 0) {
            self.isScrollingUp = false
        } else if targetContentOffset.pointee.y < scrollView.contentOffset.y {
            self.isScrollingUp = true
        } else {
            self.isScrollingUp = nil
        }
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