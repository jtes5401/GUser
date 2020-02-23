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
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = viewModel.userData[indexPath.row]
        if let tCell = cell as? ViewCell {
            tCell.nameLabel.text = model.name
            tCell.starImageView.isHidden = !model.isAdmin
            tCell.picImageView.image = viewModel.userPicDic[model.id]
        }
        return cell
    }

}

