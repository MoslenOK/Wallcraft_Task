//
//  ViewController.swift
//  Wallcraft_Task
//
//  Created by DENIS SYTYTOV on 05.12.2021.
//

import UIKit

class ViewController: UIViewController, UnsplashManagerDeligate {
    func didUpdateUnsplashResult(_ unsplashManager: UnsplashManager, unsplashResultModel: UnsplashResultModel) {
        DispatchQueue.main.async {
            self.ImageView.load(urlString: unsplashResultModel.url)
            self.idLabel.text = "id: \(unsplashResultModel.id)"
            self.nameLabel.text = "Author name: \(unsplashResultModel.name)"
            
            if let safeDiscrition = unsplashResultModel.description{
                self.descriptionLabel.text = "Desciption: \(safeDiscrition)"
            }else{
                self.descriptionLabel.text = ""
            }
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
    var unsplashManager = UnsplashManager()
    
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func goButton(_ sender: UIButton) {
        unsplashManager.GetResult()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unsplashManager.delegate = self
        unsplashManager.GetResult()
    }
}


extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
