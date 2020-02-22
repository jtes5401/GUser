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
    
}
