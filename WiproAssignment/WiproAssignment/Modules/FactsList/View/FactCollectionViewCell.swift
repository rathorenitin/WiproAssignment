//
//  FactCollectionViewCell.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class FactCollectionViewCell: UICollectionViewCell {
    
    //MARK:- @IBOutlets
    @IBOutlet weak var bagroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var factImageView: UIImageView!
    
    //MARK:- Public Properties
    var factValue: FactModel? {
        didSet {
            populateData()
        }
    }
    
    //MARK:- View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
    
}

//MARK:- Extension for Private Methods
extension FactCollectionViewCell {
    
    private func initialSetup() {
        self.bagroundView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.factImageView.contentMode =  .scaleAspectFill
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
        titleLabel?.text = fact.title
        if let image = fact.thumbNailImage {
            factImageView.image = image
            factImageView.contentMode = .scaleAspectFill
        } else {
            resetCell()
        }
    }
}
