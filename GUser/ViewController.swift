//
//  ViewController.swift
//  GUser
//
//  Created by Wei Kuo on 2020/2/21.
//  Copyright © 2020 Wei Kuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!

    let viewModel = ViewControllerModel(userDataSize: 100, loadSize: 20)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.onLoading = onLoading(isFinish:)
        viewModel.onNewData = onNewData
    }
    
    func onLoading(isFinish:Bool) {
        
    }
    
    func onNewData() {
        
    }


}

