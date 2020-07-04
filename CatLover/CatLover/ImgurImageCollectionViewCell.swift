//
//  ImgurImageCollectionViewCell.swift
//  CatLover
//
//  Created by Bruno Maciel on 7/3/20.
//  Copyright © 2020 Bruno Maciel. All rights reserved.
//

import UIKit

class ImgurImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgview_Cat: UIImageView!
    @IBOutlet weak var btn_showLarger: UIButton!
    
    var delegate: ImgurImageCellDelegate?
    var imageUrl: String?
    
    
    // Prepara interface da cell
    func prepareCell(with catImage: ImgurImage) {
        imgview_Cat.layer.cornerRadius = 20
        
        if let imgURL = URL(string: catImage.link) {
            imgview_Cat.kf.indicatorType = .activity    // loading icon antes de carregar a imagem
            imgview_Cat.kf.setImage(with: imgURL)
            btn_showLarger.isEnabled = true
            imageUrl = catImage.link
        } else {
            btn_showLarger.isEnabled = false
            imgview_Cat.image = nil
        }
    }
    
    @IBAction func showImageLarger(_ sender: UIButton) {
        print(imageUrl ?? "")
        delegate?.showLarger(imgview_Cat.image)
    }
    
}


protocol ImgurImageCellDelegate {
    func showLarger(_ image: UIImage?)
}
