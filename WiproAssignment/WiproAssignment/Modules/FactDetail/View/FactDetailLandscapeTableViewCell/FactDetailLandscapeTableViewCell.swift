//
//  FactDetailLandscapeTableViewCell.swift
//  WiproAssignment
//
//  Created by Apple on 22/12/19.
//  Copyright © 2019 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class FactDetailLandscapeTableViewCell: UITableViewCell {
    
    //MARK:- @IBOutlets

    
    //MARK:- Public Properties
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    let factImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var factValue: FactModel? {
        didSet {
            populateData()
        }
    }
    
    //MARK:- View Life Cycle
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }
    
}

//MARK:- Extension for Private Methods
extension FactDetailLandscapeTableViewCell {
    
    private func initialSetup() {
        setupCell()
    }
    
    private func setupCell() {
        
        // adding imageview
        self.contentView.addSubview(factImageView)
        factImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
//        factImageView.trailingAnchor.constraint(equalTo: self.descriptionLabel.leadingAnchor, constant: 10).isActive = true
        factImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        factImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true

        factImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        factImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true

        
        // adding title label
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: self.factImageView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10).isActive = true
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
        descriptionLabel.text = fact.description
        if let image = fact.thumbNailImage {
            factImageView.image = image
            factImageView.contentMode = .scaleAspectFill
        } else {
            resetCell()
        }
    }
}
