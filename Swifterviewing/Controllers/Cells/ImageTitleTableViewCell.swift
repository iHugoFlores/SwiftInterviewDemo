//
//  ImageTitleTableViewCell.swift
//  Swifterviewing
//
//  Created by Hugo Flores Perez on 7/23/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class ImageTitleTableViewCell: UITableViewCell {
    
    let albumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 80).isActive = true
        image.heightAnchor.constraint(equalToConstant: 80).isActive = true
        image.image = UIImage(systemName: "pencil")
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Inside cell?"
        label.textColor = .black
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        let cardView = UIView()
        cardView.layer.cornerRadius = 6.0
        cardView.layer.masksToBounds = true
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.masksToBounds = false
        cardView.layer.shadowOffset = CGSize(width: 0.0 , height: 1.0)
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowRadius = 3.0
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
        cardView.backgroundColor = .white
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10))
        contentView.addSubview(albumImage)
        cardView.addSubview(titleLabel)

        //cardView.heightAnchor.constraint(greaterThanOrEqualTo: albumImage.heightAnchor, multiplier: 1).isActive = true
        //cardView.heightAnchor.constraint(greaterThanOrEqualTo: albumImage.heightAnchor, multiplier: 1, constant: 16).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        albumImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        albumImage.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
        //albumImage.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8).isActive = true
    }
    
    func setAlbumImage(url: String, with api: NetworkInterface) {
        api.getData(url: url) { [weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.albumImage.image = UIImage(data: data)
                }
            case .failure(let error):
                print("Error getting image", error)
            }
        }
    }
}

