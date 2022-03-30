//
//  DessertsTableViewCell.swift
//  mealsy
//
//  Created by Frank Aceves on 3/30/22.
//

import UIKit
class DessertsTableViewCell: UITableViewCell {
    @IBOutlet var dessertImageView: UIImageView!
    @IBOutlet var dessertNameLabel: UILabel!
    
    func configureCell(name: String?, imageUrlString: String?) {
        dessertImageView.image = UIImage(systemName: "pencil")
        
        dessertNameLabel.text = name
        
        
        dessertImageView.layer.cornerRadius = 8
        //call imageDownloader
        guard let imageURLString = imageUrlString else {
            dessertImageView.image = UIImage(systemName: "xmark.circle.fill")
            return
        }
        getImage(url: imageURLString) { [unowned self] success, image in
            guard success else {
                return
            }
            guard let image = image else {
                DispatchQueue.main.async {
                    self.dessertImageView.image = UIImage(systemName: "xmark.circle.fill")
                }
                return
            }
            DispatchQueue.main.async {
                self.dessertImageView.image = image
            }
        }
    }
    
    func getImage(url: String, completion: @escaping (Bool, UIImage?) -> Void) {
        ImageDownloader().downloadImage(from: url) { success, data in
            guard success else {
                completion(false, nil)
                return
            }
            guard let data = data else {
                completion(false, nil)
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            completion(true, image)
        }
    }
}

class DessertsCellViewModel {
    var dessertImageURLString: String
    var dessertName: String
    
    init(name: String, urlString: String) {
        self.dessertName = name
        self.dessertImageURLString = urlString
    }
}
