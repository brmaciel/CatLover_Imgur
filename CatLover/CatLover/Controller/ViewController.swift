//
//  ViewController.swift
//  CatLover
//
//  Created by Bruno Maciel on 7/3/20.
//  Copyright © 2020 Bruno Maciel. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController {
    
    @IBOutlet weak var collectView_cats: UICollectionView!
    
    var imgurImages: [ImgurImage] = []
    var selectedImage: UIImage?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadCatImages()
    }
    
    private func loadCatImages() {
        /*
         * Faz a requisação a API
         * retorna objeto Data, que possui uma lista de Posts do site
         * cada Post pode conter um conjunto de imagens
         * verifica se o link da imagem está no formato aceito (no caso defini que seriam ".png", ".jpg" e ".jpeg")
         * verificação necessária, pois alguns links estão no formato de video ".mp4"
         */
        ImgurAPI.requestCatImages { (imgurData) -> (Void) in
            if let imgurData = imgurData {
                for post in imgurData.data {
                    if let imagesAvailable = post.images {
                        for image in imagesAvailable {
                            if image.link.hasSuffix(".png") || image.link.hasSuffix(".jpg") || image.link.hasSuffix(".jpeg") {
                                self.imgurImages.append(image)
                            }
                            // else { print("Formato não aceito: \(image.link)") }
                        }
                    }
                }
                
                // Dispatch async para exibir as imagens na CollectionView
                DispatchQueue.main.async {
                    self.collectView_cats.reloadData()
                }
            }
            // Caso haja qualquer problema com a request, exibe alerta
            else { self.showAlertFail() }
        }
        
    }
    
    private func showAlertFail() {
        let alert = UIAlertController(title: "Erro", message: "Falha ao retornar dados do servidor.", preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Navigation para tela de visualização da imagem em tamanho maior
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "largerImageSegue" {
            if let destinationVC = segue.destination as? LargeImageViewController {
                destinationVC.image = self.selectedImage
            }
        }
    }
    
    @IBAction func reloadImages(_ sender: UIButton) {
        imgurImages = []
        collectView_cats.reloadData()
        loadCatImages()
    }
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Total images: \(imgurImages.count)")
        return imgurImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgurImage", for: indexPath) as! ImgurImageCollectionViewCell
        cell.delegate = self
        cell.prepareCell(with: imgurImages[indexPath.row])
        
        return cell
    }
    
}


extension ViewController: ImgurImageCellDelegate {
    // Faz o acesso ao botão contido em cada CollectionViewCell que leva a tela de visualização da imagem em tamanho maior
    func showLarger(_ image: UIImage?) {
        if image != nil {
            self.selectedImage = image
            performSegue(withIdentifier: "largerImageSegue", sender: nil)
        }
    }
}
