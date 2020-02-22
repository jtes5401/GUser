//
//  GHConnecter.swift
//  GUser
//
//  Created by Wei Kuo on 2020/2/21.
//  Copyright © 2020 Wei Kuo. All rights reserved.
//

import UIKit

class GHConnecter: NSObject {
    let host = "https://api.github.com"
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    public func requestUsers(since: Int, size: Int = 20, callBack:@escaping (_ users:[GHUser]?, _ result:Bool)->()) {
        let s = size == 0 ? 20 : size
        let path = host + "/users?since=\(since)&per_page=\(s)"
        
        guard let url = URL(string: path) else {
            callBack(nil,false)
            return
        }
        let request = URLRequest(url:url)
        self.sendRequest(request: request, type: [GHUser].self, callBack: callBack)
    }
    
    private func sendRequest<T:Decodable>(request: URLRequest, type: T.Type,callBack:@escaping ((T?, Bool)->Void)) {
        session.dataTask(with: request) { (data, response, err) in
            if let _ = err {
                callBack(nil,false)
                return
            }
            guard let d = data else {
                callBack(nil,false)
                return
            }
            
            do{
                let obj = try self.decoder.decode(type, from: d)
                callBack(obj,true)
                return
            }catch {
                print(error)
                callBack(nil,false)
            }
        }.resume()
    }
}
