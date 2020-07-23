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
        image.widthAnchor.constraint(equalToConstant: 56).isActive = true
        image.heightAnchor.constraint(equalToConstant: 56).isActive = true
        image.image = UIImage(systemName: "pencil")
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Inside cell?"
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10))
        contentView.addSubview(albumImage)
        contentView.addSubview(titleLabel)

        contentView.heightAnchor.constraint(greaterThanOrEqualTo: albumImage.heightAnchor, multiplier: 1).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        albumImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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

