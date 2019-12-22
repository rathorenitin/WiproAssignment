//
//  FactDetailViewController+UITableView.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

// MARK: - TableView DataSource
extension FactDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if UIDevice.current.orientation.isPortrait {
            let cell = tableView.dequeueCell(with: FactDetailPortraitTableViewCell.self)
            cell.factValue = self.viewModel.FactDetails
            return cell
        } else {
           let cell = tableView.dequeueCell(with: FactDetailLandscapeTableViewCell.self)
            cell.factValue = self.viewModel.FactDetails
            return cell
        }
    }
    
    
    
}

// MARK: - TableView Delegate
extension FactDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

