//
//  FactDetailLandscapeTableViewCell.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class FactDetailLandscapeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var factImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var factValue: FactModel? {
        didSet {
            populateData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    private func initialSetup() {
        self.factImageView.contentMode = .scaleAspectFill
    }
    
    //reset cell to initial state
    private func resetCell() {
        
        UIView.performWithoutAnimation {
            factImageView.image = #imageLiteral(resourceName: "ic_placeholder")
            factImageView.contentMode = .scaleAspectFill
        }
    }
    
    private func populateData() {
        guard let fact = factValue else { return }
        descriptionLabel?.text = fact.description
        if let image = fact.thumbNailImage {
            factImageView.image = image
            factImageView.contentMode = .scaleAspectFill
        } else {
            resetCell()
        }
    }
    
}
