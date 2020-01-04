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
    
    //MARK:- Public Properties
    let bagroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
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
    override init(frame: CGRect) {
        super.init(frame: frame)
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
extension FactCollectionViewCell {
    
    private func initialSetup() {
        self.clipsToBounds = true
        setupCell()
    }
    
    private func setupCell() {
        // adding background view
        self.addSubview(bagroundView)
        bagroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bagroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bagroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bagroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // adding imageview
        self.bagroundView.addSubview(factImageView)
        factImageView.leadingAnchor.constraint(equalTo: self.bagroundView.leadingAnchor).isActive = true
        factImageView.trailingAnchor.constraint(equalTo: self.bagroundView.trailingAnchor).isActive = true
        factImageView.topAnchor.constraint(equalTo: self.bagroundView.topAnchor).isActive = true
        factImageView.bottomAnchor.constraint(equalTo: self.bagroundView.bottomAnchor, constant: -20).isActive = true
        
        // adding title label
        self.bagroundView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: self.bagroundView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.bagroundView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bagroundView.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
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
        titleLabel.text = fact.title
        if let image = fact.thumbNailImage {
            factImageView.image = image
            factImageView.contentMode = .scaleAspectFill
        } else {
            resetCell()
        }
    }
}
