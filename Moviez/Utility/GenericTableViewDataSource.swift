//
//  GenericTableViewDataSource.swift
//  Moviez
//
//  Created by Punit Vaigankar on 09/03/21.
//

import Foundation
import UIKit

class GenericTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T, Int) -> () = {_,_,_ in }
    
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T, Int) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item, indexPath.row)
        return cell
    }
    
    func addItems(atTop:Bool, items : [T]) {
        if(atTop) {
            self.items.insert(contentsOf: items, at: 0)
        } else {
            self.items.append(contentsOf: items)
        }
        
    }
    
    func clearItems() {
        self.items.removeAll()
    }
    
    func getMovie(atIndex index:Int) -> T {
        self.items[index]
    }
    
}
