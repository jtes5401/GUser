//
//  ViewController.swift
//  GUser
//
//  Created by Wei Kuo on 2020/2/21.
//  Copyright © 2020 Wei Kuo. All rights reserved.
//

import UIKit
import JGProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!

    let viewModel = ViewControllerModel(userDataSize: 100, loadSize: 20)
    let progressView = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.onLoading = onLoading(isFinish:)
        viewModel.onNewData = onNewData
        
        progressView.textLabel.text = "Downloading"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMoreData()
    }
    
    func onLoading(isFinish:Bool) {
        DispatchQueue.main.async {
            if isFinish {
                self.progressView.dismiss(animated: true)
            }else{
                self.progressView.show(in: self.view)
            }
        }
    }
    
    func onNewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= viewModel.userData.count - 1 {
            print("willDisplay:", indexPath)
            viewModel.getMoreData()
        }
    }
}
