//
//  Connectivity.swift
//  Moviez
//
//  Created by Punit Vaigankar on 10/03/21.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
