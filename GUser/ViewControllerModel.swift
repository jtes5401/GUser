//
//  ViewControllerModel.swift
//  GUser
//
//  Created by Wei Kuo on 2020/2/22.
//  Copyright © 2020 Wei Kuo. All rights reserved.
//

import Foundation

class ViewControllerModel {
    public var userData = [GHUser]()
    
    public var onLoading:((_ isFinish:Bool) -> Void)?
    public var onNewData:(()->Void)?
    
    private var userDataSize = 20
    private var loadSize = 20

    init(userDataSize:Int, loadSize:Int) {
        self.userDataSize = userDataSize
        self.loadSize = loadSize
    }
    
    public func getMoreData() {
        self.onLoading?(false)

        if userData.count >= userDataSize {
            self.onLoading?(true)
            return
        }
        
        var beginId = 0
        
        if let lastUser = userData.last {
            beginId = lastUser.id
        }
        
        let conn = GHConnecter()
        conn.requestUsers(since: beginId, size: loadSize) { [unowned self] (users, result)  in
            self.onLoading?(true)
            if result,let us = users {
                self.userData.append(contentsOf: us)
                self.sortingUserData()
                self.onNewData?()
            }
        }
    }
    
    private func sortingUserData() {
        userData.sort { (u1, u2) -> Bool in
            return u1.id < u2.id
        }
    }
}
