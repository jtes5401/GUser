//
//  ViewControllerModel.swift
//  GUser
//
//  Created by Wei Kuo on 2020/2/22.
//  Copyright © 2020 Wei Kuo. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerModel {
    public var userData = [GHUser]()
    
    public var userPicDic = [Int:UIImage]()
    public var onLoading:((_ isFinish:Bool) -> Void)?
    public var onNewData:(()->Void)?
    
    private var userDataSize = 20
    private var loadSize = 20

    private var updateFlag = DispatchSemaphore(value: 1)
    
    init(userDataSize:Int, loadSize:Int) {
        self.userDataSize = userDataSize
        self.loadSize = loadSize
    }
    
    public func getMoreData() {
        updateFlag.wait()
        if userData.count >= userDataSize {
            updateFlag.signal()
            return
        }
        self.onLoading?(false)
        
        var beginId = 0
        
        if let lastUser = userData.last {
            beginId = lastUser.id
        }
        
        let conn = GHConnecter()
        conn.requestUsers(since: beginId, size: loadSize) { [unowned self] (users, result)  in
            if result,let us = users {
                self.userData.append(contentsOf: us)
                self.sortingUserData()
                self.getUserPic()
                self.onNewData?()
            }
            self.onLoading?(true)
            self.updateFlag.signal()
        }
    }
    
    public func getUserPic() {
        let session = URLSession(configuration: .default)
        let flag = DispatchSemaphore(value: 0)
        for user in userData where userPicDic[user.id] == nil {
            session.dataTask(with: user.picURL) {[unowned self] (data, resp, err) in
                if let e = err {
                    print("getUserPic:", e)
                    return
                }
                if let d = data,let im = UIImage(data: d) {
                    self.userPicDic[user.id] = im
                }
                flag.signal()
            }.resume()
            flag.wait()
        }
    }
    
    private func sortingUserData() {
        userData.sort { (u1, u2) -> Bool in
            return u1.id < u2.id
        }
    }
}
