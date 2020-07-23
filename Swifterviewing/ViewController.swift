//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let placeholderAPI = API()
    var albums:[Album] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        placeholderAPI.getAlbums { [weak self] (result) in
            switch result {
            case .success(let albums):
                DispatchQueue.main.async {
                    self?.albums = albums
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "6c570076-9d57-40f1-94d1-d6cd67ed23c6", for: indexPath) as? ImageTitleTableViewCell else { fatalError() }
        cell.titleLabel.text = albums[indexPath.row].titleWithNoE
        cell.setAlbumImage(url: albums[indexPath.row].thumbnailUrl, with: placeholderAPI)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
